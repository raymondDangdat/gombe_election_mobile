import 'package:flutter/cupertino.dart';

class DashboardSlideWidget extends StatefulWidget {
  const DashboardSlideWidget({super.key});

  @override
  State<DashboardSlideWidget> createState() => _DashboardSlideWidgetState();
}

class _DashboardSlideWidgetState extends State<DashboardSlideWidget> {
  int currentIndex = 0;
  final currentTrendingNewsPageNotifier = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class SliderItem {
  final String title;
  final String img;
  final String buttonText;
  final VoidCallback onTap;

  SliderItem(
      {required this.title,
      required this.onTap,
      required this.img,
      required this.buttonText});
}
