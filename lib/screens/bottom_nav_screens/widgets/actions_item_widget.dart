import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/box_shadow_widget.dart';
import '../add_deposit_flow/widgets/dialogs/add_voter_dialog.dart';

class DashboardActionWidget extends StatelessWidget {
  const DashboardActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
          color: white,
          boxShadow: const [containerBoxShadow],
          borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionItem(
              icon: addDepositIcon,
              onTap: () {
                showAddVoterDialog(context);
                // navToWithScreenName(
                //     context: context,
                //     screen: const SelectPaymentMethodScreen());
              },
              title: addDeposit),
          const VerticalDivider(),
          Consumer<AuthenticationProvider>(
              builder: (ctx, transactionProvider, child) {
            return ActionItem(
                icon: fuelPumpIcon, onTap: () {}, title: buyFuelNow);
          }),
          const VerticalDivider(),
          ActionItem(icon: loyaltyIcon, onTap: () {}, title: loyaltyPoint),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  const ActionItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            children: [
              SvgPicture.asset(icon),
              SizedBox(
                height: 5.h,
              ),
              BodyTextPrimaryWithLineHeight(
                text: title,
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
                fontSize: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 40,
      color: const Color.fromRGBO(239, 242, 247, 1),
    );
  }
}
