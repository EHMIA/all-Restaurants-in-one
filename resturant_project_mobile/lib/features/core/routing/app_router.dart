import 'package:go_router/go_router.dart';
import 'package:resturant_project/features/auth/login_screen.dart';
import 'package:resturant_project/features/auth/register_screen.dart';
import 'package:resturant_project/features/core/routing/route_name.dart';
import 'package:resturant_project/features/expolore_screen/explore_screen.dart';
import 'package:resturant_project/features/home_screen/home_screen.dart';
import 'package:resturant_project/features/profile_screen/settings_screen.dart';
import 'package:resturant_project/features/review_page/review_page.dart';
import 'package:resturant_project/layout_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/restaurant_page_screen.dart';
import 'package:resturant_project/features/restaurant_page_screen/write_review_screen.dart';

class AppRouter {
  static GoRouter goRouter = GoRouter(
    initialLocation: RouteName.layOutScreen,
    routes: [
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
          restaurantId: (state.extra as Map<String, dynamic>)['restaurantId'],
        ),
      ),
      GoRoute(
        path: RouteName.myReviewPgeScreen,
        name: RouteName.myReviewPgeScreen,
        builder: (context, state) => ReviewPage(),
      ),
      GoRoute(
        path: RouteName.signInPage,
        name: RouteName.signInPage,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: RouteName.registerPage,
        name: RouteName.registerPage,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: RouteName.writeReviewPage,
        name: RouteName.writeReviewPage,
        builder: (context, state) => WriteReviewScreen(
          resImage: (state.extra as Map<String, dynamic>)['image'],
          resName: (state.extra as Map<String, dynamic>)['resName'],
          resRate: (state.extra as Map<String, dynamic>)['resRate'],
          numOfReviews: (state.extra as Map<String, dynamic>)['numOfReviews'],
          resSpace: (state.extra as Map<String, dynamic>)['resSpace'],
          category: (state.extra as Map<String, dynamic>)['category'],
          restaurantId: (state.extra as Map<String, dynamic>)['restaurantId'],
          userId: (state.extra as Map<String, dynamic>)['userId'],
        ),
      ),
      GoRoute(
        path: RouteName.settingsPage,
        name: RouteName.settingsPage,
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );
}
