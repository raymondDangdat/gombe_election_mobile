import 'package:flutter/material.dart';

import '../../../../resources/constants/color_constants.dart';

class LinearProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final Color backGroundColor;
  final Color activeColor;
  const LinearProgressIndicatorWidget(
      {super.key,
      required this.progress,
      this.backGroundColor = const Color.fromRGBO(239, 242, 247, 1),
      this.activeColor = mainColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}
