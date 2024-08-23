import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import 'linear_progress_indicator_widget.dart';

class EarningsWidget extends StatelessWidget {
  const EarningsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
        builder: (ctx, loyaltyPointsProvider, child) {
      return ListView.builder(
          itemCount: earningsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final earning = earningsList[index];
            return Padding(
              padding: EdgeInsets.only(
                  left: horizontalPadding.w,
                  right: horizontalPadding.w,
                  bottom: 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding.w, vertical: 20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyTextLightWithLineHeight(
                      text: earning.title,
                      textColor: blackTextColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BodyTextLightWithLineHeight(text: earning.description),
                    const SizedBox(
                      height: 10,
                    ),
                    const LinearProgressIndicatorWidget(progress: 0),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyTextLightWithLineHeight(
                          text: "'...'} points",
                          textColor: Color.fromRGBO(29, 146, 19, 1),
                          fontWeight: semiBoldFont,
                        ),
                        BodyTextLightWithLineHeight(
                          text: " Days Left",
                          textColor: Color.fromRGBO(64, 68, 76, 1),
                          fontWeight: semiBoldFont,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}

class EarningModel {
  final String title;
  final String description;
  final String points;
  final String daysLeft;
  final double progress;

  EarningModel(
      {required this.title,
      required this.description,
      required this.progress,
      required this.daysLeft,
      required this.points});
}

final List<EarningModel> earningsList = [
  EarningModel(
      title: "Earnings Progress",
      description:
          "Buy fuel worth of N100,000 within 30 Days to earn 500 points",
      progress: 0.3,
      daysLeft: '5',
      points: "100")
];
