import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gombe_election/models/candidate_model.dart';
import 'package:gombe_election/models/voter_model.dart';
import 'package:gombe_election/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../models/local_government_model.dart';

enum PHASE { reg, voting, done }

class ElectionProvider extends ChangeNotifier {
  static const String contractName = "TestElection";
  static const String ip = "HTTP://127.0.0.1";
  static const String port = "7545";
  final String _rpcURL = Platform.isAndroid
      ? "http://10.0.2.2:7545"
      : 'http://192.168.100.26:7545';
  // "http://$ip:$port";
  final String _wsURL =
      Platform.isAndroid ? "http://10.0.2.2:7545" : "ws://192.168.100.26:7545";
  final String _privateKey =
      "0x80eb2cee59576904c3dc6bc4c812b4049ef62b59c8a8889d840de75b49fc7861";

  late Web3Client _client;
  late Credentials _credentials;
  late DeployedContract _contract;

  String resMessage = "";

  bool isError = true;

  bool changingPhase = false;

  void clear() {
    resMessage = "";
    notifyListeners();
  }

  late ContractFunction registerCandidateFunction;
  late ContractFunction electionPhaseFunction;

  String adminAddress = "0x5CF1ac05B56502eed24fa3765030e3a7635d25C5";
  String voterAddress = "0x16f901508230A8531F005d2d501a4383AA21c127";

  String currentElectionPhase = "NA";
  int currentPhaseInt = 0;
  String nextElectionPhase = "NA";

  List<CandidateModel> candidatesListToDisplay = [];
  List<CandidateModel> reservedCandidates = [];

  ElectionProvider(context) {
    initialize(context);
  }

  initialize(context) async {
    debugPrint("Initializing Constructor======");
    _client = Web3Client(_rpcURL, http.Client(), socketConnector: () {
      debugPrint("Initializing web3client======");
      return IOWebSocketChannel.connect(_wsURL).cast<String>();
    });

    final String abiStringFile = await DefaultAssetBundle.of(context)
        .loadString("truffle-artifacts/$contractName.json");
    final abiJson = jsonDecode(abiStringFile);
    final abi = jsonEncode(abiJson['abi']);

    final contractAddress =
        EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);

    _credentials = EthPrivateKey.fromHex(_privateKey);
    _contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName), contractAddress);

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

      debugPrint(
          "Winner retrieved: $winnerName, Votes: $winnerVoteCount, Party: $winnerParty");

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

  LGA? selectedLGA;

  String? selectedQualification;
  String? selectedParty;

  void updateSelectedLGA(LGA? option) {
    selectedLGA = option;
    notifyListeners();
  }

  void updateSelectedParty(String? option) {
    selectedParty = option;
    notifyListeners();
  }

  void updateSelectedQualification(String? option) {
    selectedQualification = option;
    notifyListeners();
  }

  void resetFilters() {
    selectedQualification = null;
    selectedParty = null;
    selectedLGA = null;
    votersToDisplay = [];
    candidatesListToDisplay = [];
    votersToDisplay.addAll(reservedVoters);
    candidatesListToDisplay.addAll(reservedCandidates);
    notifyListeners();
  }

  Future<bool> registerVoter(String voterAddress,
      {required BuildContext context,
      required String lga,
      required String name}) async {
    isError = true;
    bool isRegistered = false;
    notifyListeners();
    try {
      debugPrint("In Register Voter Method::::");
      // Prepare the transaction
      showLoader(context, message: "Registering Voter...");
      final transaction = Transaction.callContract(
        contract: _contract,
        function: _contract.function('registerVoter'),
        parameters: [
          EthereumAddress.fromHex(voterAddress),
          lga,
          name
        ], // Pass the voter's address
        from: EthereumAddress.fromHex(
            adminAddress), // Replace with your admin address
      );

      // Send the transaction with Ganache chain ID
      final result = await _client.sendTransaction(
        _credentials,
        transaction,
        chainId: 1337, // Chain ID for Ganache
      );

      isRegistered = true;
      isError = false;
      resMessage = "Voter Registered";
      notifyListeners();
      popLoader(context: context);

      debugPrint("Voter registered with transaction hash: $result");
    } catch (e) {
      isError = true;
      notifyListeners();
      resMessage = "Unable to register voter";
      popLoader(context: context);
      notifyListeners();
      debugPrint("Error registering voter: $e");
      throw e; // Optionally rethrow or handle the error as needed
    }

    return isRegistered;
  }

  Future<bool> addCandidate(
      {required String name,
      required String dob,
      required BuildContext context}) async {
    bool registered = false;
    showLoader(context, message: "Registering Voter...");
    try {
      debugPrint("In Add Candidate Method::::");
      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: _contract,
        function: _contract.function('addCandidate'),
        parameters: [
          name, // _name
          selectedParty ?? "", // _party
          dob, //
          selectedQualification ?? "", // _qualification
          selectedLGA?.id ?? ""
        ],
        from: EthereumAddress.fromHex(
            adminAddress), // Replace with your admin address
      );

      // Send the transaction
      final result = await _client.sendTransaction(
        _credentials,
        transaction,
        chainId: 1337, // Change to the appropriate chain ID
        // fetchChainIdFromNetworkId: true,
      );

      popLoader(context: context);

      registered = true;
      debugPrint("Candidate added with transaction hash: $result");
      return registered;
    } catch (e) {
      popLoader(context: context);
      debugPrint("Error adding candidate: $e");
      throw e; // Optionally rethrow or handle the error as needed
    }
  }

  Future<void> getElectionPhase() async {
    final result = await _client
        .call(contract: _contract, function: electionPhaseFunction, params: []);
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
        currentElectionPhase = stage == 0
            ? "Registration"
            : stage == 1
                ? "Voting"
                : "Done";
        nextElectionPhase = stage == 0 ? "Voting" : "Done";
        currentPhaseInt = stage;
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

  Future<void> changeElectionState({required BuildContext context, required String address}) async {
    isError = true;
    notifyListeners();
    try {
      showLoader(context, message: "Changing election phase...");
      debugPrint("In Change Election State Method::::");
      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: _contract,
        function: _contract.function('changeState'),
        parameters: [
          BigInt.from(currentPhaseInt == 0 ? 1 : 2)
        ], // Pass the enum index as a BigInt
        from: EthereumAddress.fromHex(
            address), // Replace with your admin address
      );
      final result = await _client.sendTransaction(
        _credentials,
        transaction,
        chainId: 1337, // Chain ID for Ganache
      );
      getCurrentElectionStage();
      debugPrint("Election state changed with transaction hash: $result");
      popLoader(context: context);
      isError = false;
      resMessage = "Election phase changed";
      notifyListeners();
    } catch (e) {
      popLoader(context: context);
      resMessage = "Could not change election phase";
      notifyListeners();
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
        from: EthereumAddress.fromHex(
            voterAddress), // Replace with the voter's address
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

  bool loadingAllCandidates = false;
  Future<bool> getAllCandidates() async {
    bool requestFetched = false;
    loadingAllCandidates = true;
    candidatesListToDisplay = [];
    reservedCandidates = [];
    notifyListeners();
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
          'dob': candidateResult[4] as String,
          'lga': candidateResult[6] as String,
          'qualification': candidateResult[5] as String,
        };

        candidatesListToDisplay.add(CandidateModel(
            name: '${candidate["name"] ?? ""}',
            lga: '${candidate["lga"] ?? "NA"}',
            voteCount: candidate["voteCount"] == null
                ? 0
                : candidate["voteCount"] as int,
            id: candidate["id"] == null ? 0 : candidate["id"] as int,
            party: '${candidate["party"]}',
            qualification: '${candidate["qualification"]}',
            dob: '${candidate["dob"]}'));
        loadingAllCandidates = false;
        notifyListeners();
      }
      reservedCandidates.addAll(candidatesListToDisplay);
      notifyListeners();
      debugPrint("Candidates retrieved: ${candidatesListToDisplay.length}");

      return requestFetched;
    } catch (e) {
      debugPrint("Error retrieving candidates: $e");
      throw e; // Optionally rethrow or handle the error as needed
    }
  }

  void filterVoters() {
    votersToDisplay =
        reservedVoters.where((voter) => selectedLGA?.id == voter.lga).toList();
    notifyListeners();
  }

  void filterCandidates() {
    candidatesListToDisplay = reservedCandidates
        .where((candidate) => selectedLGA?.id == candidate.lga)
        .toList();
    notifyListeners();
  }

  List<VoterModel> votersToDisplay = [];
  List<VoterModel> reservedVoters = [];

  bool loadingAllVoters = false;
  Future<List<VoterModel>> getAllVoters({required BuildContext context}) async {
    votersToDisplay = [];
    reservedVoters = [];
    // Retrieve all voter addresses
    loadingAllVoters = true;
    notifyListeners();
    debugPrint("Get All voters called::::::::::::::::::");
    final voterAddresses = await _client.call(
      contract: _contract,
      function: _contract.function('getAllVoterAddresses'),
      params: [],
    );
    // Loop through each voter address and get their details
    for (var address in voterAddresses[0]) {
      final voterDetails = await getVoterDetails(
          EthereumAddress.fromHex(address.toString()),
          context: context);
      // debugPrint("Voter: ${ voterDetails}");
      votersToDisplay.add(VoterModel(
          name: voterDetails["name"] ?? "No Name",
          lga: voterDetails["lga"] ?? "No LGA",
          voterAddress: address,
          hasVoted: voterDetails["hasVoted"] ?? false));
    }

    debugPrint("Total Voters::::::::::::::::::: ${votersToDisplay.length}");
    loadingAllVoters = false;
    reservedVoters.addAll(votersToDisplay);
    notifyListeners();
    return votersToDisplay;
  }


  VoterModel? voter;

  EthereumAddress? currentUserAddress;
  void updateCurrentUserAddress(EthereumAddress? newAddress){
    currentUserAddress = newAddress;
    notifyListeners();
  }

  void updateVoter(VoterModel? newVoter){
    voter = newVoter;
    currentUserAddress = voter?.voterAddress;
    notifyListeners();
  }

  Future<VoterModel?> voterLogin(EthereumAddress voterAddress,
      {required BuildContext context, showLoading = true}) async {
    VoterModel? loginVoter;
    showLoader(context, message: "Getting your details");
    isError = true;
    voter = null;
    currentUserAddress = null;
    try {
      final voterDetails = await _client.call(
        contract: _contract,
        function: _contract.function('getVoterDetails'),
        params: [voterAddress],
      );

      debugPrint("Voter login detail::::::$voterDetails");
      final result = VoterModel(name: voterDetails[3] as String, lga: voterDetails[4] as String, hasVoted: voterDetails[0] as bool,
      voterAddress: voterAddress);

      if(result.name.isEmpty || result.lga.isEmpty){
        resMessage = "Invalid user";
        notifyListeners();
      }else{
        loginVoter = result;
      }
      popLoader(context: context);
      return loginVoter;
    } catch (error) {
      resMessage = "Could not login";
      notifyListeners();
      notifyListeners();
      debugPrint('Error logging in as voter: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>> getVoterDetails(EthereumAddress voterAddress,
      {required BuildContext context, showLoading = true}) async {
    isError = true;
    try {
      final voterDetails = await _client.call(
        contract: _contract,
        function: _contract.function('getVoterDetails'),
        params: [voterAddress],
      );
      debugPrint("Voter Details::: ${voterDetails}");
      return {
        'hasVoted': voterDetails[0] as bool,
        'vote': (voterDetails[1] as BigInt).toInt(),
        'isRegistered': voterDetails[2] as bool,
        'name': voterDetails[3] as String,
        'lga': voterDetails[4] as String
      };
    } catch (error) {
      resMessage = "Could not retrieve details";
      notifyListeners();
      debugPrint('Error getting voter details: $error');

      return {};
    }
  }

  Future<EthereumAddress> getElectionAdmin() async {
    final adminAddress = await _client.call(
      contract: _contract,
      function: _contract.function('electionAdmin'),
      params: [],
    );

    return adminAddress[0] as EthereumAddress;
  }
}

final listOfQualifications = [
  "Primary School Certificate",
  "Secondary School Certificate",
  "First Degree",
  "Masters",
  "PhD",
];

final listOfParties = ["APC", "PDP", "LP", "APGA", "NNPP", "YPP", "SDP", "ADC"];
