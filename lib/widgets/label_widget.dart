import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/constants/font_constants.dart';
import 'custom_text.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  const LabelWidget(
      {Key? key,
      required this.label,
      this.textColor = const Color.fromRGBO(64, 68, 76, 1),
      this.fontWeight = regularFont,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTextWithLineHeight(
              text: label,
              textColor: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            )
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
      ],
    );
  }
}
