import 'package:advanced_flutter/presentation/values_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
    // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4
      ),

    // app bar theme

    // button theme

    // text theme

    // input decoration theme (text form field)

  );
}