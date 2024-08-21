import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

enum PHASE {
    reg,
    voting,
    done
}
class ElectionProvider extends ChangeNotifier {
    static const String contractName = "TestElection";
    static const String ip = "HTTP://127.0.0.1";
    static const String port = "7545";
    final String _rpcURL = Platform.isAndroid ? "http://10.0.2.2:7545" : 'http://192.168.100.26:7545';
        // "http://$ip:$port";
    final String _wsURL = Platform.isAndroid ? "http://10.0.2.2:7545" : "ws://192.168.100.26:7545";
    final String _privateKey = "0x4cb412b7f10447c0094c1bd55311b11a720ca04e48db4dc85df5adf164461c3a";

    late Web3Client _client;
    late Credentials _credentials;
    late DeployedContract _contract;

    late ContractFunction registerCandidateFunction;
    late ContractFunction electionPhaseFunction;

    String adminAddress = "0x9b35df56A245b68D640941baC86875477bE13B90";
    String voterAddress = "0x8eEAd95e80195B8E5655bB0eDf3226EC7C458C8c";

    String currentElectionStage = "NA";

    List<Map<String, dynamic>> candidatesList = [];

    ElectionProvider(context){
        initialize(context);
    }

    initialize(context) async{
        debugPrint("Initializing Constructor======");
        _client = Web3Client(_rpcURL, http.Client(),
            socketConnector: (){
            debugPrint("Initializing web3client======");
            return IOWebSocketChannel.connect(_wsURL).cast<String>();
        }
        );

        final String abiStringFile = await DefaultAssetBundle.of(context).loadString("truffle-artifacts/$contractName.json");
        final abiJson = jsonDecode(abiStringFile);
        final abi = jsonEncode(abiJson['abi']);

        final contractAddress = EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);

        _credentials = EthPrivateKey.fromHex(_privateKey);
        _contract = DeployedContract(ContractAbi.fromJson(abi, contractName), contractAddress);

        registerCandidateFunction = _contract.function("addCandidate");
        electionPhaseFunction = _contract.function("currentElectionStage");

        getCurrentElectionStage();
        // await addCandidate("Yusuf Ahma", "APC", 40, "SSCE");

        // changeElectionState(PHASE.voting);

        // registerVoter("0x8eEAd95e80195B8E5655bB0eDf3226EC7C458C8c");
        // castVote(2);
        // getWinner();
        getAllCandidates();


    }

    Future<Map<String, dynamic>> getWinner() async {
        try {
            debugPrint("In Get Winner Method::::");

            // Call the getWinner function
            final result = await _client.call(
                contract: _contract,
                function: _contract.function('getWinner'),
                params: [],
            );

            // Extract the results
            final winnerName = result[0] as String;
            final winnerVoteCount = (result[1] as BigInt).toInt();
            final winnerParty = result[2] as String;

            debugPrint("Winner retrieved: $winnerName, Votes: $winnerVoteCount, Party: $winnerParty");

            // Return the result as a Map
            return {
                'name': winnerName,
                'voteCount': winnerVoteCount,
                'party': winnerParty,
            };
        } catch (e) {
            debugPrint("Error retrieving winner: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }

    Future<void> registerVoter(String voterAddress) async {
        try {
            debugPrint("In Register Voter Method::::");
            // Prepare the transaction
            final transaction = Transaction.callContract(
                contract: _contract,
                function: _contract.function('registerVoter'),
                parameters: [EthereumAddress.fromHex(voterAddress)], // Pass the voter's address
                from: EthereumAddress.fromHex(adminAddress), // Replace with your admin address
            );

            // Send the transaction with Ganache chain ID
            final result = await _client.sendTransaction(
                _credentials,
                transaction,
                chainId: 1337, // Chain ID for Ganache
            );

            debugPrint("Voter registered with transaction hash: $result");
        } catch (e) {
            debugPrint("Error registering voter: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }


    Future<void> addCandidate(String name, String party, int age, String qualification) async {
        try {
            debugPrint("In Add Candidate Method::::");
            // Prepare the transaction
            final transaction = Transaction.callContract(
                contract: _contract,
                function: _contract.function('addCandidate'),
                parameters: [
                    name,           // _name
                    party,          // _party
                    BigInt.from(age), // _age, cast to BigInt
                    qualification   // _qualification
                ],
                from: EthereumAddress.fromHex(adminAddress), // Replace with your admin address
            );

            // Send the transaction
            final result = await _client.sendTransaction(
                _credentials,
                transaction,
                chainId: 1337, // Change to the appropriate chain ID
                // fetchChainIdFromNetworkId: true,
            );

            debugPrint("Candidate added with transaction hash: $result");
        } catch (e) {
            debugPrint("Error adding candidate: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }



    Future<void> getElectionPhase() async{
        final result = await _client.call(contract: _contract, function: electionPhaseFunction, params: []);
        debugPrint("Current election Phase");
        debugPrint("The Current Election Phase:::: $result");
    }


    Future<PHASE?> getCurrentElectionStage() async {
        try {
            debugPrint("Getting current election stage::::");

            final response = await _client.call(
                contract: _contract,
                function: _contract.function('currentElectionStage'),
                params: [],
            );

            var stage = response[0].toInt(); // Convert the BigInt to int

            debugPrint("Current election stage: $stage");

            if (stage >= 0 && stage < PHASE.values.length) {
                currentElectionStage = stage == 0 ? "Registration" : stage == 1 ? "Voting" : "Done";
                notifyListeners();
                return PHASE.values[stage];
            } else {
                debugPrint("Unexpected stage value: $stage");
                return null; // Handle unexpected value appropriately
            }
        } catch (e) {
            debugPrint("Error getting current election stage: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }

    Future<void> changeElectionState(PHASE phase) async {
        try {
            debugPrint("In Change Election State Method::::");

            // Convert the enum to an integer (assuming PHASE is an enum in Solidity and Dart)
            final phaseIndex = phase.index;

            debugPrint("Phase to change:: $phaseIndex");

            // Prepare the transaction
            final transaction = Transaction.callContract(
                contract: _contract,
                function: _contract.function('changeState'),
                parameters: [BigInt.from(phaseIndex)], // Pass the enum index as a BigInt
                from: EthereumAddress.fromHex(adminAddress), // Replace with your admin address
            );

            // Send the transaction with Ganache chain ID
            final result = await _client.sendTransaction(
                _credentials,
                transaction,
                chainId: 1337, // Chain ID for Ganache
            );

            // addCandidate("Akpos Williams", "GP", 33, "HND");
            // getCurrentElectionStage();

            debugPrint("Election state changed with transaction hash: $result");
        } catch (e) {
            debugPrint("Error changing election state: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }


    Future<void> castVote(int candidateId) async {
        try {
            debugPrint("In Cast Vote Method::::");

            // Prepare the transaction
            final transaction = Transaction.callContract(
                contract: _contract,
                function: _contract.function('castVote'),
                parameters: [BigInt.from(candidateId)], // Convert candidateId to BigInt
                from: EthereumAddress.fromHex(voterAddress), // Replace with the voter's address
            );

            // Send the transaction with Ganache chain ID
            final result = await _client.sendTransaction(
                _credentials,
                transaction,
                chainId: 1337, // Chain ID for Ganache
            );

            debugPrint("Vote cast with transaction hash: $result");
        } catch (e) {
            debugPrint("Error casting vote: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }


    Future<List<Map<String, dynamic>>> getAllCandidates() async {


        try {
            debugPrint("In Get All Candidates Method::::");

            // Get the total number of candidates
            final candidatesCountResult = await _client.call(
                contract: _contract,
                function: _contract.function('candidatesCount'),
                params: [],
            );
            final candidatesCount = (candidatesCountResult[0] as BigInt).toInt();

            // Iterate through each candidate ID and retrieve the details
            for (int i = 1; i <= candidatesCount; i++) {
                final candidateResult = await _client.call(
                    contract: _contract,
                    function: _contract.function('candidates'),
                    params: [BigInt.from(i)],
                );

                // Extract candidate details
                final candidate = {
                    'id': (candidateResult[0] as BigInt).toInt(),
                    'name': candidateResult[1] as String,
                    'voteCount': (candidateResult[2] as BigInt).toInt(),
                    'party': candidateResult[3] as String,
                    'age': (candidateResult[4] as BigInt).toInt(),
                    'qualification': candidateResult[5] as String,
                };

                candidatesList.add(candidate);
                notifyListeners();
            }

            debugPrint("Candidates retrieved: ${candidatesList.length}");

            return candidatesList;
        } catch (e) {
            debugPrint("Error retrieving candidates: $e");
            throw e; // Optionally rethrow or handle the error as needed
        }
    }


}


