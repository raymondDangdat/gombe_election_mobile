import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/constants/color_constants.dart';

final blueAppBar = AppBar(
  backgroundColor: const Color.fromRGBO(10, 43, 97, 1),
  systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(10, 43, 97, 1), // <-- SEE HERE
      statusBarIconBrightness:
          Brightness.dark, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: Colors.transparent),
);
