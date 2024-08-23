import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Widgets/title_widget.dart';
import '../resources/constants/color_constants.dart';
import '../resources/constants/dimension_constants.dart';
import '../resources/constants/image_constant.dart';
import 'constant_widgets.dart';
import 'long_divider.dart';
import 'on_boarding_back_button.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool showDivider;
  final bool showBackButton;
  final Widget? actionWidget;
  const CustomAppbar(
      {super.key,
      required this.title,
      this.showDivider = true,
      this.showBackButton = true,
      this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: white,
      child: Column(
        children: [
          const TopPadding(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OnBoardingBackButton(
                  showPadding: false,
                  showBackButton: showBackButton,
                ),
                TitleWidget(
                  title: title,
                ),
                actionWidget ??
                    SvgPicture.asset(
                      backArrowSvg,
                      color: Colors.transparent,
                    ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          if (showDivider) const LongDivider(),
        ],
      ),
    );
  }
}
