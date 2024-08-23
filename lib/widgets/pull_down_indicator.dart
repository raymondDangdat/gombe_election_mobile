import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PullDownIndicator extends StatelessWidget {
  final Color pullDownColor;
  const PullDownIndicator(
      {Key? key, this.pullDownColor = const Color.fromRGBO(167, 169, 175, 1)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91.w,
      height: 6.h,
      decoration: ShapeDecoration(
        color: pullDownColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
