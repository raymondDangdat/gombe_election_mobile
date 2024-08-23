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
import '../../../utils/constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/on_boarding_back_button.dart';
import '../../../widgets/on_boarding_header.dart';

class SetPinScreen extends StatefulWidget {
  final bool pinReset;
  const SetPinScreen({super.key, this.pinReset = false});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Color incompleteContainerColor = const Color(0xFF282828);
  Color completeContainerColor = const Color.fromRGBO(49, 184, 95, 1);
  @override
  void initState() {
    // errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    // errorController!.close();
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OnBoardingHeaderText(title: setPaymentPin),
                      SizedBox(
                        height: 5.h,
                      ),
                      BodyTextPrimaryWithLineHeight(
                          text: widget.pinReset
                              ? "Set your new payment PIN. Enter a unique but easy to remember PIN."
                              : thisWillBeRequiredForEveryPayment),
                      SizedBox(
                        height: 20.h,
                      ),
                      const LabelWidget(label: enterNewPin),
                      Row(
                        children: [
                          Expanded(
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                  color: Color.fromRGBO(0, 6, 16, 1),
                                  fontWeight: regularFont,
                                  fontSize: 16),
                              inputFormatters: numbersOnlyFormat,
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
                              // errorAnimationController: errorController,
                              controller: pinController,
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
                        height: 10.h,
                      ),
                      const LabelWidget(label: confirmPin),
                      Row(
                        children: [
                          Expanded(
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                  color: Color.fromRGBO(0, 6, 16, 1),
                                  fontWeight: regularFont,
                                  fontSize: 16),
                              inputFormatters: numbersOnlyFormat,
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
                              // errorAnimationController: errorController,
                              controller: confirmPinController,
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
                        height: 20.h,
                      ),
                      MainButton(continueTo, () async {
                        if (pinController.text.length < 4) {
                          customSnackBar(context, 'Enter a valid PIN');
                        } else if (pinController.text !=
                            confirmPinController.text) {
                          customSnackBar(context, "Please confirm your PIN");
                        } else {}
                      }),
                    ],
                  );
                }),
              )),
            ],
          )),
    );
  }
}
