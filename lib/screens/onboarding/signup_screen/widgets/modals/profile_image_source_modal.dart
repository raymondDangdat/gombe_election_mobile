import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../widgets/long_divider.dart';

Future showProfileImageSourceModal(
  BuildContext importedContext,
) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(modalRadius.r),
                    topRight: Radius.circular(modalRadius.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        SourceOption(
                            icon: cameraSourceIcon,
                            option: "Camera",
                            onTap: () async {}),
                        SourceOption(
                            icon: gallerySourceIcon,
                            option: "Gallery",
                            onTap: () async {}),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    },
  );
}

class SourceOption extends StatelessWidget {
  final String icon;
  final String option;
  final String trailingIcon;
  final VoidCallback onTap;
  final bool showDivider;
  final Color textColor;
  const SourceOption(
      {super.key,
      required this.icon,
      required this.option,
      required this.onTap,
      this.textColor = const Color.fromRGBO(0, 6, 16, 1),
      this.showDivider = true,
      this.trailingIcon = forwardIconSvg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                  child: BodyTextPrimaryWithLineHeight(
                text: option,
                textColor: textColor,
              )),
              SvgPicture.asset(trailingIcon),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          if (showDivider)
            Column(
              children: [
                const LongDivider(),
                SizedBox(
                  height: 20.h,
                ),
              ],
            )
        ],
      ),
    );
  }
}
