import 'dart:io';

import 'package:flutter/material.dart';

class TopPadding extends StatelessWidget {
  const TopPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Platform.isAndroid ? 50 : 20,
    );
  }
}
