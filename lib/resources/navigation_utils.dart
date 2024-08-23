import 'package:flutter/material.dart';

// void navTo(
//     {required BuildContext context,
//     required String path,
//     bool isReplacement = false,
//     bool isPushAndRemoveUntil = false}) {
//   if (isReplacement) {
//     Navigator.pushReplacementNamed(context, path);
//   } else if (isPushAndRemoveUntil) {
//     Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
//   } else {
//     Navigator.pushNamed(context, path);
//   }
// }

void navToWithScreenName(
    {required BuildContext context,
    required Widget screen,
    bool isReplacement = false,
    bool isPushAndRemoveUntil = false}) {
  if (isReplacement) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  } else if (isPushAndRemoveUntil) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
