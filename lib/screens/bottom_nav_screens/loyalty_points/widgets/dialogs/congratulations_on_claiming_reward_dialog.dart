import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/screens/bottom_nav_screens/loyalty_points/widgets/dialogs/show_claimed_points_dialogs.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/constants/string_constants.dart';

Future<void> showCongratulationsOnClaimingRewardDialog(BuildContext context,
    {bool barrierDismissible = false}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) =>
          const CongratulationOnClaimingRewardDialog());
}

class CongratulationOnClaimingRewardDialog extends StatefulWidget {
  const CongratulationOnClaimingRewardDialog({
    super.key,
  });

  @override
  State<CongratulationOnClaimingRewardDialog> createState() =>
      _CongratulationOnClaimingRewardDialogState();
}

class _CongratulationOnClaimingRewardDialogState
    extends State<CongratulationOnClaimingRewardDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: Consumer<AuthenticationProvider>(
            builder: (ctx, loyaltyPointProvider, child) {
          return CustomContainerButton(
            onTap: () {},
            title: "",
            borderRadius: 12,
            height: 450,
            verticalPadding: 20,
            // horizontalPadding: 20,
            useHeight: true,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  accountSuccessfullyVerifiedImg,
                  height: 32,
                  width: 32,
                ),
                const SizedBox(
                  height: 10,
                ),
                const BodyTextPrimaryWithLineHeight(
                  text: "Congratulations!",
                  textColor: primaryTextColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 108,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(congratulationsBgImg),
                          fit: BoxFit.cover)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      congratulationsImg,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BodyTextLightWithLineHeight(
                  text: "You have won ",
                  textColor: primaryTextColor,
                  alignCenter: true,
                  fontWeight: semiBoldFont,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    MainButton("See Details", () {
                      Navigator.pop(context);
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlineBtn(later, () {
                      Navigator.pop(context);
                    }),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
