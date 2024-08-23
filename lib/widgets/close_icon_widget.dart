import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/constants/image_constant.dart';

class CloseIconWidget extends StatelessWidget {
  const CloseIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(closeDialogIcon))
      ],
    );
  }
}
