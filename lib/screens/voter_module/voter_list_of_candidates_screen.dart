import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/models/candidate_model.dart';
import 'package:gombe_election/models/local_government_model.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/constants/dimension_constants.dart';
import 'package:gombe_election/resources/constants/image_constant.dart';
import 'package:gombe_election/screens/bottom_nav_screens/widgets/white_app_bar.dart';
import 'package:gombe_election/screens/onboarding/widgets/on_boarding_back_button.dart';
import 'package:gombe_election/widgets/candidate_detail_dialog.dart';
import 'package:gombe_election/widgets/empty_state_widget.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../utils/functions.dart';
import '../../widgets/constant_widgets.dart';

class VoterListOfCandidatesScreen extends StatefulWidget {
  const VoterListOfCandidatesScreen({super.key});

  @override
  State<VoterListOfCandidatesScreen> createState() =>
      _VoterListOfCandidatesScreenState();
}

class _VoterListOfCandidatesScreenState
    extends State<VoterListOfCandidatesScreen> {
  // LGA? selectedLGA;

  Timer? _timer;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final electionProvider =
      Provider.of<ElectionProvider>(context, listen: false);

      if(electionProvider.currentPhaseInt != 0){
        electionProvider.getAllVoters(context: context);
      }

      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        electionProvider.filterCandidates(
            lgId: electionProvider.voter?.lga ?? "");
      });

    });
    super.initState();
  }



  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(child:
          Consumer<ElectionProvider>(builder: (ctx, electionProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            const Row(
              children: [
                OnBoardingBackButton(),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BodyTextPrimaryWithLineHeight(
                    text:
                        '${returnLGA(lgID: int.tryParse(electionProvider.voter?.lga ?? "") ?? 0)} LGA',
                    fontWeight: boldFont,
                    fontSize: 25,
                    textColor: primaryTextColor,
                  ),
                  SvgPicture.asset(filterIcon),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const BodyTextPrimaryWithLineHeight(
              text: "Chairmanship Candidates",
              fontWeight: semiBoldFont,
              fontSize: 20,
              textColor: primaryTextColor,
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: electionProvider.loadingAllCandidates
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : electionProvider.candidatesListToDisplay.isEmpty
                        ? const EmptyStateWidget(
                            message: "No Registered Candidates",
                          )
                        : ListView.builder(
                            itemCount:
                                electionProvider.candidatesListToDisplay.length,
                            itemBuilder: (context, index) {
                              final candidate = electionProvider
                                  .candidatesListToDisplay[index];
                              final lgRegisteredVoters = electionProvider
                                  .votersToDisplay
                                  .where((voter) => voter.lga == candidate.lga)
                                  .toList();
                              debugPrint("${electionProvider.votersToDisplay.length} Registered voters:: ${electionProvider.votersToDisplay.length}");
                              final lgTotalVoters = lgRegisteredVoters
                                  .where((voter) => voter.hasVoted)
                                  .toList();
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 20,
                                    left: horizontalPadding.w,
                                    right: horizontalPadding.w),
                                child: electionProvider.voter!.hasVoted
                                    ? CandidateWidget2(candidate: candidate, totalVoters: lgTotalVoters.length,)
                                    : CandidateWidget1(candidate: candidate,),
                              );
                            }))
          ],
        );
      })),
    );
  }
}

class CandidateWidget1 extends StatelessWidget {
  final CandidateModel candidate;
  const CandidateWidget1({super.key, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return CustomContainerButton(
      onTap: () {},
      title: "",
      widget: Column(
        children: [
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
                        image: AssetImage(returnPartyLogo(candidate.party)),
                        fit: BoxFit.cover)),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              BodyTextPrimaryWithLineHeight(
                text: candidate.name,
                textColor: primaryTextColor,
                fontWeight: boldFont,
                fontSize: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BodyTextPrimaryWithLineHeight(
                text: "Qualification: ${candidate.qualification}",
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
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
                    "LGA: ${candidate.lga == "NA" ? "NA" : returnLGA(lgID: int.parse(candidate.lga))}",
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
              ),
              BodyTextPrimaryWithLineHeight(
                text: "Party: ${candidate.party}",
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
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
                text: "Date of Birth: ${returnFormattedDate(candidate.dob)}",
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
              ),
              BodyTextPrimaryWithLineHeight(
                text: "Age: ${calculateAge(DateTime.parse(candidate.dob))}",
                textColor: primaryTextColor,
                fontWeight: semiBoldFont,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BodyTextPrimaryWithLineHeight(
                      text: "Votes: ",
                      textColor: primaryTextColor,
                      fontWeight: semiBoldFont,
                      fontSize: 20,
                    ),
                    HeaderText(
                      text: "${candidate.voteCount} ",
                      fontSize: 32,
                      fontWeight: boldFont,
                      textColor: primaryTextColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Consumer<ElectionProvider>(
                      builder: (ctx, electionProvider, child) {
                    return MainButton(
                      "Vote",
                      () {
                        electionProvider.selectCandidate(candidate);
                        showCandidateDetailDialog(context);
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CandidateWidget2 extends StatelessWidget {
  final CandidateModel candidate;
  final Color bgColor;
  final int totalVoters;
  const CandidateWidget2({super.key, required this.candidate,
    required this.totalVoters,
  this.bgColor = const Color.fromRGBO(13, 77, 7, 1)});

  @override
  Widget build(BuildContext context) {
    return CustomContainerButton(
      onTap: () {},
      title: "",
      bgColor: bgColor,
      borderRadius: 16,
      widget: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hintTextColor,
                    image: DecorationImage(
                        image: AssetImage(returnPartyLogo(candidate.party)),
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
                text: candidate.name,
                textColor: white,
                fontWeight: boldFont,
                fontSize: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyTextPrimaryWithLineHeight(
                text: candidate.party,
                textColor: white,
                fontWeight: semiBoldFont,
                fontSize: 20,
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Consumer<ElectionProvider>(builder: (ctx, electionProvider, child) {
                return electionProvider.currentPhaseInt == 0  ? Container() : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BodyTextPrimaryWithLineHeight(
                          text: "Votes: ",
                          textColor: white,
                          fontWeight: semiBoldFont,
                          fontSize: 16,
                        ),
                        HeaderText(
                          text: "${candidate.voteCount} ",
                          fontSize: 20,
                          fontWeight: boldFont,
                          textColor: white,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BodyTextPrimaryWithLineHeight(
                          text: "Percent: ",
                          textColor: white,
                          fontWeight: semiBoldFont,
                          fontSize: 16,
                        ),
                        HeaderText(
                          text: "${totalVoters == 0 ? 0 : ((candidate.voteCount * 100) / totalVoters).toStringAsFixed(2)} ",
                          fontSize: 20,
                          fontWeight: boldFont,
                          textColor: white,
                        )
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
