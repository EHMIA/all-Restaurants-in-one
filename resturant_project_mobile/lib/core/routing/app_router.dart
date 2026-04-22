import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'package:resturant_project/features/auth/auth_route/presentaion/page/auth_route_screen.dart';
import 'package:resturant_project/features/auth/login/data/repository/forget_password_repo.dart';
import 'package:resturant_project/features/auth/login/data/repository/otp_repo.dart';
import 'package:resturant_project/features/auth/login/presentation/cubit/otp_cubit.dart';
import 'package:resturant_project/features/auth/login/presentation/page/forgot_password_screen.dart';
import 'package:resturant_project/features/auth/login/presentation/page/otp_screen.dart';
import 'package:resturant_project/features/auth/login/presentation/page/reset_password_screen.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/explore_screen.dart';
import 'package:resturant_project/features/review_page/review_page.dart';
import 'package:resturant_project/features/splash_screen/splash_screen.dart';
import 'package:resturant_project/features/bottom_navigation_bar/page/layout_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/restaurant_page_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/page/write_review_screen.dart';
import '../../features/auth/login/presentation/cubit/forget_password_cubit.dart';
import '../../features/home_screen/presentation/page/home_screen.dart';

class AppRouter {
  static GoRouter goRouter = GoRouter(
    initialLocation: RouteName.layOutScreen,
    routes: [
      GoRoute(
        path: RouteName.onBoardingScreen,
        name: RouteName.onBoardingScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.authRouteScreen,
        name: RouteName.authRouteScreen,
        builder: (context, state) => const AuthRouteScreen(),
      ),
      GoRoute(
        path: RouteName.layOutScreen,
        name: RouteName.layOutScreen,
        builder: (context, state) => LayoutScreen(),
      ),

      GoRoute(
        path: RouteName.homeScreen,
        name: RouteName.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),

      GoRoute(
        path: RouteName.explorScreen,
        name: RouteName.explorScreen,
        builder: (context, state) {
          final searchText = state.extra as String?;
          return ExploreScreen(searchText: searchText);
        },
      ),
      GoRoute(
        path: RouteName.restaurantPageScreen,
        name: RouteName.restaurantPageScreen,
        builder: (context, state) {
          final restaurant = state.extra as RestaurantModel;
          return RestaurantPageScreen(restaurant: restaurant);
        },
      ),
      GoRoute(
        path: RouteName.myReviewPgeScreen,
        name: RouteName.myReviewPgeScreen,
        builder: (context, state) => ReviewPage(),
      ),
      GoRoute(
        path: RouteName.forgotPasswordPage,
        name: RouteName.forgotPasswordPage,
        builder: (context, state) => BlocProvider(
          create: (context) => ForgotPasswordCubit(
            forgetRepo: ForgetPasswordRepo(api: DioConsumer(dio: Dio())),
          ),
          child: ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: RouteName.otpPage,
        name: RouteName.otpPage,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return BlocProvider(
            create: (context) => OtpCubit(
              otpRepo: OtpRepo(api: DioConsumer(dio: Dio())),
            ),
            child: OtpScreen(email: data["email"], otp: data["otp"]),
          );
        },
      ),
      GoRoute(
        path: RouteName.resetPasswordPage,
        name: RouteName.resetPasswordPage,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: RouteName.writeReviewPage,
        name: RouteName.writeReviewPage,
        builder: (context, state) => WriteReviewScreen(),
      ),
    ],
  );
}
