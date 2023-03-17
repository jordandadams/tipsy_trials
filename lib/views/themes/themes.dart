import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_defaults.dart';
import '../../constants/app_sizes.dart';
import '../../utils/ui_helper.dart';
import 'text.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  /* <-----------------------> 
      Light Theme    
   <-----------------------> */
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: AppColors.darkColor,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.darkColor,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: AppColors.darkColor),
      toolbarTextStyle: AppText.b1,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: AppDefaults.defaulBorderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDefaults.defaulBorderRadius,
        borderSide: BorderSide(
          color: AppColors.placeholderColor,
        ),
      ),
      fillColor: AppColors.placeholderColor.withOpacity(0.2),
      filled: true,
    ),
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(AppSizes.defaultPadding),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(AppSizes.defaultPadding),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch:
                AppUiHelper.generateMaterialColor(AppColors.primaryColor))
        .copyWith(secondary: AppColors.accentColor),
  );

  /* <-----------------------> 
      Dark Themes For this app    
   <-----------------------> */

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkColor,
    brightness: Brightness.dark,
    cardColor: AppColors.darkColor.withOpacity(0.7),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: AppColors.darkColor,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      toolbarTextStyle: AppText.b1,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: AppDefault.defaulBorderRadius,
        //   borderSide: BorderSide(
        //     color: AppColors.PLACEHOLDER_COLOR,
        //   ),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: AppDefault.defaulBorderRadius,
        //   borderSide: BorderSide(
        //     color: AppColors.ACCENT_COLOR,
        //   ),
        // ),
        ),
    iconTheme: IconThemeData(
      color: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(AppSizes.defaultPadding),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(AppSizes.defaultPadding),
        side: BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch:
                AppUiHelper.generateMaterialColor(AppColors.primaryColor))
        .copyWith(secondary: AppColors.accentColor),
  );
}
