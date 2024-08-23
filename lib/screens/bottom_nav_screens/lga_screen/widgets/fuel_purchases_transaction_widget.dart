import 'package:flutter/material.dart';
import 'package:gombe_election/providers/authentication_provider.dart';

import 'package:provider/provider.dart';

class FuelPurchaseTransactionsWidget extends StatelessWidget {
  const FuelPurchaseTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<AuthenticationProvider>(
        builder: (ctx, transactionProvider, child) {
      return RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Consumer<AuthenticationProvider>(
              builder: (ctx, transactionProvider, child) {
            return const Column(
              children: [],
            );
          }),
        ),
      );
    }));
  }
}
