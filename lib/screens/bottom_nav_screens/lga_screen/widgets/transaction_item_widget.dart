import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../widgets/long_divider.dart';
import 'dialogs/fuel_purchase_transaction_details.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BodyTextPrimaryWithLineHeight(
                        text: "",
                        textColor: Color.fromRGBO(0, 6, 16, 1),
                        fontWeight: mediumFont,
                      ),
                      BodyTextPrimaryWithLineHeight(
                        text: Jiffy.parse(DateTime.now().toString()).format(
                          pattern: 'dd MMM, yyyy',
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          const LongDivider(),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}

class FuelPurchaseTransactionItemWidget extends StatelessWidget {
  const FuelPurchaseTransactionItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showFuelTransactionDetailDialog(context);
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          const LongDivider(),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
