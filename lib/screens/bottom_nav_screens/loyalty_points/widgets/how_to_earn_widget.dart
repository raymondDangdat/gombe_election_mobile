import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/constants/string_constants.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/long_divider.dart';

class HowToEarnWidget extends StatelessWidget {
  const HowToEarnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      child:
          Consumer<AuthenticationProvider>(builder: (ctx, authProvider, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w, vertical: 20),
          decoration: BoxDecoration(
              color: whiteTextColor, borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(referralsIcon),
                        const SizedBox(
                          width: 5,
                        ),
                        const BodyTextLightWithLineHeight(
                          text: referrals,
                          textColor: Color.fromRGBO(0, 6, 16, 1),
                        )
                      ],
                    ),
                    SvgPicture.asset(dropdownIconSvg)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LongDivider(),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BodyTextLightWithLineHeight(
                        text: inviteFriends,
                        fontWeight: mediumFont,
                        textColor: blackTextColor,
                      ),
                      CustomContainerButton(
                        onTap: () {},
                        title: "+200 points",
                        fontWeight: mediumFont,
                        textColor: const Color.fromRGBO(29, 146, 19, 1),
                        bgColor: const Color.fromRGBO(36, 229, 19, 0.05),
                        borderRadius: 8,
                        horizontalPadding: 20,
                        verticalPadding: 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BodyTextLightWithLineHeight(
                    text:
                        "Note: You earn after your friends first fuel purchase.",
                    textColor: Color.fromRGBO(128, 131, 135, 1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SvgPicture.asset(inviteFriendsNowIcon),
                        const SizedBox(
                          width: 5,
                        ),
                        const BodyTextLightWithLineHeight(
                          text: "Invite friends now",
                          textColor: mainColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(referralsIcon),
                        const SizedBox(
                          width: 5,
                        ),
                        const BodyTextLightWithLineHeight(
                          text: purchases,
                          textColor: Color.fromRGBO(0, 6, 16, 1),
                        )
                      ],
                    ),
                    SvgPicture.asset(dropdownIconSvg)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LongDivider(),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyTextLightWithLineHeight(
                        text:
                            "Buy up to $nairaSign${returnAmount(amount: '100000')}",
                        fontWeight: mediumFont,
                        textColor: blackTextColor,
                      ),
                      CustomContainerButton(
                        onTap: () {},
                        title: "+500 points",
                        fontWeight: mediumFont,
                        textColor: const Color.fromRGBO(29, 146, 19, 1),
                        bgColor: const Color.fromRGBO(36, 229, 19, 0.05),
                        borderRadius: 8,
                        horizontalPadding: 20,
                        verticalPadding: 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      BodyTextLightWithLineHeight(
                        text: "Note: It has to be within 30 Days",
                        textColor: Color.fromRGBO(128, 131, 135, 1),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
