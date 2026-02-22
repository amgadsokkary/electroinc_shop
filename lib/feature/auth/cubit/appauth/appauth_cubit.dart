import 'package:bloc/bloc.dart';
import 'package:electronic_store/core/cache/cache_user_repo.dart';
import 'package:electronic_store/feature/auth/data/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'appauth_state.dart';

class AppauthCubit extends Cubit<AppauthState> {
  final AuthService authService = AuthService();
  AppauthCubit() : super(AppauthInitial());

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String phone,
    required String address,
  }) async {
    emit(AppauthLoading());
    try {
      await authService.signUp(
        email: email,
        username: username,
        password: password,
        phone: phone,
        address: address,
      );
      emit(AppauthSuccess());
      CacheUserRepo.login(true);
    } catch (e) {
      emit(AppauthError(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AppauthLoading());
    try {
      await authService.signIn(email: email, password: password);
      emit(AppauthSuccess());
      CacheUserRepo.login(true);
    } catch (e) {
      emit(AppauthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AppauthLoading());
    try {
      await authService.signOut();
      emit(AppauthSuccess());
      CacheUserRepo.logout();
    } catch (e) {
      emit(AppauthError(message: e.toString()));
    }
  }
}
