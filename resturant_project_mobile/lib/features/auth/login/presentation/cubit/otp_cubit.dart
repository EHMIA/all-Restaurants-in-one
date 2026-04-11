import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/auth/login/data/repository/otp_repo.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.otpRepo}) : super(OtpInitial());

  final OtpRepo otpRepo;

  Future<void> verifyOtp(String email, String otp) async {
    try {
      emit(OtpLoading());

      final response = await otpRepo.verifyOtp(email, otp);

      emit(OtpSuccess(message: response.message));
    } on ServerException catch (e) {
      emit(OtpFailure(errorMessage: e.errorModel.error));
    }
  }

  void reset() {
    emit(OtpInitial());
  }
}
