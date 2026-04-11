import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/auth/signup/data/repository/sign_up_repo.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.signUpRepo}) : super(SignUpInitial());
  final SignUpRepo signUpRepo;

  Future<void> signUp(
    String email,
    String fullname,
    String password,
    String comfirmPassword,
    String phone,
  ) async {
    try {
      emit(SignUpLoading());
      await signUpRepo.signUp(
        email: email,
        fullname: fullname,
        password: password,
        comfirmPassword: comfirmPassword,
        phone: phone,
      );
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(errorMessage: e.errorModel.error));
    }
  }
}
