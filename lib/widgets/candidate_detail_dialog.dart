import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/models/voter_model.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/constants/dimension_constants.dart';
import 'package:gombe_election/widgets/textfields.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../widgets/close_icon_widget.dart';
import '../../../../../widgets/custom_snack_back.dart';
import '../models/local_government_model.dart';
import '../utils/functions.dart';

Future<void> showCandidateDetailDialog(BuildContext importedContext,
    {bool barrierDismissible = false}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => const DeleteAccountInfoDialog());
}

class DeleteAccountInfoDialog extends StatefulWidget {
  final bool isCardPayment;
  const DeleteAccountInfoDialog({super.key, this.isCardPayment = true});

  @override
  State<DeleteAccountInfoDialog> createState() =>
      _DeleteAccountInfoDialogState();
}

class _DeleteAccountInfoDialogState extends State<DeleteAccountInfoDialog> {
  final privateKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: Consumer<ElectionProvider>(
            builder: (ctx, electionProProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (electionProProvider.resMessage != '') {
              customSnackBar(context, electionProProvider.resMessage,
                  isError: electionProProvider.isError);

              ///Clear the response message to avoid duplicate
              electionProProvider.clear();
            }
          });
          return Container(
              decoration: BoxDecoration(
                  color: whiteTextColor,
                  borderRadius: BorderRadius.circular(16.r)),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CloseIconWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    const BodyTextPrimaryWithLineHeight(
                      text: "You action is irreversible\n Be sure of it!",
                      alignCenter: true,
                      textColor: red,
                      fontSize: 25,
                      fontWeight: boldFont,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hintTextColor,
                              image: DecorationImage(
                                  image: AssetImage(returnPartyLogo(
                                      electionProProvider
                                              .selectedCandidate?.party ??
                                          "")),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                          text: electionProProvider.selectedCandidate?.name ??
                              "NA",
                          textColor: primaryTextColor,
                          fontWeight: boldFont,
                          fontSize: 28,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                          text:
                              "Qualification: ${electionProProvider.selectedCandidate?.qualification}",
                          textColor: primaryTextColor,
                          fontWeight: semiBoldFont,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                            text:
                                "LGA: ${electionProProvider.selectedCandidate?.lga == "NA" ? "NA" : returnLGA(lgID: int.parse(electionProProvider.selectedCandidate!.lga))}",
                            textColor: primaryTextColor,
                            fontWeight: semiBoldFont,
                            fontSize: 16),
                        BodyTextPrimaryWithLineHeight(
                            text:
                                "Party: ${electionProProvider.selectedCandidate?.party}",
                            textColor: primaryTextColor,
                            fontWeight: semiBoldFont,
                            fontSize: 16),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                            text:
                                "Date of Birth: ${returnFormattedDate(electionProProvider.selectedCandidate!.dob)}",
                            textColor: primaryTextColor,
                            fontWeight: semiBoldFont,
                            fontSize: 14),
                        BodyTextPrimaryWithLineHeight(
                            text:
                                "Age: ${calculateAge(DateTime.parse(electionProProvider.selectedCandidate!.dob))}",
                            textColor: primaryTextColor,
                            fontWeight: semiBoldFont,
                            fontSize: 16),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomField("Enter your private key", privateKeyController),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthenticationProvider>(
                        builder: (ctx, authProvider, child) {
                      return MainButton(
                        "Vote",
                        () async {
                          if (privateKeyController.text.length < 32) {
                            customSnackBar(
                                context, "Enter a valid private key");
                          } else {
                            final voted = await electionProProvider.castVote(
                                electionProProvider.selectedCandidate?.id ?? 0,
                                context: context,
                                privateKey: privateKeyController.text);
                            debugPrint("Voted::: $voted");
                            await electionProProvider.getAllCandidates();
                            electionProProvider.filterCandidates(
                                lgId: electionProProvider.voter?.lga ?? "");
                            if (voted) {
                              final updatedVoter = VoterModel(
                                  name: electionProProvider.voter?.name ?? "NA",
                                  lga: electionProProvider.voter?.lga ?? "NA",
                                  hasVoted: true,
                                  voterAddress:
                                      electionProProvider.voter!.voterAddress);
                              electionProProvider.updateVoter(updatedVoter);
                              Navigator.pop(context);
                            }
                          }
                        },
                        color: Colors.red,
                      );
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer<AuthenticationProvider>(
                        builder: (ctx, authProvider, child) {
                      return MainButton("Back", () async {
                        Navigator.pop(context);
                      });
                    }),
                  ],
                ),
              ));
        }));
  }
}
