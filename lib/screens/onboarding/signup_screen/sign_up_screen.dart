import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/screens/onboarding/signup_screen/widgets/modals/profile_image_source_modal.dart';
import 'package:gombe_election/utils/functions.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../resources/navigation_utils.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/on_boarding_back_button.dart';
import '../../../widgets/on_boarding_header.dart';
import '../../../widgets/textfields.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralController = TextEditingController();

  bool obscure = true;

  File? profileImage;

  @override
  void initState() {
    referralController.text = kDebugMode ? "MIDE-31074260" : "";
    // referralController.text = kDebugMode ? "MIDE-12808261" : "";
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthenticationProvider>(
              builder: (ctx, authProvider, child) {
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
                const TopPadding(),
                const Row(
                  children: [
                    OnBoardingBackButton(),
                  ],
                ),
                SizedBox(
                  height: topPadding.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: const Column(
                    children: [
                      OnBoardingHeaderText(title: signUp),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      children: [
                        const BodyTextPrimaryWithLineHeight(
                            text: createAnAccountToContinue),
                        SizedBox(
                          height: 30.h,
                        ),
                        InkWell(
                          onTap: () async {
                            profileImage =
                                await showProfileImageSourceModal(context);
                            setState(() {});
                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: profileImage == null
                                    ? const DecorationImage(
                                        image: AssetImage(userImg))
                                    : DecorationImage(
                                        image: FileImage(profileImage!),
                                        fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(
                                  color: const Color.fromRGBO(0, 6, 16, 1),
                                )),
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
                                isCapitalizeSentence: false,
                                onChange: (value) {
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(label: referralCodeOptional),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter referral code here",
                                referralController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const LabelWidget(
                          label: setPassword,
                        ),
                        PwdField(
                          hint: "Set your password here",
                          controller: passwordController,
                          isObscured: obscure,
                          onTap: () {
                            setState(() => obscure = !obscure);
                          },
                        ),
                        SizedBox(height: 16.h),
                        const LabelWidget(
                          label: confirmPassword,
                        ),
                        PwdField(
                          hint: "Confirm your password here",
                          controller: confirmPasswordController,
                          isObscured: obscure,
                          onTap: () {
                            setState(() => obscure = !obscure);
                          },
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        authProvider.isLoading
                            ? const Center(child: CupertinoActivityIndicator())
                            : MainButton(
                                signUp,
                                () async {
                                  if (fullNameController.text.trim().length <
                                      5) {
                                    customSnackBar(
                                        context, "Enter a valid full name");
                                  } else if (emailController.text.length < 5) {
                                    customSnackBar(
                                      context,
                                      "Please enter a valid email or phone number",
                                    );
                                  } else if (passwordController.text
                                          .trim()
                                          .length <
                                      8) {
                                    customSnackBar(context,
                                        "Password must be at least 8 characters");
                                  } else if (!passwordController.text
                                      .isValidPassword()) {
                                    customSnackBar(context,
                                        "Password must contain at least one uppercase letter, one lowercase letter, one numeric digit, and one special character.");
                                  } else {
                                    // await authProvider.createAccount(context: context);
                                  }
                                },
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            navToWithScreenName(
                                context: context, screen: const LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BodyTextPrimaryWithLineHeight(
                                  text: alreadyHaveAnAccount),
                              SizedBox(
                                width: 5.w,
                              ),
                              const BodyTextPrimaryWithLineHeight(
                                text: login,
                                fontWeight: semiBoldFont,
                                textColor: mainColor,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
