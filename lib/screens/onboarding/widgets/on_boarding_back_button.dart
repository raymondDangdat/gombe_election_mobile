import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/image_constant.dart';

class OnBoardingBackButton extends StatelessWidget {
  final bool showPadding;
  final bool showBackButton;
  const OnBoardingBackButton(
      {super.key, this.showPadding = true, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: showPadding ? horizontalPadding.w : 0),
      child: showBackButton
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(backButtonArrow))
          : Container(),
    );
  }
}
