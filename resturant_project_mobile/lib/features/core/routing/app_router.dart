import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/auth/auth_route/presentaion/page/auth_route_screen.dart';
import 'package:resturant_project/features/auth/login/presentation/page/forgot_password_screen.dart';
import 'package:resturant_project/features/auth/login/presentation/page/otp_screen.dart';
import 'package:resturant_project/features/auth/login/presentation/page/reset_password_screen.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/expolore_screen/presentation/page/explore_screen.dart';
import 'package:resturant_project/features/home_screen/home_screen.dart';
import 'package:resturant_project/features/review_page/review_page.dart';
import 'package:resturant_project/features/splash_screen/splash_screen.dart';
import 'package:resturant_project/features/bottom_navigation_bar/page/layout_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/restaurant_page_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/write_review_screen.dart';

class AppRouter {
  static GoRouter goRouter = GoRouter(
    initialLocation: RouteName.resetPasswordPage,
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
        builder: (context, state) => RestaurantPageScreen(
          image: (state.extra as Map<String, dynamic>)['image'],
          resName: (state.extra as Map<String, dynamic>)['resName'],
          resPeopleRate: (state.extra as Map<String, dynamic>)['resPeopleRate'],
          resRate: (state.extra as Map<String, dynamic>)['resRate'],
          resSpace: (state.extra as Map<String, dynamic>)['resSpace'],
          category: (state.extra as Map<String, dynamic>)['category'],
          isOpen: (state.extra as Map<String, dynamic>)['isOpen'],
        ),
      ),
      GoRoute(
        path: RouteName.myReviewPgeScreen,
        name: RouteName.myReviewPgeScreen,
        builder: (context, state) => ReviewPage(),
      ),
      GoRoute(
        path: RouteName.forgotPasswordPage,
        name: RouteName.forgotPasswordPage,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteName.otpPage,
        name: RouteName.otpPage,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpScreen(email: email);
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
