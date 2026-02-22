import 'package:electronic_store/core/cache/cache_user_repo.dart';
import 'package:electronic_store/feature/auth/cubit/appauth/appauth_cubit.dart';
import 'package:electronic_store/feature/auth/presentation/screens/on_board_page.dart';
import 'package:electronic_store/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheUserRepo.init();

  await Supabase.initialize(
    url: 'https://obukfdikkmtsvwcqkhrf.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9idWtmZGlra210c3Z3Y3FraHJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE2NTU0MjQsImV4cCI6MjA4NzIzMTQyNH0.aaz54fXmm0DzDI5RMta--EetH8v6DSxJmcFsR37DMFM",
  );

  final isLogin = await CacheUserRepo.isLogin();

  runApp(ElectronicShop(isLogin: isLogin));
}

class ElectronicShop extends StatelessWidget {
  final bool isLogin;
  const ElectronicShop({super.key, required this.isLogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppauthCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Electronic Shop',
        home: isLogin ? const SplashScreen() : const OnBoardPage(),
      ),
    );
  }
}
