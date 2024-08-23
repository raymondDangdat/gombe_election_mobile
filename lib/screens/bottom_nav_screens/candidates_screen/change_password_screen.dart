import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/textfields.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      body: SafeArea(child:
          Consumer<AuthenticationProvider>(builder: (ctx, authProvider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (authProvider.resMessage != '') {
            customSnackBar(context, authProvider.resMessage);

            ///Clear the response message to avoid duplicate
            authProvider.clear();
          }
        });
        return Column(
          children: [
            const CustomAppbar(title: changePassword),
            SizedBox(
              height: 20.h,
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
                        const LabelWidget(label: "Current password"),
                        Row(
                          children: [
                            Expanded(
                              child: PwdField(
                                hint: "Enter your old password here",
                                controller: oldPasswordController,
                                isObscured: obscure,
                                onChange: (value) {
                                  setState(() {
                                    debugPrint("$value");
                                  });
                                },
                                onTap: () {
                                  setState(() => obscure = !obscure);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(
                          label: "New password",
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PwdField(
                                hint: "Enter your new password here",
                                controller: newPasswordController,
                                isObscured: obscure,
                                onChange: (value) {
                                  setState(() {
                                    debugPrint("$value");
                                  });
                                },
                                onTap: () {
                                  setState(() => obscure = !obscure);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(
                          label: "Confirm password",
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PwdField(
                                hint: "Confirm your password here",
                                controller: confirmPasswordController,
                                isObscured: obscure,
                                onChange: (value) {
                                  setState(() {
                                    debugPrint("$value");
                                  });
                                },
                                onTap: () {
                                  setState(() => obscure = !obscure);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        MainButton(
                          saveChanges,
                          color: mainColor,
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
