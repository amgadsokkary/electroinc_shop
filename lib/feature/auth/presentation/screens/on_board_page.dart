import 'package:electronic_store/core/theme/app_images.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/core/widget/custom_button.dart';
import 'package:electronic_store/feature/auth/presentation/screens/login.dart';
import 'package:flutter/material.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(AppImages.logo),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome",
                  style: AppStyles.headlineLarge.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  "To Electronic Shop",
                  style: AppStyles.headlineLarge.copyWith(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  "Ger your groceries in as fast as one hour",
                  style: AppStyles.bodyMedium.copyWith(color: Colors.white),
                ),
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 60.0,
                    horizontal: 20.0,
                  ),
                  child: CustomButton(
                    bName: "Get Started",
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
