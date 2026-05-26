import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/repository/edit_profile_repo.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.repo}):super(ChangePasswordInitiated());
final EditProfileRepo repo;

  Future<void> changePassword() async {
    emit(ChangePasswordInitiated());
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      emit(ChangePasswordFailure(error: 'Passwords do not match'));
      return;
    }

    try {
      emit(ChangePasswordLoading());
      final message = await repo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(ChangePasswordSuccess(message: message));
    } on ServerException catch (e) {
      emit(ChangePasswordFailure(error: e.errorModel.error));
    } catch (e) {
      emit(ChangePasswordFailure(error: 'Something went wrong'));
    }
  }
}