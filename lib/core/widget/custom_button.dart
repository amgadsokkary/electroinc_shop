import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String bName;
  final double width;
  final double height;
  final double radius;

  const CustomButton({
    super.key,
    required this.bName,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: AppColors.primary,
        ),
        child: Text(bName, style: AppStyles.buttonText),
      ),
    );
  }
}
