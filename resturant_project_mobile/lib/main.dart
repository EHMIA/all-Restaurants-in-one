import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/routing/app_router.dart';
import 'core/api/dio_consumer.dart';
import 'features/favorite_screen/data/repository/favorite_repo.dart';
import 'features/favorite_screen/presentation/cubit/favorite_cubit.dart';
import 'features/profile_screen/data/repository/profile_repo.dart';
import 'features/profile_screen/presentation/cubit/profile_cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 884),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FavoriteCubit(
                repo: FavoriteRepo(api: DioConsumer(dio: Dio())),
              )..getAllFavoriteRestaurant(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(
                repo: UserRepo(api: DioConsumer(dio: Dio())),
              )..getProfile(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.goRouter,
          ),
        );
      },
    );
  }
}
