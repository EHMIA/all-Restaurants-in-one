import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/auth/login/data/repository/reset_password_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({required this.resetPasswordRepo})
    : super(ResetPasswordInitial());

  final ResetPasswordRepo resetPasswordRepo;

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    if (newPassword != confirmPassword) {
      emit(ResetPasswordFailure(errorMessage: "Passwords do not match"));
      return;
    }

    emit(ResetPasswordLoading());

    try {
      final response = await resetPasswordRepo.resetPassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        token: token,
      );
      emit(ResetPasswordSuccess(message: response.message));
    } on ServerException catch (e) {
      emit(ResetPasswordFailure(errorMessage: e.errorModel.error));
    }
  }

  void reset() {
    emit(ResetPasswordInitial());
  }
}
