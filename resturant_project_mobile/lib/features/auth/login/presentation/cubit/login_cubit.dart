import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import '../../data/repository/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepo}) : super(LoginState());

  final LoginRepository loginRepo;

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      final loginModel = await loginRepo.login(email: email, password: password);

      emit(LoginSuccess(message:loginModel.message));
    } on ServerException catch (e) {
      emit(LoginFailure(errorMessage: e.errorModel.error));
    }
  }
}
