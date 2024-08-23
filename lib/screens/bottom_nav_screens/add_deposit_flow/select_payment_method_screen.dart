import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/screens/bottom_nav_screens/add_deposit_flow/widgets/dialogs/add_voter_dialog.dart';

import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/white_app_bar.dart';
import '../../onboarding/signup_screen/widgets/modals/profile_image_source_modal.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(title: selectPaymentMethod),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Column(
              children: [
                CustomContainerButton(
                  onTap: () {},
                  title: "",
                  borderRadius: 12,
                  widget: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      SourceOption(
                          icon: cardIcon,
                          option: card,
                          onTap: () {
                            debugPrint("Tapped");
                            showAddVoterDialog(context);
                          }),
                      SourceOption(
                          icon: bankTransferIcon,
                          option: bankTransfer,
                          onTap: () {
                            showAddVoterDialog(context, isCardPayment: false);
                          }),
                      SourceOption(
                        icon: ussdIcon,
                        option: ussd,
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
