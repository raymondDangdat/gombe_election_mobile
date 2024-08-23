import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../widgets/custom_snack_back.dart';
import '../../../../../widgets/long_divider.dart';

Future showConfirmTransactionPINModal(BuildContext importedContext,
    {bool isDeleteAccount = false}) {
  final pinController = TextEditingController();
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
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (authProvider.resMessage != '' ||
                        authProvider.resMessage != "") {
                      customSnackBar(
                          context,
                          authProvider.resMessage.isEmpty
                              ? authProvider.resMessage
                              : authProvider.resMessage);

                      ///Clear the response message to avoid duplicate
                      authProvider.clear();
                      authProvider.clear();
                    }
                  });
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 14.h),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  );
                })));
      });
    },
  );
}

class PurchaseItem extends StatelessWidget {
  final String label;
  final String mainText;
  const PurchaseItem({
    super.key,
    required this.label,
    required this.mainText,
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
            BodyTextPrimaryWithLineHeight(
              text: mainText,
              fontWeight: semiBoldFont,
              fontSize: 20,
              textColor: const Color.fromRGBO(0, 6, 16, 1),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        const LongDivider(),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
