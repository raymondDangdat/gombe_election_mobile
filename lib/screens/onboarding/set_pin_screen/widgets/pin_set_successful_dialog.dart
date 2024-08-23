import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/navigation_utils.dart';
import '../../../bottom_nav_screens/bottom_nav_screen.dart';

Future<void> showPinSetSuccessfulDialog(BuildContext context,
    {bool barrierDismissible = false}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => const PaymentSuccessfulDialog());
}

class PaymentSuccessfulDialog extends StatefulWidget {
  const PaymentSuccessfulDialog({
    super.key,
  });

  @override
  State<PaymentSuccessfulDialog> createState() =>
      _PaymentSuccessfulDialogState();
}

class _PaymentSuccessfulDialogState extends State<PaymentSuccessfulDialog> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      navToWithScreenName(
          context: context,
          screen: const BottomNavScreen(),
          isPushAndRemoveUntil: true);
      setState(() {
        // Here you can write your code for open new view
      });
    });
    super.initState();
  }

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
          height: 270,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(accountSuccessfullyVerifiedImg),
              SizedBox(
                height: 10.h,
              ),
              const BodyTextPrimaryWithLineHeight(
                text: "You account is fully set",
                textColor: primaryTextColor,
              )
            ],
          ),
        ));
  }
}
