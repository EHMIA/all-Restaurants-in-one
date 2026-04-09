import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Timer? _resendTimer;
  static const int resendCountdownDuration = 60; // 60 seconds

  OtpCubit() : super(const OtpState(canResend: true));

  Future<void> verifyOtp(String otp, String email) async {
    emit(state.copyWith(isLoading: true, error: null));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation - replace with actual API call
    if (otp.length == 6 && otp == "123456") {
      emit(state.copyWith(isLoading: false, isOtpVerified: true));
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: "Invalid OTP. Please try again.",
        ),
      );
    }
  }

  Future<void> resendOtp(String email) async {
    emit(state.copyWith(isLoading: true, error: null, canResend: false));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Start countdown timer
    _startResendCountdown();

    emit(
      state.copyWith(
        isLoading: false,
        resendCountdown: resendCountdownDuration,
        canResend: false,
      ),
    );
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    int countdown = resendCountdownDuration;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      emit(state.copyWith(resendCountdown: countdown));

      if (countdown <= 0) {
        timer.cancel();
        emit(state.copyWith(canResend: true, resendCountdown: 0));
      }
    });
  }

  void reset() {
    _resendTimer?.cancel();
    emit(const OtpState(canResend: true));
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
