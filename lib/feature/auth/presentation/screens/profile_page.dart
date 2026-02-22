import 'package:electronic_store/core/cache/cache_user_repo.dart';
import 'package:electronic_store/core/theme/app_images.dart';
import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:electronic_store/core/widget/custom_button.dart';
import 'package:electronic_store/feature/auth/cubit/appauth/appauth_cubit.dart';
import 'package:electronic_store/feature/auth/presentation/screens/login.dart';
import 'package:electronic_store/feature/home/presentation/screens/add_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppauthCubit, AppauthState>(
      listener: (context, state) {
        if (state is AppauthSuccess) {
          CacheUserRepo.logout();
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              "Profile",
              style: AppStyles.headlineLarge.copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 110.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.person_4_outlined),
                      ),
                      title: Text(
                        user!.userMetadata?["username"] ?? "Unknown User",
                        style: AppStyles.bodyLarge,
                      ),
                    ),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.email_outlined),
                      ),
                      title: Text("${user!.email}", style: AppStyles.bodyLarge),
                    ),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.phone),
                      ),
                      title: Text(
                        "${user!.userMetadata?["phone"]}",
                        style: AppStyles.bodyLarge,
                      ),
                    ),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.location_on_outlined),
                      ),
                      title: Text(
                        "${user!.userMetadata?["address"]}",
                        style: AppStyles.bodyLarge,
                      ),
                    ),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.lock),
                      ),
                      title: Text("Password", style: AppStyles.bodyLarge),
                      trailing: IconTheme(
                        data: AppStyles.iconStyle.copyWith(size: 20),
                        child: IconButton(
                          onPressed: () {},
                          icon: IconTheme(
                            data: AppStyles.iconStyle,
                            child: Icon(Icons.sync),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    ListTile(
                      leading: IconTheme(
                        data: AppStyles.iconStyle,
                        child: Icon(Icons.add),
                      ),
                      title: Text("Add Product", style: AppStyles.bodyLarge),
                      trailing: IconTheme(
                        data: AppStyles.iconStyle.copyWith(size: 20),
                        child: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddProducts(),
                          ),
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: state is AppauthLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              bName: "logOut",
                              onPressed: () {
                                BlocProvider.of<AppauthCubit>(context).logout();
                              },
                            ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
