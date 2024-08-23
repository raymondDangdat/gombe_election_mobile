import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/white_app_bar.dart';

class BankTransferScreen extends StatelessWidget {
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(title: bankTransfer),
          SizedBox(
            height: 10.h,
          ),
        ],
      )),
    );
  }
}
