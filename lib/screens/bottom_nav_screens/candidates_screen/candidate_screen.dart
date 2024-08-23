import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gombe_election/utils/functions.dart';
import 'package:gombe_election/widgets/empty_state_widget.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../models/local_government_model.dart';
import '../../../providers/election_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../widgets/add_candidate_dialog.dart';
import '../../../widgets/white_app_bar.dart';

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({super.key});

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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BodyTextPrimaryWithLineHeight(
                    text: "Registered Candidates",
                    fontWeight: boldFont,
                    fontSize: 25,
                    textColor: primaryTextColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const BodyTextPrimaryWithLineHeight(
              text: "Filter By LGA",
              fontWeight: semiBoldFont,
              textColor: primaryTextColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 242, 247, 1),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<LGA>(
                    isDense: true,
                    onMenuStateChange: (value) {},
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                          text: electionProvider.selectedLGA?.name ??
                              "Select Option",
                          textColor: primaryTextColor,
                          fontWeight: mediumFont,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        if (electionProvider.selectedLGA != null)
                          SvgPicture.asset(dropdownIconSvg)
                      ],
                    ),
                    items: gombeLGAS
                        .map((LGA item) => DropdownMenuItem<LGA>(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyTextPrimaryWithLineHeight(
                                  text: item.name,
                                  textColor: primaryTextColor,
                                  fontWeight: mediumFont,
                                ),
                              ],
                            )))
                        .toList(),
                    value: electionProvider.selectedLGA,
                    onChanged: (LGA? value) async {
                      electionProvider.updateSelectedLGA(value);
                      electionProvider.filterCandidates();
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 52,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: horizontalPadding.w,
                          right: horizontalPadding.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(239, 242, 247, 1),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: SvgPicture.asset(dropdownIconSvg),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: whiteTextColor,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
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
                              final voter = electionProvider
                                  .candidatesListToDisplay[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10,
                                    left: horizontalPadding.w,
                                    right: horizontalPadding.w),
                                child: CustomContainerButton(
                                  onTap: () {},
                                  title: "",
                                  widget: Column(
                                    children: [
                                      Row(
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text: voter.name,
                                            textColor: primaryTextColor,
                                            fontWeight: boldFont,
                                            fontSize: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "Qualification: ${voter.qualification}",
                                            textColor: primaryTextColor,
                                            fontWeight: semiBoldFont,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "LGA: ${voter.lga == "NA" ? "NA" : returnLGA(lgID: int.parse(voter.lga))}",
                                            textColor: primaryTextColor,
                                            fontWeight: semiBoldFont,
                                          ),
                                          BodyTextPrimaryWithLineHeight(
                                            text: "Party: ${voter.party}",
                                            textColor: primaryTextColor,
                                            fontWeight: semiBoldFont,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "Date of Birth: ${returnFormattedDate(voter.dob)}",
                                            textColor: primaryTextColor,
                                            fontWeight: semiBoldFont,
                                          ),
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "Age: ${calculateAge(DateTime.parse(voter.dob))}",
                                            textColor: primaryTextColor,
                                            fontWeight: semiBoldFont,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
          ],
        );
      })),
      floatingActionButton: SizedBox(
        width: 230,
        child: MainButton(
          "",
          () {
            showAddCandidateDialog(context);
          },
          border: 12,
          widget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyTextLightWithLineHeight(
                text: "Add Voter",
                textColor: white,
                fontWeight: semiBoldFont,
              )
            ],
          ),
        ),
      ),
    );
  }
}
