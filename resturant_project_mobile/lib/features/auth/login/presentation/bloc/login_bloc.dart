import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginButtonPressed>(_onLogin);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    await Future.delayed(const Duration(seconds: 2)); // mock API

    if (event.email == "mohamed@gmail.com" && event.password == "Std#050126") {
      emit(state.copyWith(isLoading: false));
    } else {
      emit(
        state.copyWith(isLoading: false, error: "Invalid email or password"),
      );
    }
  }
}
