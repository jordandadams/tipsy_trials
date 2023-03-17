import 'package:flutter/material.dart';
import 'app_sizes.dart';

class AppDefaults {
  /// Used For Border Radius
  static BorderRadius defaulBorderRadius =
      BorderRadius.circular(AppSizes.defaultRadius);

  /// Used For Bottom Sheet
  static BorderRadius defaultBottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(AppSizes.defaultRadius),
    topRight: Radius.circular(AppSizes.defaultRadius),
  );

  /// Used For Top Sheet
  static BorderRadius defaultTopSheetRadius = BorderRadius.only(
    bottomLeft: Radius.circular(AppSizes.defaultRadius),
    bottomRight: Radius.circular(AppSizes.defaultRadius),
  );

  /// Default Box Shadow used for containers
  static List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
      blurRadius: 25,
      spreadRadius: 0,
      offset: Offset(0, 2),
      color: Colors.black.withOpacity(0.08),
    ),
  ];

  /// Default Animation Duration used for the entire app
  static Duration defaultDuration = Duration(milliseconds: 300);
}
