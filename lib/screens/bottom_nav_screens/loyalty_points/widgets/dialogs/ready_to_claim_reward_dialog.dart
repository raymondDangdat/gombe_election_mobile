import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/constants/string_constants.dart';
import '../../../../../widgets/custom_snack_back.dart';

Future<void> showReadyToClaimRewardDialog(BuildContext context,
    {bool barrierDismissible = false}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => const ReadyToClaimRewardDialog());
}

class ReadyToClaimRewardDialog extends StatefulWidget {
  const ReadyToClaimRewardDialog({
    super.key,
  });

  @override
  State<ReadyToClaimRewardDialog> createState() =>
      _ReadyToClaimRewardDialogState();
}

class _ReadyToClaimRewardDialogState extends State<ReadyToClaimRewardDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 320,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Consumer<AuthenticationProvider>(
              builder: (ctx, loyaltyPointsProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (loyaltyPointsProvider.resMessage != '') {
                customSnackBar(context, loyaltyPointsProvider.resMessage);

                ///Clear the response message to avoid duplicate
                loyaltyPointsProvider.clear();
              }
            });
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(closeDialogIcon),
                    )
                  ],
                ),
                const BodyTextPrimaryWithLineHeight(
                  text: "Wooooooo! Ready to claim the \nreward now?",
                  alignCenter: true,
                  fontWeight: semiBoldFont,
                  textColor: Color.fromRGBO(16, 45, 91, 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                BodyTextPrimaryWithLineHeight(
                  text:
                      "5,000 points will be deducted\n from your points balance.",
                  alignCenter: true,
                  textColor: Color.fromRGBO(128, 131, 135, 1),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    MainButton(claimNow, () async {}),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlineBtn(later, () {
                      Navigator.pop(context);
                    }),
                  ],
                )
              ],
            );
          }),
        ));
  }
}
