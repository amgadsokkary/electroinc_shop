import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.icon,
    this.sIcon,
    this.isPassword = false,
    required this.controller,
    this.onChanged,
    this.sOnPressed,
    this.filled,
    this.fillColor,
    this.labelText,
    this.border,
  });

  final String? hintText;
  final IconData? icon;
  final IconData? sIcon;
  final bool isPassword;
  final void Function()? sOnPressed;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool? filled;
  final Color? fillColor;
  final String? labelText;
  final InputBorder? border;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.isPassword ? !isVisible : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.labelText} is required";
        }
        return null;
      },
      style: AppStyles.bodyLarge,
      decoration: InputDecoration(
        border: widget.border ?? UnderlineInputBorder(),
        filled: widget.filled,
        fillColor: widget.fillColor,
        prefixIcon: Icon(widget.icon),
        prefixIconColor: AppColors.textSecondary,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textSecondary,
                ),
              )
            : IconButton(
                onPressed: widget.sOnPressed,
                icon: Icon(widget.sIcon),
                color: AppColors.textSecondary,
              ),

        hintText: widget.hintText,
        hintStyle: AppStyles.hint,
        labelText: widget.labelText,
        labelStyle: AppStyles.bodyMedium,
        suffixIconColor: AppColors.textSecondary,
      ),
    );
  }
}
