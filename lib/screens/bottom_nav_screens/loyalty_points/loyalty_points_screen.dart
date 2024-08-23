import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/screens/bottom_nav_screens/loyalty_points/widgets/earning_widget.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/main_color_app_bar.dart';
import '../widgets/notification_icon_widget.dart';
import '../widgets/support_icon_widget.dart';

class LoyaltyPointsScreen extends StatefulWidget {
  const LoyaltyPointsScreen({super.key});

  @override
  State<LoyaltyPointsScreen> createState() => _LoyaltyPointsScreenState();
}

class _LoyaltyPointsScreenState extends State<LoyaltyPointsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: blueAppBar,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthenticationProvider>(
              builder: (ctx, loyaltyPointsProvider, child) {
            return Column(
              children: [
                SizedBox(
                  height: 232,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        height: 232,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(appBarBgImg),
                                fit: BoxFit.cover)),
                        child: Column(
                          children: [
                            const TopPadding(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                      whiteBackArrowIcon)),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const BodyTextPrimaryWithLineHeight(
                                                text: loyaltyPoint,
                                                fontSize: 20,
                                                fontWeight: semiBoldFont,
                                                textColor: whiteTextColor,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      SupportIconWidget(),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      NotificationIconWidget(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const BodyTextPrimaryWithLineHeight(
                                  text: pointsBalance,
                                  textColor: white,
                                  fontSize: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(awardIcon),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  color: whiteTextColor,
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h, horizontal: horizontalPadding.w),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EarningsWidget(),
                    ],
                  ),
                )),
              ],
            );
          })),
    );
  }
}
