import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_route_state.dart';

class AuthRouteCubit extends Cubit<AuthRouteState> {
  AuthRouteCubit() : super(AuthRouteState(selectedIndex: 0));

  void selectLoginTab() {
    if (state.selectedIndex != 0) {
      emit(state.copyWith(selectedIndex: 0));
    }
  }

  void selectSignUpTab() {
    if (state.selectedIndex != 1) {
      emit(state.copyWith(selectedIndex: 1));
    }
  }

  void switchToSignUp() {
    emit(state.copyWith(selectedIndex: 1));
  }

  void switchToLogin() {
    emit(state.copyWith(selectedIndex: 0));
  }

  void reset() {
    emit(AuthRouteState(selectedIndex: 0));
  }
}
