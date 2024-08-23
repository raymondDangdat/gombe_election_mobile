import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gombe_election/models/local_government_model.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/constants/dimension_constants.dart';
import 'package:gombe_election/screens/bottom_nav_screens/add_deposit_flow/widgets/dialogs/add_voter_dialog.dart';
import 'package:gombe_election/screens/bottom_nav_screens/widgets/white_app_bar.dart';
import 'package:gombe_election/widgets/empty_state_widget.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';

class VotersScreen extends StatefulWidget {
  const VotersScreen({super.key});

  @override
  State<VotersScreen> createState() => _VotersScreenState();
}

class _VotersScreenState extends State<VotersScreen> {
  LGA? selectedLGA;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BodyTextPrimaryWithLineHeight(
                    text: "Registered Voters",
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
                      electionProvider.filterVoters();
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
                child: electionProvider.loadingAllVoters
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : electionProvider.votersToDisplay.isEmpty
                        ? const EmptyStateWidget(
                            message: "No Register Voters Yet",
                          )
                        : ListView.builder(
                            itemCount: electionProvider.votersToDisplay.length,
                            itemBuilder: (context, index) {
                              final voter =
                                  electionProvider.votersToDisplay[index];
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
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "LGA: ${returnLGA(lgID: int.tryParse(voter.lga) ?? 0)}",
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
            showAddVoterDialog(context);
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
