import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class RecentTransactionHistoryWidget extends StatelessWidget {
  final bool isHomeScreen;
  const RecentTransactionHistoryWidget({super.key, this.isHomeScreen = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (ctx, transactionProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(),
      );
    });
  }
}
