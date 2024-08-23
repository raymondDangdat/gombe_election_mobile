import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class RewardsWidget extends StatelessWidget {
  const RewardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      child: Consumer<AuthenticationProvider>(
          builder: (ctx, loyaltyPointsProvider, child) {
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: 20.h, horizontal: horizontalPadding.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteTextColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(mideGiftBoxImg),
              ),
              const SizedBox(
                height: 20,
              ),
              const BodyTextLightWithLineHeight(
                text: "Mide Gift Box",
                fontWeight: semiBoldFont,
                textColor: primaryTextColor,
              ),
              SizedBox(
                height: 30.h,
              ),
              MainButton("Claim with 5000 points", () {})
            ],
          ),
        );
      }),
    );
  }
}
