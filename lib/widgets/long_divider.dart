import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LongDivider extends StatelessWidget {
  final Color color;
  final double height;
  const LongDivider(
      {super.key,
      this.color = const Color.fromRGBO(229, 230, 231, 1),
      this.height = 0.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h,
      color: color,
    );
  }
}
