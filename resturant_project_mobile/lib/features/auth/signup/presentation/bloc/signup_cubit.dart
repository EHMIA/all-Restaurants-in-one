import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, isSuccess: false, error: e.toString()),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void reset() {
    emit(SignUpState());
  }
}
