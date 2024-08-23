import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  bool useDifferentCard = false;
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  bool obscureCvv = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(
            title: confirmDeposit,
            showDivider: false,
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      )),
    );
  }
}
