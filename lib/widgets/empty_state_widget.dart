import 'package:flutter/material.dart';

import '../Widgets/custom_text.dart';
import '../resources/constants/color_constants.dart';
import '../resources/constants/font_constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  const EmptyStateWidget({super.key, this.message = "No Data Yet"});

  @override
  Widget build(BuildContext context) {
    return HeaderText(
      text: message,
      isUpperCase: false,
      fontWeight: boldFont,
      textColor: primaryTextColor,
      fontSize: 25,
    );
  }
}
