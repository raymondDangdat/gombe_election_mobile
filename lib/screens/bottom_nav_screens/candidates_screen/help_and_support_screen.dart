import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/white_app_bar.dart';
import '../../onboarding/signup_screen/widgets/modals/profile_image_source_modal.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(title: helpAndSupport),
          SizedBox(
            height: 20.h,
          ),
          Expanded(child: Consumer<AuthenticationProvider>(
              builder: (ctx, authProvider, child) {
            return SingleChildScrollView(
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
                            icon: findMideNearIcon,
                            option: findMideNearYou,
                            onTap: () {}),
                        SourceOption(
                            icon: chatWithSupportIcon,
                            option: chatWithSupport,
                            onTap: () {}),
                      ],
                    ),
                  )
                ],
              ),
            );
          }))
        ],
      )),
    );
  }
}
