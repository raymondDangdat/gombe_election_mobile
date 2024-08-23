import 'package:web3dart/credentials.dart';

class VoterModel {
  final String name;
  final String lga;
  final EthereumAddress voterAddress;
  final bool hasVoted;

  VoterModel({
    required this.name,
    required this.lga,
    required this.hasVoted,
    required this.voterAddress,
  });
}
