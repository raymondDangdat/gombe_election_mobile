import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/widgets/constant_widgets.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/white_app_bar.dart';
import '../onboarding/login_screen/login_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Screen Height ::: ${MediaQuery.of(context).size.height}");
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: whiteAppBar,
      body: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopPadding(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(gombeLog), fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1000,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24.r),
                          topLeft: Radius.circular(24.r))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: const BodyTextPrimaryWithLineHeight(
                            text: gombeElectionDApp,
                            fontSize: 32,
                            fontWeight: semiBoldFont,
                            textColor: primaryTextColor,
                            alignCenter: true,
                            lineHeight: 1.3,
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding.w),
                          child: Column(
                            children: [
                              MainButton(
                                getStarted,
                                () {
                                  navToWithScreenName(
                                      context: context,
                                      screen: const LoginScreen());
                                },
                                widget: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BodyTextPrimaryWithLineHeight(
                                      text: continueTo,
                                      fontWeight: semiBoldFont,
                                      textColor: white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
