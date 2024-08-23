import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/string_constants.dart';
import '../../../../../widgets/close_icon_widget.dart';

Future<void> showForgotPINInfoDialog(
  BuildContext importedContext, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => const ForgotPINInfoDialog());
}

class ForgotPINInfoDialog extends StatefulWidget {
  const ForgotPINInfoDialog({super.key});

  @override
  State<ForgotPINInfoDialog> createState() => _ForgotPINInfoDialogState();
}

class _ForgotPINInfoDialogState extends State<ForgotPINInfoDialog> {
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
          height: 325,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CloseIconWidget(),
              const BodyTextPrimaryWithLineHeight(
                text: "An OTP code will be sent to your email or phone number.",
                alignCenter: true,
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
              ),
              SizedBox(
                height: 10.h,
              ),
              const BodyTextPrimaryWithLineHeight(
                text:
                    "Then, set your new payment PIN. Enter a unique but easy to remember PIN.",
                alignCenter: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              OutlineBtn(cancel, () {
                Navigator.pop(context);
              })
            ],
          ),
        ));
  }
}
