import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/constants/string_constants.dart';

Future<void> showClaimedPointsDialog(
  BuildContext context, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => ClaimedPointsDialog());
}

class ClaimedPointsDialog extends StatefulWidget {
  const ClaimedPointsDialog({
    super.key,
  });

  @override
  State<ClaimedPointsDialog> createState() => _ClaimedPointsDialogState();
}

class _ClaimedPointsDialogState extends State<ClaimedPointsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 450,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BodyTextPrimaryWithLineHeight(
                    text: "kkkk",
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BodyTextPrimaryWithLineHeight(
                          text: redeemedSuccessfully,
                          fontSize: 12,
                          textColor: Color.fromRGBO(64, 68, 76, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 102,
                    child: OutlineBtn(close, () {
                      Navigator.pop(context);
                    }),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(child: MainButton(viewCode, () {})),
                ],
              )
            ],
          ),
        ));
  }
}
