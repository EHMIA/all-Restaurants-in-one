import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/auth/signup/presentation/bloc/signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

      try {
        await Future.delayed(const Duration(seconds: 2));

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: e.toString(),
          ),
        );
      }
    });

  }
}
