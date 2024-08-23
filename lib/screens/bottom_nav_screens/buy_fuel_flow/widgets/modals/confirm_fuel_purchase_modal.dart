import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/constants/string_constants.dart';
import '../../../../../widgets/long_divider.dart';

Future showConfirmFuelPurchaseModal(
  BuildContext importedContext,
) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(modalRadius.r),
                    topRight: Radius.circular(modalRadius.r)),
              ),
              child: Consumer<AuthenticationProvider>(
                  builder: (ctx, authProvider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 14.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BodyTextLightWithLineHeight(
                            text: "New purchase",
                            textColor: blackTextColor,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(closeDialogIcon)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: Column(
                        children: [
                          PurchaseItem(
                              label: "Product:",
                              showLineThrough: false,
                              mainText: "NA"),
                          PurchaseItem(
                              label: "Amount:",
                              showLineThrough: false,
                              mainText: "KK"),
                          CustomContainerButton(
                            onTap: () {},
                            title: "",
                            borderRadius: 8,
                            verticalPadding: 5,
                            bgColor: const Color.fromRGBO(239, 242, 247, 1),
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: BodyTextLightWithLineHeight(
                                    text: "Points to Earn",
                                    textColor: blackTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                                CustomContainerButton(
                                  onTap: () {},
                                  title: "+0 points",
                                  bgColor:
                                      const Color.fromRGBO(36, 229, 19, 0.05),
                                  verticalPadding: 5,
                                  borderRadius: 8,
                                  textColor:
                                      const Color.fromRGBO(29, 146, 19, 1),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const LongDivider(),
                          SizedBox(
                            height: 20.h,
                          ),
                          MainButton(confirmPurchase, () async {
                            Navigator.pop(context);
                          }),
                          SizedBox(
                            height: bottomPadding.h,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              })));
    },
  );
}

class PurchaseItem extends StatelessWidget {
  final String label;
  final String mainText;
  final bool showDivider;
  final bool showLineThrough;
  const PurchaseItem({
    super.key,
    required this.label,
    required this.mainText,
    this.showDivider = true,
    this.showLineThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyTextPrimaryWithLineHeight(
              text: label,
              fontSize: 20,
              fontWeight: semiBoldFont,
              textColor: const Color.fromRGBO(128, 131, 135, 1),
            ),
            const SizedBox(
              width: 5,
            ),
            BodyTextPrimaryWithLineHeight(
              text: mainText,
              fontWeight: semiBoldFont,
              showLineThrough: showLineThrough,
              maxLines: 1,
              textColor: showLineThrough
                  ? const Color.fromRGBO(191, 193, 195, 1)
                  : const Color.fromRGBO(0, 6, 16, 1),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        if (showDivider) const LongDivider(),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
