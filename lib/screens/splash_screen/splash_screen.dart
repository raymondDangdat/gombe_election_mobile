import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/connectivity.dart';
import '../../resources/constants/constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/navigation_utils.dart';
import '../get_started_screen/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
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
      backgroundColor: splashBgColor,
      body: SafeArea(
          bottom: false,
          top: false,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: splashBgColor),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250.w,
                    child: Image.asset(gombeLog)
                        .animate()
                        .fadeIn() // uses `Animate.defaultDuration`
                        .scale(duration: 1.seconds),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _goNext() async {
    debugPrint("CONNECTED TO THE INTERNET============= IN INIT STATE");

    final sharedPref = await SharedPreferences.getInstance();

    // Check for Internet Connection
    bool isConnected = await connectionChecker();
    // Get keep me Logged In Value
    debugPrint("CONNECTED TO THE INTERNET=============");

    //OPEN ONBOARDING SCREENS
    if (sharedPref.getBool(showOnBoarding) == null ||
        sharedPref.getBool(showOnBoarding) == true) {
      if (mounted) {
        navToWithScreenName(context: context, screen: const GetStartedScreen());
      }
    } else {
      navToWithScreenName(context: context, screen: const GetStartedScreen());
    }
  }
}
