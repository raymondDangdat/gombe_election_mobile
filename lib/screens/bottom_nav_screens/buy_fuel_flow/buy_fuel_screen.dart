import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/white_app_bar.dart';

class BuyFuelScreen extends StatefulWidget {
  const BuyFuelScreen({super.key});

  @override
  State<BuyFuelScreen> createState() => _BuyFuelScreenState();
}

class _BuyFuelScreenState extends State<BuyFuelScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 242, 247, 1),
      appBar: whiteAppBar,
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              const CustomAppbar(title: buyFuelNow),
              SizedBox(
                height: 10.h,
              ),
            ],
          )),
    );
  }
}
