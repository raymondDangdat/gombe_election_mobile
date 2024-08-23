import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Widgets/components.dart';

Future<void> showDepositTransactionDetailDialog(
  BuildContext context, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) =>
          const DepositTransactionDetailDialog());
}

class DepositTransactionDetailDialog extends StatefulWidget {
  const DepositTransactionDetailDialog({
    super.key,
  });

  @override
  State<DepositTransactionDetailDialog> createState() =>
      _DepositTransactionDetailDialogState();
}

class _DepositTransactionDetailDialogState
    extends State<DepositTransactionDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 392,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ));
  }
}
