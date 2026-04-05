import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const SignUpButtonPressed({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, phone, password];
}

class ClearSignUpError extends SignUpEvent {}
