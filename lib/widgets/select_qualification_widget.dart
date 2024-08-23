import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class SelectQualificationWidget extends StatefulWidget {
  const SelectQualificationWidget({super.key});

  @override
  State<SelectQualificationWidget> createState() =>
      _SelectQualificationWidgetState();
}

class _SelectQualificationWidgetState extends State<SelectQualificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ElectionProvider>(builder: (ctx, electionProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyTextPrimaryWithLineHeight(
            text: "Select Highest Qualification",
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
                      text: electionProvider.selectedQualification ??
                          "Select Option",
                      textColor: primaryTextColor,
                      fontWeight: mediumFont,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    if (electionProvider.selectedQualification != null)
                      SvgPicture.asset(dropdownIconSvg)
                  ],
                ),
                items: listOfQualifications
                    .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyTextPrimaryWithLineHeight(
                              text: item,
                              textColor: primaryTextColor,
                              fontWeight: mediumFont,
                            ),
                          ],
                        )))
                    .toList(),
                value: electionProvider.selectedQualification,
                onChanged: (String? value) async {
                  electionProvider.updateSelectedQualification(value);
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
