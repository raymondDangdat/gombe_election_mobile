import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../resources/navigation_utils.dart';
import '../../bottom_nav_screens/bottom_nav_screen.dart';

class AccountSuccessfullyVerifiedScreen extends StatefulWidget {
  const AccountSuccessfullyVerifiedScreen({super.key});

  @override
  State<AccountSuccessfullyVerifiedScreen> createState() =>
      _AccountSuccessfullyVerifiedScreenState();
}

class _AccountSuccessfullyVerifiedScreenState
    extends State<AccountSuccessfullyVerifiedScreen> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(accountSuccessfullyVerifiedImg),
            SizedBox(
              height: 10.h,
            ),
            const BodyTextPrimaryWithLineHeight(
              text: accountSuccessfullyVerified,
              textColor: Color.fromRGBO(10, 43, 97, 1),
            )
          ],
        ),
      )),
    );
  }

  void _goNext() {
    navToWithScreenName(context: context, screen: const BottomNavScreen());
  }
}
