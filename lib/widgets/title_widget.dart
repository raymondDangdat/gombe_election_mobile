import 'package:flutter/material.dart';
import '../../../resources/constants/font_constants.dart';
import 'custom_text.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  const TitleWidget(
      {super.key,
      required this.title,
      this.textColor = const Color.fromRGBO(0, 6, 16, 1),
      this.fontSize = 20,
      this.fontWeight = semiBoldFont});

  @override
  Widget build(BuildContext context) {
    return SemiBold20px(
      text: title,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
    );
  }
}
