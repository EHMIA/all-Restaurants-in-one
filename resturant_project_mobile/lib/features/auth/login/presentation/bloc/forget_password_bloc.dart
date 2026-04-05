import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(ForgotPasswordLoading());

      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(
          ForgotPasswordSuccess(
            message: "OTP sent successfully to ${event.emailOrPhone}",
          ),
        );
      } catch (e) {
        emit(
          ForgotPasswordFailure(
            errorMessage: "Failed to send OTP. Please try again.",
          ),
        );
      }
    });
  }
}
