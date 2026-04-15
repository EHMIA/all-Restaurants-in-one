import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/features/auth/login/data/repository/login_repo.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/page/login_screen.dart';
import 'package:resturant_project/features/auth/signup/data/repository/sign_up_repo.dart';
import '../../../../signup/presentation/cubit/signup_cubit.dart';
import '../../cubit/auth_route_cubit.dart';
import '../../cubit/auth_route_state.dart';
import '../../../../signup/presentation/page/sign_up_page.dart';

class CustomAuthSwitcherBody extends StatelessWidget {
  const CustomAuthSwitcherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthRouteCubit, AuthRouteState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              final isLogin = child.key == const ValueKey("login");
              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: Offset(isLogin ? -1.0 : 1.0, 0.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              );
            },
            child: state.selectedIndex == 0
                ? BlocProvider(
                    key: const ValueKey("login"),
                    create: (context) => LoginCubit(loginRepo: LoginRepository(api:DioConsumer(dio: Dio()) )),
                    child: LoginScreen(
                      onSignUpClicked: () =>
                          context.read<AuthRouteCubit>().selectSignUpTab(),
                    ),
                  )
                : BlocProvider(
                    key: const ValueKey("signup"),
                    create: (context) => SignUpCubit(signUpRepo: SignUpRepo(api: DioConsumer(dio: Dio()))),
                    child: SignUpPage(
                      onLoginClicked: () =>
                          context.read<AuthRouteCubit>().selectLoginTab(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
