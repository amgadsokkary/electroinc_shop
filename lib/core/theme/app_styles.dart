import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle headlineLarge = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle hint = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle buttonText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle error = const TextStyle(fontSize: 16, color: Colors.red);

  static IconThemeData iconStyle = const IconThemeData(
    color: AppColors.white,
    size: 30,
  );
}
