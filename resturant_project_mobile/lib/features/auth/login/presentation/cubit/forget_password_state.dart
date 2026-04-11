import 'package:equatable/equatable.dart';

sealed class ForgotPasswordState extends Equatable {}

final class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  final String otp;

  ForgotPasswordSuccess({required this.message, required this.otp});

  @override
  List<Object?> get props => [message, otp];
}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailure({required this.errorMessage});
  
  @override
  List<Object?> get props =>  [errorMessage];
}
