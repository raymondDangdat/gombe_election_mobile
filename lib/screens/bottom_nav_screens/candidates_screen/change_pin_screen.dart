import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/white_app_bar.dart';

class ChangePINScreen extends StatefulWidget {
  const ChangePINScreen({super.key});

  @override
  State<ChangePINScreen> createState() => _ChangePINScreenState();
}

class _ChangePINScreenState extends State<ChangePINScreen> {
  TextEditingController currentPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  // StreamController<ErrorAnimationType>? errorController;

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
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
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
            const CustomAppbar(title: changePaymentPin),
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
                        const LabelWidget(label: "Enter current PIN"),
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
                                    color: Colors.black,
                                    fontWeight: mediumFont),
                                length: 4,
                                obscureText: false,
                                autoFocus: true,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8.r),
                                  fieldHeight: 64,
                                  fieldWidth:
                                      MediaQuery.of(context).size.width <
                                              designScreenWidth
                                          ? 80.h
                                          : 80,
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
                                controller: currentPinController,
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
                        const LabelWidget(label: "Enter new PIN"),
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
                                    color: Colors.black,
                                    fontWeight: mediumFont),
                                length: 4,
                                obscureText: false,

                                autoFocus: true,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8.r),
                                  fieldHeight: 64,
                                  fieldWidth:
                                      MediaQuery.of(context).size.width <
                                              designScreenWidth
                                          ? 80.h
                                          : 80,
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
                                controller: newPinController,
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
                        const LabelWidget(label: "Confirm PIN"),
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
                                    color: Colors.black,
                                    fontWeight: mediumFont),
                                length: 4,
                                obscureText: false,

                                autoFocus: true,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8.r),
                                  fieldHeight: 64,
                                  fieldWidth:
                                      MediaQuery.of(context).size.width <
                                              designScreenWidth
                                          ? 80.h
                                          : 80,
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
                        MainButton(
                          saveChanges,
                          color: currentPinController.text.length < 4 ||
                                  confirmPinController.text.length < 4
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
