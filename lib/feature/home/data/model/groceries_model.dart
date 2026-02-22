import 'package:electronic_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GroceriesModel {
  final String? name;
  final String? image;
  final Color color;
  GroceriesModel({this.name, this.image, this.color = AppColors.primary});

  factory GroceriesModel.fromJson(Map<String, dynamic> json) {
    return GroceriesModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      color: AppColors.primary,
    );
  }
}
