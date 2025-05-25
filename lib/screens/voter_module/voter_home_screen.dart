import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/Widgets/components.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/navigation_utils.dart';
import 'package:gombe_election/screens/bottom_nav_screens/candidates_screen/settings_screen.dart';
import 'package:gombe_election/screens/bottom_nav_screens/widgets/white_app_bar.dart';
import 'package:gombe_election/screens/voter_module/voter_list_of_candidates_screen.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';

class VoterHomeScreen extends StatefulWidget {
  const VoterHomeScreen({super.key});

  @override
  State<VoterHomeScreen> createState() => _VoterHomeScreenState();
}

class _VoterHomeScreenState extends State<VoterHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final electionProvider =
      Provider.of<ElectionProvider>(context, listen: false);
      electionProvider.startFetchCurrentElectionPhase(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(child: Consumer2<AuthenticationProvider, ElectionProvider>(
          builder: (ctx, authProvider, electionProvider, child) {
        return Column(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    const TopPadding(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: InkWell(
                        onTap: () {
                          navToWithScreenName(
                              context: context, screen: const SettingScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    color: hintTextColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BodyTextPrimaryWithLineHeight(
                                      text: welcomeBack,
                                      textColor: primaryTextColor,
                                      fontSize: 12,
                                    ),
                                    BodyTextPrimaryWithLineHeight(
                                      text: "${electionProvider.voter?.name}",
                                      fontWeight: boldFont,
                                      textColor: primaryTextColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const BodyTextPrimaryWithLineHeight(
                      text: "Current Election Phase:",
                      fontSize: 24,
                      fontWeight: semiBoldFont,
                      textColor: primaryTextColor,
                    ),
                    BodyTextPrimaryWithLineHeight(
                      text: electionProvider.currentElectionPhase,
                      fontWeight: boldFont,
                      textColor: primaryTextColor,
                      fontSize: 32,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: MainButton(
                          electionProvider.currentElectionPhase ==
                                      votingPhase &&
                                  electionProvider.voter?.hasVoted == false
                              ? "Proceed To Vote"
                              : electionProvider.currentElectionPhase ==
                                          votingPhase &&
                                      electionProvider.voter?.hasVoted == true
                                  ? "View Progress"
                                  : electionProvider.currentElectionPhase ==
                                          resultPhase
                                      ? "View Results"
                                      : "View Candidates", () async {
                        await electionProvider.getAllCandidates();
                        electionProvider.filterCandidates(
                            lgId: electionProvider.voter?.lga ?? "");
                        navToWithScreenName(
                            context: context,
                            screen: const VoterListOfCandidatesScreen());
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      })),
    );
  }
}
