import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repo.dart';
import 'profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final UserRepo repo;

  ProfileCubit({required this.repo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final userModel = await repo.getUserProfile();
      emit(ProfileSuccess(userModel: userModel));
    } catch (e) {
      print("Profile Error: $e");
      emit(ProfileFailure(message: e.toString()));
    }
  }
}
