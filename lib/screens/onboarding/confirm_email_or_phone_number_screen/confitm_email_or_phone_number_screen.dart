import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/long_divider.dart';
import '../../../widgets/on_boarding_back_button.dart';
import '../../../widgets/on_boarding_header.dart';

class ConfirmEmailOrPhoneNumberScreen extends StatefulWidget {
  const ConfirmEmailOrPhoneNumberScreen({super.key});

  @override
  State<ConfirmEmailOrPhoneNumberScreen> createState() =>
      _ConfirmEmailOrPhoneNumberScreenState();
}

class _ConfirmEmailOrPhoneNumberScreenState
    extends State<ConfirmEmailOrPhoneNumberScreen> {
  TextEditingController verifyAccountController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 30;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Color incompleteContainerColor = const Color(0xFF282828);
  Color completeContainerColor = const Color.fromRGBO(49, 184, 95, 1);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          // top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopPadding(),
              const OnBoardingBackButton(),
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
                      customSnackBar(context, authProvider.resMessage,
                          isError: authProvider.isError);

                      ///Clear the response message to avoid duplicate
                      authProvider.clear();
                    }
                  });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OnBoardingHeaderText(title: enterVerificationCode),
                      SizedBox(
                        height: 5.h,
                      ),
                      const BodyTextPrimaryWithLineHeight(
                          text: yourVerificationCodeHasBeenSentTo),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                  color: Color.fromRGBO(0, 6, 16, 1),
                                  fontWeight: regularFont,
                                  fontSize: 16),
                              textStyle: const TextStyle(
                                  color: Colors.black, fontWeight: mediumFont),
                              length: 4,
                              obscureText: false,
                              autoFocus: true,
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8.r),
                                fieldHeight: 64,
                                fieldWidth: 80,
                                activeBorderWidth: 1,
                                selectedBorderWidth: 1,
                                inactiveBorderWidth: 1,
                                disabledBorderWidth: 1,
                                errorBorderWidth: 1,
                                activeColor: mainColor,
                                inactiveColor: filledColor,
                                inactiveFillColor: filledColor,
                                selectedColor: mainColor,
                                selectedFillColor: filledColor,
                                activeFillColor: filledColor,
                              ),
                              cursorColor: mainColor,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              controller: verifyAccountController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) {
                                debugPrint("Completed");
                                setState(() {});
                              },
                              onChanged: (value) {
                                debugPrint(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const LongDivider(),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BodyTextPrimaryWithLineHeight(
                            text: "00:${_start < 10 ? '0$_start' : _start}",
                            textColor: mainColor,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MainButton(verifyAccount, () async {}),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BodyTextPrimaryWithLineHeight(
                                text: "Didn’t receive the code?"),
                            SizedBox(
                              width: 5.w,
                            ),
                            const BodyTextPrimaryWithLineHeight(
                              text: "Resend OTP",
                              fontWeight: semiBoldFont,
                              textColor: mainColor,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
              )),
            ],
          )),
    );
  }
}
