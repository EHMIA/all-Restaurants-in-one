import 'package:equatable/equatable.dart';

sealed class ResetPasswordState extends Equatable {}

final class ResetPasswordInitial extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  ResetPasswordSuccess({required this.message});
  
  @override
  List<Object?> get props => [message];
}

final class ResetPasswordFailure extends ResetPasswordState {
  final String errorMessage;

  ResetPasswordFailure({required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage];
}
