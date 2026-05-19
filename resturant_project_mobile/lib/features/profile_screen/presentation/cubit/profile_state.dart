import 'package:resturant_project/features/profile_screen/data/model/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  ProfileSuccess({required this.userModel});
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}