import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _resendTimer;
  static const int resendCountdownDuration = 60; // 60 seconds

  OtpBloc() : super(const OtpState(canResend: true)) {
    on<OtpVerifyButtonPressed>(_onVerifyOtp);
    on<OtpResendButtonPressed>(_onResendOtp);
  }

  Future<void> _onVerifyOtp(
    OtpVerifyButtonPressed event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation - replace with actual API call
    if (event.otp.length == 6 && event.otp == "123456") {
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

  Future<void> _onResendOtp(
    OtpResendButtonPressed event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, canResend: false));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Start countdown timer
    _startResendCountdown(emit);

    emit(
      state.copyWith(
        isLoading: false,
        resendCountdown: resendCountdownDuration,
        canResend: false,
      ),
    );
  }

  void _startResendCountdown(Emitter<OtpState> emit) {
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

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
