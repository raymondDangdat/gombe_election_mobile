import 'package:flutter/material.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class DepositTransactionsWidget extends StatelessWidget {
  const DepositTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(
      child: Consumer<AuthenticationProvider>(
          builder: (ctx, transactionProvider, child) {
        return Column(
          children: [],
        );
      }),
    ));
  }
}
