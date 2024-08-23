import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../resources/constants/color_constants.dart';
import '../resources/constants/font_constants.dart';

void customSnackBar(BuildContext context, String message,
    {bool isError = true}) {
  return showTopSnackBar(
    Overlay.of(context),
    Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isError
              ? const Color.fromRGBO(255, 59, 48, 1)
              : const Color.fromRGBO(29, 146, 19, 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 14,
                    decorationColor: isError
                        ? const Color.fromRGBO(255, 59, 48, 1)
                        : const Color.fromRGBO(29, 146, 19, 1),
                    fontWeight: mediumFont,
                    color: white),
              ),
            )
          ],
        )),
  );
}
