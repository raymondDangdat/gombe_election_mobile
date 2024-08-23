import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/constants/color_constants.dart';

final whiteAppBar = AppBar(
  systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: whiteTextColor, // <-- SEE HERE
      statusBarIconBrightness:
          Brightness.dark, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: Colors.transparent),
);
