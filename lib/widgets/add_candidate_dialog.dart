import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gombe_election/Widgets/components.dart';
import 'package:gombe_election/Widgets/custom_text.dart';
import 'package:gombe_election/resources/constants/font_constants.dart';
import 'package:gombe_election/widgets/label_widget.dart';
import 'package:gombe_election/widgets/private_key_dialog.dart';
import 'package:gombe_election/widgets/select_party_widget.dart';
import 'package:gombe_election/widgets/select_qualification_widget.dart';
import 'package:gombe_election/widgets/textfields.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/election_provider.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../widgets/custom_snack_back.dart';
import '../screens/bottom_nav_screens/buy_fuel_flow/widgets/select_lga_widget.dart';

Future<void> showAddCandidateDialog(BuildContext importedContext,
    {bool barrierDismissible = false,
    String message = "Loading...",
    bool isCardPayment = true}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => const AddCandidateDialog(
            restorationId: "",
          ));
}

class AddCandidateDialog extends StatefulWidget {
  final String restorationId;
  const AddCandidateDialog(
      {super.key, this.restorationId = "date_picker_dialog"});

  @override
  State<AddCandidateDialog> createState() => _AddCandidateDialogState();
}

class _AddCandidateDialogState extends State<AddCandidateDialog>
    with RestorationMixin {
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

  final candidateNameController = TextEditingController();
  final candidateWalletAddressController = TextEditingController();

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
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(closeDialogIcon)),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Center(
                    child: BodyTextPrimaryWithLineHeight(
                      text: "Candidate Registration",
                      fontWeight: boldFont,
                      fontSize: 25,
                      textColor: primaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LabelWidget(label: "Candidate Name"),
                  Row(
                    children: [
                      Expanded(
                          child: CustomField(
                        "Candidate name. e.g Dangdat Delmut",
                        candidateNameController,
                        isCapitalizeSentence: true,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SelectLGAWidget(isAddCandidate: true,),
                  const SizedBox(
                    height: 10,
                  ),
                  if(electionProvider.selectedLGA != null)
                  const SelectPartyWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SelectQualificationWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const LabelWidget(label: "Candidate Date of Birth"),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                        child: BodyTextPrimaryWithLineHeight(
                          text: selectedDobString.isEmpty
                              ? "Select Candidate's DOB"
                              : selectedDobString,
                          fontWeight: semiBoldFont,
                          textColor: primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 40.h),
                  MainButton("Register Candidate", () async {
              
                    if (candidateNameController.text.isEmpty) {
                      customSnackBar(context, "Enter a valid Candidate name");
                    } else if (electionProvider.selectedLGA == null) {
                      customSnackBar(context, "Select Candidate LGA");
                    } else if (electionProvider.selectedParty == null) {
                      customSnackBar(context, "Select Candidate Party");
                    } else if (electionProvider.selectedQualification == null) {
                      customSnackBar(
                          context, "Select Candidate Highest Qualification");
                    } else if (selectedDobString.isEmpty) {
                      customSnackBar(context, "Select Candidate Date of birth");
                    } else {
                      final privateKey = await  showPrivateKeyDialog(context);
                      if(privateKey.isNotEmpty){
                        final isRegistered = await electionProvider.addCandidate(
                            name: candidateNameController.text,
                            dob: _selectedDate.value.toString(),
                            privateKey: privateKey,
                            context: context);
                        if (isRegistered) {
                          setState(() {
                            candidateNameController.text = "";
                            selectedDobString = "";
                            electionProvider.resetFilters();
                          });
                          electionProvider.getAllCandidates();
                          // Navigator.pop(context);
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
