import 'package:enyad_store_3/utils/theme/custom_themes/appbar_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/chip_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/text_field_theme.dart';
import 'package:enyad_store_3/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/elevated_button_theme.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: STextTheme.lightTextTheme,
    elevatedButtonTheme:SElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: SChipTheme.lightChipTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: SOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: STextFormFrieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: STextTheme.darkTextTheme,
    elevatedButtonTheme:SElevatedButtonTheme.darkElevatedButtonTheme,
    chipTheme: SChipTheme.darkChipTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: SOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: STextFormFrieldTheme.darkInputDecorationTheme,
  );
}