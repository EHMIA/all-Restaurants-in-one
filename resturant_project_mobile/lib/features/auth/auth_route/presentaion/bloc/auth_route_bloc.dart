import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_route_event.dart';
import 'auth_route_state.dart';

class AuthRouteBloc extends Bloc<AuthRouteEvent, AuthRouteState> {
  AuthRouteBloc() : super(AuthRouteState(selectedIndex: 0)) {
    on<TapLoginTab>((event, emit) {
      if (state.selectedIndex != 0) {
        emit(state.copyWith(selectedIndex: 0));
      }
    });

    on<TapSignUpTab>((event, emit) {
      if (state.selectedIndex != 1) {
        emit(state.copyWith(selectedIndex: 1));
      }
    });

    on<SwitchToSignUp>((event, emit) {
      emit(state.copyWith(selectedIndex: 1));
    });

    on<SwitchToLogin>((event, emit) {
      emit(state.copyWith(selectedIndex: 0));
    });
  }
}
