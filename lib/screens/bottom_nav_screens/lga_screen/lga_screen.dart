import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/Widgets/components.dart';
import 'package:gombe_election/Widgets/custom_text.dart';
import 'package:gombe_election/models/local_government_model.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/resources/constants/dimension_constants.dart';
import 'package:gombe_election/resources/constants/font_constants.dart';
import 'package:gombe_election/widgets/constant_widgets.dart';
import 'package:provider/provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../widgets/white_app_bar.dart';

class LGAScreen extends StatefulWidget {
  const LGAScreen({super.key});

  @override
  State<LGAScreen> createState() => _LGAScreenState();
}

class _LGAScreenState extends State<LGAScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor2,
      appBar: whiteAppBar,
      body: SafeArea(
          bottom: false,
          top: false,
          child: Consumer<AuthenticationProvider>(
              builder: (ctx, transactionProvider, child) {
            return Column(
              children: [
                const TopPadding(),
                const Center(
                  child: BodyTextPrimaryWithLineHeight(
                    text: "Gombe LGAs",
                    textColor: primaryTextColor,
                    fontWeight: boldFont,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: gombeLGAS.length,
                        itemBuilder: (context, index) {
                          final lga = gombeLGAS[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: horizontalPadding.w,
                                right: horizontalPadding.w,
                                bottom: 15),
                            child: CustomContainerButton(
                              onTap: () {},
                              title: "",
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      BodyTextPrimaryWithLineHeight(
                                        text: lga.name,
                                        textColor: blackTextColor,
                                        fontSize: 20,
                                        fontWeight: boldFont,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      BodyTextPrimaryWithLineHeight(
                                        text: "Admin. HQ${lga.hq}",
                                        fontWeight: semiBoldFont,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            );
          })),
    );
  }
}
