import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const HeadTitle({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.headlineMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "View all",
            style: AppStyles.bodyLarge.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
