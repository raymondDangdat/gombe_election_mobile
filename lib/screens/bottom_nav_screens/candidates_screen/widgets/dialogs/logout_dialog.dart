import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/font_constants.dart';

Future<void> showLogoutInfoDialog(BuildContext importedContext,
    {bool barrierDismissible = false,
    String message = "Loading...",
    bool isCardPayment = true}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => LogOutInfoDialog(
            isCardPayment: isCardPayment,
          ));
}

class LogOutInfoDialog extends StatefulWidget {
  final bool isCardPayment;
  const LogOutInfoDialog({super.key, this.isCardPayment = true});

  @override
  State<LogOutInfoDialog> createState() => _LogOutInfoDialogState();
}

class _LogOutInfoDialogState extends State<LogOutInfoDialog> {
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
          height: 150,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const BodyTextPrimaryWithLineHeight(
                    text: "Are you sure to Log Out?",
                    textColor: primaryTextColor,
                    fontWeight: semiBoldFont,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlineBtn("No", () {
                        Navigator.pop(context);
                      })),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: MainButton("Yes", () async {}),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
