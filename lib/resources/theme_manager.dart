import 'package:flutter/material.dart';
import 'constants/color_constants.dart';
import 'styles_manager.dart';
import 'value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: mainColor,
      disabledColor: mainColor,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,

      //  Card Theme
      cardTheme:
          const CardTheme(color: cardColor, elevation: AppSize.cardElevation),

      //    AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: white,
        toolbarHeight: 0,
        elevation: AppSize.appBarElevation,
        titleTextStyle: getAppBarTitleStyle(textColor: primaryColor),
      ),

      //   Button theme
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
          ),
          buttonColor: primaryColor,
          splashColor: primaryColor),

      //  Elevated button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: getAppBarTitleStyle(textColor: white),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
        ),
      )),

      //  Text Theme
      textTheme: TextTheme(
          displayLarge: getBoldStyle(textColor: primaryColor, fontSize: 24),
          displayMedium: getPageSubtitleStyle(textColor: primaryColor),
          bodyLarge: getRegularStyle(textColor: lightTextColor)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.contentPadding),
        hintStyle: getHintStyle(textColor: hintTextColor),
        labelStyle: getHintStyle(textColor: labelTextColor),
        errorStyle: getHintStyle(textColor: errorColor),

        //  Enable Borders
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: hintTextColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: hintTextColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Focus Borders
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Error Border
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: errorColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Focus Error Border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: errorColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: primaryColor)
          .copyWith(background: appBgColor));
}
