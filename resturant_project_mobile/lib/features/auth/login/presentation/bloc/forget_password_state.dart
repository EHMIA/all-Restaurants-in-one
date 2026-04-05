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

  ForgotPasswordSuccess({required this.message});
  
  @override
  List<Object?> get props => [message];
}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailure({required this.errorMessage});
  
  @override
  List<Object?> get props =>  [errorMessage];
}
