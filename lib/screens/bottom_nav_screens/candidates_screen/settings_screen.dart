import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/resources/navigation_utils.dart';
import 'package:gombe_election/screens/get_started_screen/get_started_screen.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/white_app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(title: settings),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Consumer<AuthenticationProvider>(
                builder: (ctx, authProvider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  MainButton("Logout", () {
                    navToWithScreenName(
                        context: context,
                        screen: const GetStartedScreen(),
                        isPushAndRemoveUntil: true);
                  })
                ],
              );
            }),
          ))
        ],
      )),
    );
  }
}
