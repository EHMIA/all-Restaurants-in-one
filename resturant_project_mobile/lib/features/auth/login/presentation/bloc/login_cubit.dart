import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));

    await Future.delayed(const Duration(seconds: 2));

    if (email == "mohamed@gmail.com" && password == "Std#050126") {
      emit(state.copyWith(isLoading: false));
    } else {
      emit(
        state.copyWith(isLoading: false, error: "Invalid email or password"),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void reset() {
    emit(const LoginState());
  }
}
