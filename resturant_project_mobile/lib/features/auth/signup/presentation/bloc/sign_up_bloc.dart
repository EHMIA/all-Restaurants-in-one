import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/auth/signup/presentation/bloc/sign_up_event.dart';
import 'package:resturant_project/features/auth/signup/presentation/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<SignUpButtonPressed>(_onSignUp);
  }

  Future<void> _onSignUp(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    await Future.delayed(const Duration(seconds: 2)); // fake API

    if (event.email == "test@test.com") {
      emit(state.copyWith(isLoading: false, error: "Email already exists"));
    } else {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    }
  }
}
