import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String phone,
    required String address,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username, 'phone': phone, 'address': address},
    );
    if (response.user == null) {
      throw Exception("SignUp Failed");
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception("SignIn Failed");
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
