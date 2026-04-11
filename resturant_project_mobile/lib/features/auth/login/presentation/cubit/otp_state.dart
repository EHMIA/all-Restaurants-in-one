import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}
class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
class OtpFailure extends OtpState {
  final String errorMessage;

  OtpFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
