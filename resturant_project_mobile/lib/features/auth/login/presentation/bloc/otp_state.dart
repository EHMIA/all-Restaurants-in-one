import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isOtpVerified;
  final int resendCountdown;
  final bool canResend;

  const OtpState({
    this.isLoading = false,
    this.error,
    this.isOtpVerified = false,
    this.resendCountdown = 0,
    this.canResend = false,
  });

  OtpState copyWith({
    bool? isLoading,
    String? error,
    bool? isOtpVerified,
    int? resendCountdown,
    bool? canResend,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    isOtpVerified,
    resendCountdown,
    canResend,
  ];
}
