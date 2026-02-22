import 'package:electronic_store/core/theme/app_images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(AppImages.logo),
          ),
        ),
      ),
    );
  }
}
