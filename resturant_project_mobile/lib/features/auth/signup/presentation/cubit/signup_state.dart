import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {

  @override
  List<Object?> get props => [];
}

class SignUpLoading extends SignUpState{
}
class SignUpInitial extends SignUpState {}

class SignUpFailure extends SignUpState{
  final String errorMessage;

  SignUpFailure({required this.errorMessage});
  
  @override
  List<Object?> get props => [errorMessage];
}
class SignUpSuccess extends SignUpState{

}