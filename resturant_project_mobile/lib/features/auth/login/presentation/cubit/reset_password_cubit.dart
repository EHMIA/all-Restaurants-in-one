import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      emit(ResetPasswordFailure(errorMessage: "Passwords do not match"));
      return;
    }

    emit(ResetPasswordLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(ResetPasswordSuccess(message: "Password reset successfully!"));
    } catch (e) {
      emit(
        ResetPasswordFailure(
          errorMessage: "Something went wrong. Please try again.",
        ),
      );
    }
  }

  void reset() {
    emit(ResetPasswordInitial());
  }
}
