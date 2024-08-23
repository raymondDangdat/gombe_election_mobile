import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../widgets/close_icon_widget.dart';
import '../../../../widgets/custom_snack_back.dart';

Future<void> showCancelTransactionInfoDialog(
  BuildContext importedContext, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => const CancelTransactionInfoDialog());
}

class CancelTransactionInfoDialog extends StatefulWidget {
  const CancelTransactionInfoDialog({
    super.key,
  });

  @override
  State<CancelTransactionInfoDialog> createState() =>
      _CancelTransactionInfoDialogState();
}

class _CancelTransactionInfoDialogState
    extends State<CancelTransactionInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 250,
          verticalPadding: 20,
          horizontalPadding: 8,
          useHeight: true,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: BodyTextPrimaryWithLineHeight(
                        text:
                            "Are you sure you want to cancel\n this transaction?",
                        alignCenter: true,
                        textColor: primaryTextColor,
                        fontWeight: semiBoldFont,
                      ),
                    ),
                    CloseIconWidget(),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Consumer<AuthenticationProvider>(
                    builder: (ctx, authProvider, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (authProvider.resMessage != '') {
                      customSnackBar(
                        context,
                        authProvider.resMessage,
                      );

                      ///Clear the response message to avoid duplicate
                      authProvider.clear();
                    }
                  });
                  return MainButton("Yes, Cancel Transaction", () async {});
                }),
                SizedBox(
                  height: 20.h,
                ),
                OutlineBtn("No, Don’t Cancel", () {
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ));
  }
}
