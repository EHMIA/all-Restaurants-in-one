import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repo.dart';
import 'profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final UserRepo repo;

  ProfileCubit({required this.repo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    if (state is! ProfileSuccess) {
      emit(ProfileLoading());
    }
    try {
      final userModel = await repo.getUserProfile();
      emit(ProfileSuccess(userModel: userModel));
    } catch (e) {
     if (state is! ProfileSuccess) {
        emit(ProfileFailure(message: e.toString()));
      }
    }
  }
}
