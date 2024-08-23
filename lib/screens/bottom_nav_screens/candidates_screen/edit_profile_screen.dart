import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/textfields.dart';
import '../../../widgets/white_app_bar.dart';
import '../../onboarding/signup_screen/widgets/modals/profile_image_source_modal.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  File? profileImage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final auth = Provider.of<AuthenticationProvider>(context, listen: false);
      auth.clear();
    });

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(child:
          Consumer<AuthenticationProvider>(builder: (ctx, authProvider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (authProvider.resMessage != '') {
            customSnackBar(context, authProvider.resMessage,
                isError: authProvider.isError);

            ///Clear the response message to avoid duplicate
            authProvider.clear();
          }
        });
        return Column(
          children: [
            const CustomAppbar(title: editProfile),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: InkWell(
                onTap: () async {
                  profileImage = await showProfileImageSourceModal(context);
                  setState(() {});
                },
                child: Container(
                  height: 120,
                  width: 120,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          bottom: 10,
                          right: -7,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset(cameraIcon),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: horizontalPadding.w),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: fullName),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter your full name",
                                fullNameController,
                                isCapitalizeSentence: true,
                                type: TextInputType.name,
                                hasBorder: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(
                          label: emailOrPhoneNumber,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter your email or phone number here",
                                emailController,
                                enabled: false,
                                onChange: (value) {
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        authProvider.isLoading
                            ? const Center(child: CupertinoActivityIndicator())
                            : MainButton(
                                saveChanges,
                                color: fullNameController.text.isEmpty ||
                                        emailController.text.isEmpty
                                    ? const Color.fromRGBO(229, 230, 231, 1)
                                    : mainColor,
                                () async {},
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        );
      })),
    );
  }
}
