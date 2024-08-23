import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/long_divider.dart';
import '../../../widgets/white_app_bar.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthenticationProvider>(
              builder: (ctx, authProvider, child) {
            return Column(
              children: [
                const CustomAppbar(title: referAndEarn),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: horizontalPadding.w),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            const BodyTextPrimaryWithLineHeight(
                              text: yourReferralCode,
                              textColor: Color.fromRGBO(64, 68, 76, 1),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            CustomContainerButton(
                              onTap: () {},
                              title: "",
                              borderRadius: 8,
                              borderColor:
                                  const Color.fromRGBO(217, 218, 219, 1),
                              widget: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BodyTextPrimaryWithLineHeight(
                                    text: "0000",
                                    textColor: blackTextColor,
                                    fontWeight: mediumFont,
                                  ),
                                  Row(
                                    children: [
                                      const BodyTextPrimaryWithLineHeight(
                                        text: copy,
                                        textColor: blackTextColor,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: SvgPicture.asset(copyIcon),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 20,
                              bottom: 50,
                              left: horizontalPadding.w,
                              right: horizontalPadding.w),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: whiteTextColor),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyTextPrimaryWithLineHeight(
                                      text: referralHistory,
                                      textColor: Color.fromRGBO(0, 6, 16, 1),
                                    ),
                                    BodyTextPrimaryWithLineHeight(
                                      text: seeAll,
                                      fontWeight: mediumFont,
                                      fontSize: 14,
                                      textColor:
                                          Color.fromRGBO(128, 131, 135, 1),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              const LongDivider(),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          )),
                    ],
                  ),
                ))
              ],
            );
          })),
    );
  }
}
