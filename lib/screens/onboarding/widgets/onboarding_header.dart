import 'package:flutter/material.dart';

import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';

class OnBoardingHeaderText extends StatelessWidget {
  final String title;
  const OnBoardingHeaderText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BodyTextPrimaryWithLineHeight(
      text: title,
      fontWeight: semiBoldFont,
      fontSize: 32,
      textColor: primaryTextColor,
      alignCenter: true,
    );
  }
}
