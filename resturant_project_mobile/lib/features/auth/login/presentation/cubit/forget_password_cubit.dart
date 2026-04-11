import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/auth/login/data/models/forget_password_model.dart';
import 'package:resturant_project/features/auth/login/data/repository/forget_password_repo.dart';
import 'forget_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.forgetRepo}) : super(ForgotPasswordInitial());
  final ForgetPasswordRepo forgetRepo;

  Future<void> sendOtp(String email) async {
    try {
      emit(ForgotPasswordLoading());
  final response=await forgetRepo.sendOtpByEmail(email);
  emit(ForgotPasswordSuccess(message: "message send successfully to $email",otp: response.otp));
} on ServerException catch (e) {
  emit(ForgotPasswordFailure(errorMessage: e.errorModel.error));
}

    
  }

  void reset() {
    emit(ForgotPasswordInitial());
  }
}
