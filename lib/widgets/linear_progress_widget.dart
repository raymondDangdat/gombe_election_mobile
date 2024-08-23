// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
//
// import '../resources/constants/color_constants.dart';
//
// class LinearProgressIndicatorWidget extends StatelessWidget {
//   final double progress;
//   final Color backGroundColor;
//   final Color activeColor;
//   const LinearProgressIndicatorWidget(
//       {Key? key,
//       required this.progress,
//       this.backGroundColor = const Color.fromRGBO(217, 217, 217, 1),
//       this.activeColor = savingsDeepGreenColor})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: LinearPercentIndicator(
//             // width: 297.w,
//             lineHeight: 4.h,
//             padding: EdgeInsets.zero,
//             barRadius: const Radius.circular(43),
//             percent: progress < 0 ? 0 : progress,
//             backgroundColor: backGroundColor,
//             progressColor: activeColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
