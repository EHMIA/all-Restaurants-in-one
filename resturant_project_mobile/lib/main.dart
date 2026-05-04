import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/routing/app_router.dart';
import 'core/api/dio_consumer.dart';
import 'features/favorite_screen/data/repository/favorite_repo.dart';
import 'features/favorite_screen/presentation/cubit/favorite_cubit.dart';

void main() {
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
