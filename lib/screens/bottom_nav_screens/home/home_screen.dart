import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/Widgets/components.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/navigation_utils.dart';
import 'package:gombe_election/screens/bottom_nav_screens/candidates_screen/settings_screen.dart';
import 'package:gombe_election/screens/bottom_nav_screens/home/election_results_screen.dart';
import 'package:gombe_election/screens/bottom_nav_screens/widgets/white_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../candidates_screen/widgets/dialogs/change_election_phase_info_dialog.dart';
import '../widgets/recent_transactions_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyTextPrimaryWithLineHeight(
                                      text: welcomeBack,
                                      textColor: primaryTextColor,
                                      fontSize: 12,
                                    ),
                                    BodyTextPrimaryWithLineHeight(
                                      text: "Election Admin",
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
                          electionProvider.currentElectionPhase == resultPhase
                              ? "Results"
                              : "Change State", () {
                        if (electionProvider.currentElectionPhase ==
                            resultPhase) {
                          navToWithScreenName(
                              context: context,
                              screen: const ElectionResultsScreen());
                        } else {
                          showChangeElectionPhaseInfoDialog(context);
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
                child: RefreshIndicator(
              color: black,
              onRefresh: () async {},
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    const RecentTransactionHistoryWidget(
                      isHomeScreen: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            )),
          ],
        );
      })),
    );
  }
}
