import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/constants/string_constants.dart';

Future<void> showFuelTransactionDetailDialog(
  BuildContext importedContext, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) =>
          const FuelingTransactionDetailDialog());
}

class FuelingTransactionDetailDialog extends StatefulWidget {
  const FuelingTransactionDetailDialog({super.key});

  @override
  State<FuelingTransactionDetailDialog> createState() =>
      _FuelingTransactionDetailDialogState();
}

class _FuelingTransactionDetailDialogState
    extends State<FuelingTransactionDetailDialog> {
  late Duration timeRemaining;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: whiteTextColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BodyTextPrimaryWithLineHeight(
                    text: "",
                    textColor: mainColor,
                    fontSize: 32,
                    fontWeight: semiBoldFont,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(closeDialogIcon))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(successIcon),
                    ),
                    Expanded(
                        child: Container(
                      height: 2,
                      color: const Color.fromRGBO(239, 242, 247, 1),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SvgPicture.asset(onGoingIcon),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BodyTextPrimaryWithLineHeight(
                          text: paymentSuccessful,
                          fontSize: 12,
                          textColor: Color.fromRGBO(64, 68, 76, 1),
                        ),
                        BodyTextPrimaryWithLineHeight(
                          text: Jiffy.parse(DateTime.now().toString()).format(
                            // pattern: 'dd MMM, yyyy hh:mm a',
                            pattern: 'dd MMM, yyyy',
                          ),
                          fontSize: 12,
                          textColor: const Color.fromRGBO(128, 131, 135, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ));
  }
}
