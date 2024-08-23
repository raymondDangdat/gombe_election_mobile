import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/constants/image_constant.dart';

class SupportIconWidget extends StatelessWidget {
  const SupportIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(onTap: () {}, child: SvgPicture.asset(questionMarkIcon)),
    );
  }
}
