import 'package:equatable/equatable.dart';


class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState{
  final String message;

  LoginSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoginFailure extends LoginState{
  final String errorMessage;

  LoginFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class LoginLoading extends LoginState{
}
