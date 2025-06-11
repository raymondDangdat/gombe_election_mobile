import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gombe_election/Widgets/components.dart';
import 'package:gombe_election/Widgets/custom_text.dart';
import 'package:gombe_election/resources/constants/font_constants.dart';
import 'package:gombe_election/widgets/label_widget.dart';
import 'package:gombe_election/widgets/textfields.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/election_provider.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../utils/functions.dart';
import '../../../../../widgets/custom_snack_back.dart';
import '../../../../../widgets/private_key_dialog.dart';
import '../../../buy_fuel_flow/widgets/select_lga_widget.dart';

Future<void> showAddVoterDialog(BuildContext importedContext,
    {bool barrierDismissible = false,
    String message = "Loading...",
    bool isCardPayment = true}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => const AddVoterDialog(
            restorationId: "",
          ));
}

class AddVoterDialog extends StatefulWidget {
  final String restorationId;
  const AddVoterDialog({super.key, this.restorationId = "date_picker_dialog"});

  @override
  State<AddVoterDialog> createState() => _AddVoterDialogState();
}

class _AddVoterDialogState extends State<AddVoterDialog> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  String selectedDobString = "";

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(DateTime.now().year - 18, 1, 1));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1950),
          lastDate: DateTime(DateTime.now().year - 18),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;

        selectedDobString =
            "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
      });
    }
  }

  final voterNameController = TextEditingController();
  final voterEmailAddressController = TextEditingController();
  final voterCardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child:
            Consumer<ElectionProvider>(builder: (ctx, electionProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (electionProvider.resMessage != '') {
              customSnackBar(context, electionProvider.resMessage,
                  isError: electionProvider.isError);

              ///Clear the response message to avoid duplicate
              electionProvider.clear();
            }
          });
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: whiteTextColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(closeDialogIcon)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Center(
                    child: BodyTextPrimaryWithLineHeight(
                      text: "Voter Registration",
                      fontWeight: boldFont,
                      fontSize: 25,
                      textColor: primaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LabelWidget(label: "Voter Full Name"),
                  Row(
                    children: [
                      Expanded(
                          child: CustomField(
                        "Voter name. e.g Dangdat Delmut",
                        voterNameController,
                        isCapitalizeSentence: true,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SelectLGAWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const LabelWidget(label: "Voter Date of Birth"),
                  CustomDropdownButton(title: selectedDobString.isEmpty
                      ? "Select Voter's DOB"
                      : selectedDobString, onTap: (){
                    _restorableDatePickerRouteFuture.present();
                  }, fontWeight: selectedDobString.isEmpty ? regularFont : semiBoldFont,
                  textColor: selectedDobString.isEmpty ? greyTextColor : blackTextColor,),
              
                  const SizedBox(
                    height: 10,
                  ),
              
                  const LabelWidget(label: "Email Address"),
                  Row(
                    children: [
                      Expanded(
                          child: CustomField(
                            type: TextInputType.emailAddress,
                              "Email Address", voterEmailAddressController))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const LabelWidget(label: "Voter Card Number"),
                  Row(
                    children: [
                      Expanded(
                          child: CustomField(
                              "Voter Card Number", voterCardNumberController))
                    ],
                  ),
                  SizedBox(height: 40.h),
                  MainButton("Register", () async {
                    if (voterNameController.text.isEmpty) {
                      customSnackBar(context, "Enter a valid voter name");
                    } else if (electionProvider.selectedLGA == null) {
                      customSnackBar(context, "Select voter LGA");
                    } else if (selectedDobString.isEmpty) {
                      customSnackBar(context, "Select Voter Date of birth");
                    } else if (!isValidEmail(voterEmailAddressController.text)) {
                      customSnackBar(context, "Enter valid email Address");
                    } else if (voterEmailAddressController.text.length < 10) {
                      customSnackBar(context, "Enter valid voter card number");
                    } else {
                      final privateKey = await  showPrivateKeyDialog(context);
                      if(privateKey.length >= 32){
                        final isRegistered = await electionProvider.registerVoter(
                            voterEmailAddressController.text,
                            context: context,
                            privateKey: privateKey,
                            name: voterNameController.text,
                            voterCardNumber: voterCardNumberController.text,
                            lga: electionProvider.selectedLGA?.id ?? "");
                        if (isRegistered) {
                          electionProvider.getAllVoters(context: context);
                          // Navigator.pop(context);
                          voterNameController.text = "";
                          voterEmailAddressController.text = "";
                          selectedDobString = "";
                          voterCardNumberController.text = "";
                          setState(() {});
                        }
                      }
              
                    }
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
