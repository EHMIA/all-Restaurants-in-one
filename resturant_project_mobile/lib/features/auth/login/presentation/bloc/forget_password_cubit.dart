import 'package:flutter_bloc/flutter_bloc.dart';
import 'forget_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendOtp(String emailOrPhone) async {
    emit(ForgotPasswordLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(
        ForgotPasswordSuccess(
          message: "OTP sent successfully to $emailOrPhone",
        ),
      );
    } catch (e) {
      emit(
        ForgotPasswordFailure(
          errorMessage: "Failed to send OTP. Please try again.",
        ),
      );
    }
  }

  void reset() {
    emit(ForgotPasswordInitial());
  }
}
