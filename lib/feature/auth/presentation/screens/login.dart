import 'package:electronic_store/core/theme/app_images.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/core/widget/custom_button.dart';
import 'package:electronic_store/core/widget/custom_row.dart';
import 'package:electronic_store/core/widget/custom_text_form_field.dart';
import 'package:electronic_store/feature/auth/cubit/appauth/appauth_cubit.dart';
import 'package:electronic_store/feature/auth/presentation/screens/signup.dart';
import 'package:electronic_store/feature/home/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppauthCubit, AppauthState>(
        listener: (context, state) {
          if (state is AppauthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          }

          if (state is AppauthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),

            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// LOGO
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(AppImages.logo),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text("Login", style: AppStyles.headlineLarge),
                      Text(
                        "Enter your email and password",
                        style: AppStyles.bodyMedium,
                      ),

                      const SizedBox(height: 50),

                      /// EMAIL
                      CustomTextFormField(
                        icon: Icons.email,
                        labelText: "Email",
                        controller: emailController,
                      ),

                      /// PASSWORD
                      CustomTextFormField(
                        icon: Icons.lock,
                        labelText: "Password",
                        controller: passwordController,
                        isPassword: true,
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password?",
                            style: AppStyles.bodyLarge,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      state is AppauthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              bName: "Login",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AppauthCubit>().login(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                            ),

                      const SizedBox(height: 20),

                      CustomRow(
                        textName: "Don’t have an account?",
                        textLink: "SignUp",
                        screenName: Signup(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
