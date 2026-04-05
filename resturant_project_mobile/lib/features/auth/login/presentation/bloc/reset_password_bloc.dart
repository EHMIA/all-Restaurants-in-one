import 'package:flutter_bloc/flutter_bloc.dart';

import 'reset_password_event.dart';
import 'reset_password_state.dart';


class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>((event, emit) async {
      if (event.newPassword != event.confirmPassword) {
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
    });
  }
}
