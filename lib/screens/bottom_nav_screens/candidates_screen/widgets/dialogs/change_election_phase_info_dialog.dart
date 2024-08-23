import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../widgets/close_icon_widget.dart';
import '../../../../../widgets/custom_snack_back.dart';

Future<void> showChangeElectionPhaseInfoDialog(BuildContext importedContext,
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
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
          return CustomContainerButton(
            onTap: () {},
            title: "",
            borderRadius: 12,
            height: 400,
            verticalPadding: 20,
            horizontalPadding: 20,
            useHeight: true,
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CloseIconWidget(),
                const SizedBox(height: 20,),
                BodyTextPrimaryWithLineHeight(
                  text:
                      "Are You Sure You Want to change election phase from ${electionProProvider.currentElectionPhase} to ${electionProProvider.nextElectionPhase}?",
                  alignCenter: true,
                  textColor: primaryTextColor,
                  fontWeight: boldFont,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const BodyTextPrimaryWithLineHeight(
                  text:
                      "This action is irreversible, be sure you want to take this action",
                  alignCenter: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<AuthenticationProvider>(
                    builder: (ctx, authProvider, child) {
                  return MainButton("Cancel", () async {
                    Navigator.pop(context);
                  });
                }),
                SizedBox(
                  height: 20.h,
                ),
                OutlineBtn("Yes, Proceed", () async {
                  if(electionProProvider.currentUserAddress == null){
                    customSnackBar(context, "Something is wrong here");
                  }else{
                    await electionProProvider.changeElectionState(
                        context: context, address:  electionProProvider.currentUserAddress!.toString());
                    Navigator.pop(context);
                  }

                })
              ],
            ),
          );
        }));
  }
}
