import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/widgets/custom_snack_back.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class SelectPartyWidget extends StatefulWidget {
  const SelectPartyWidget({super.key});

  @override
  State<SelectPartyWidget> createState() => _SelectPartyWidgetState();
}

class _SelectPartyWidgetState extends State<SelectPartyWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ElectionProvider>(builder: (ctx, electionProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyTextPrimaryWithLineHeight(
            text: "Select Party",
            textColor: Color.fromRGBO(64, 68, 76, 1),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(239, 242, 247, 1),
                borderRadius: BorderRadius.circular(8)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isDense: true,
                onMenuStateChange: (value) {},
                hint: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodyTextPrimaryWithLineHeight(
                      text: electionProvider.selectedParty ?? "Select Option",
                      textColor: primaryTextColor,
                      fontWeight: mediumFont,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    if (electionProvider.selectedParty != null)
                      SvgPicture.asset(dropdownIconSvg)
                  ],
                ),
                items: listOfParties
                    .map((String item) =>  DropdownMenuItem<String>(
                        value: item,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyTextPrimaryWithLineHeight(
                              text: item,
                              textColor: electionProvider.addedParties.contains(item) ? hintTextColor  : primaryTextColor,
                              fontWeight: mediumFont,
                            ),
                          ],
                        )))
                    .toList(),
                value: electionProvider.selectedParty,
                onChanged: (String? value) async {
                  if(electionProvider.addedParties.contains(value)){
                    customSnackBar(context, 'Candidate already added for this Party');
                  }else{
                    electionProvider.updateSelectedParty(value);
                  }

                },
                buttonStyleData: ButtonStyleData(
                  height: 52,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: horizontalPadding.w, right: horizontalPadding.w),
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
        ],
      );
    });
  }
}
