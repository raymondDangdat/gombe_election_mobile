import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/screens/voter_module/voter_list_of_candidates_screen.dart';
import 'package:gombe_election/widgets/empty_state_widget.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../models/local_government_model.dart';
import '../../../providers/election_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../widgets/white_app_bar.dart';

class ElectionObserverScreen extends StatefulWidget {
  const ElectionObserverScreen({super.key});

  @override
  State<ElectionObserverScreen> createState() => _ElectionObserverScreenState();
}

class _ElectionObserverScreenState extends State<ElectionObserverScreen> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

  //   });
  //   setState(() {});
  //   super.initState();
  // }



  Timer? _timer;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final electionProvider =
      Provider.of<ElectionProvider>(context, listen: false);
      electionProvider.resetFilters();
      electionProvider.getAllCandidates();
      electionProvider.getAllVoters(context: context);

      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        electionProvider.getAllCandidates(showLoading: false);
        electionProvider.getAllVoters(context: context, showLoading: false);
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
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyTextPrimaryWithLineHeight(
                        text: "Election Details",
                        fontWeight: boldFont,
                        fontSize: 25,
                        textColor: primaryTextColor,
                      ),
                    ],
                  ),
                   SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyTextPrimaryWithLineHeight(
                        text: "Current Election Phase: \n ${electionProvider.currentElectionPhase}",
                        fontWeight: semiBoldFont,
                        fontSize: 20,
                        alignCenter: true,
                        textColor: primaryTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: electionProvider.loadingAllCandidates
                    ? const Center(
                  child: CupertinoActivityIndicator(),
                )
                    : electionProvider.candidatesListToDisplay.isEmpty ||
                    electionProvider.votersToDisplay.isEmpty
                    ? const EmptyStateWidget(
                  message: "Nothing To Observe Yet",
                )
                    : ListView.builder(
                    itemCount: gombeLGAS.length,
                    itemBuilder: (context, index) {
                      final lg = gombeLGAS[index];
                      final lgRegisteredVoters = electionProvider
                          .votersToDisplay
                          .where((voter) => voter.lga == lg.id)
                          .toList();
                      final lgTotalVoters = lgRegisteredVoters
                          .where((voter) => voter.hasVoted)
                          .toList();
                      final lgCandidates = electionProvider
                          .candidatesListToDisplay
                          .where((candidate) => candidate.lga == lg.id)
                          .toList();
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 10,
                            left: horizontalPadding.w,
                            right: horizontalPadding.w),
                        child: Column(
                          children: [
                            CustomContainerButton(
                              onTap: () {},
                              title: "",
                              widget: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      HeaderText(
                                        text: lg.name,
                                        fontSize: 20,
                                        textColor: primaryTextColor,
                                        fontWeight: boldFont,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const BodyTextPrimaryWithLineHeight(
                                    text: "Total Registered Voters",
                                    textColor: primaryTextColor,
                                    fontSize: 16,
                                  ),
                                  BodyTextPrimaryWithLineHeight(
                                    text:
                                    "${lgRegisteredVoters.length}",
                                    textColor: primaryTextColor,
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  const BodyTextPrimaryWithLineHeight(
                                    text: "Total Vote Cast",
                                    textColor: primaryTextColor,
                                    fontSize: 16,
                                  ),
                                  BodyTextPrimaryWithLineHeight(
                                    text: "${lgTotalVoters.length}",
                                    textColor: primaryTextColor,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            ListView.builder(
                                itemCount: lgCandidates.length,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final candidate = lgCandidates[index];

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10.h
                                    ),
                                    child: CandidateWidget2(candidate: candidate,
                                      totalVoters: lgTotalVoters.length,
                                      bgColor: const Color.fromRGBO(13, 77, 7, 1),),
                                  );
                                })
                          ],
                        ),
                      );
                    }))
          ],
        );
      })),
    );
  }
}
