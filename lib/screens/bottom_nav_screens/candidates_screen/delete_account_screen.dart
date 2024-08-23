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
import '../../../resources/styles_manager.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/textfields.dart';
import '../../../widgets/white_app_bar.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppbar(title: "Delete Account?"),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Consumer<AuthenticationProvider>(
                builder: (ctx, authProvider, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (authProvider.resMessage != '') {
                  customSnackBar(context, authProvider.resMessage);

                  ///Clear the response message to avoid duplicate
                  authProvider.clear();
                }
              });
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(deleteAccountImg),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomContainerButton(
                    onTap: () {},
                    title: "",
                    borderRadius: 12,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        const Row(
                          children: [
                            BodyTextLightWithLineHeight(
                              text: "Please Note:",
                              textColor: Color.fromRGBO(128, 131, 135, 1),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text:
                                "Deleting your account is a permanent action and cannot be undone. By proceeding, ",
                            style: getRichTextStyle(
                                fontSize: 16,
                                textColor: blackTextColor,
                                fontWeight: regularFont),
                            children: <TextSpan>[
                              TextSpan(
                                  style: getCustomTextStyle(
                                      fontSize: 16,
                                      textColor: blackTextColor,
                                      fontWeight: semiBoldFont),
                                  text: " you will lose access "),
                              TextSpan(
                                  style: getCustomTextStyle(
                                      fontSize: 16,
                                      textColor: blackTextColor,
                                      fontWeight: regularFont),
                                  text:
                                      "to all your data, benefits and services associated with your account,"),
                              TextSpan(
                                  style: getCustomTextStyle(
                                      fontSize: 16,
                                      textColor: blackTextColor,
                                      fontWeight: semiBoldFont),
                                  text:
                                      " including the remaining wallet balance. "),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isAccepted = !isAccepted;
                            });
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(isAccepted
                                  ? checkboxCheckedImg
                                  : checkboxUnchecked),
                              SizedBox(
                                width: 5.w,
                              ),
                              const BodyTextPrimaryWithLineHeight(
                                text: "Yes, I agree",
                                textColor: Color.fromRGBO(128, 131, 135, 1),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: "Account password"),
                        Row(
                          children: [
                            Expanded(
                                child: PwdField(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              isObscured: obscureText,
                              controller: passwordController,
                              hint: "Enter password here",
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MainButton(
                          "Yes, Delete Account",
                          () async {},
                          color: const Color.fromRGBO(255, 59, 48, 1),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ))
        ],
      )),
    );
  }
}
