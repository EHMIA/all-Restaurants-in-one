import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/core/repositories/restaurant_data_repo.dart';
import '../../../../core/models/restaurant_data_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit({required this.repo}):super(HomeInitial());
  final RestaurantDataRepo repo;

  Future<void>getHomeFeature()async{
    try {
  emit(HomeLoading());
  final result=await repo.getAllRestuarant();
  emit(HomeSuccess(result));
} on ServerException catch (e) {
  emit(HomeError(message: e.errorModel.error));
}

  }
  
}

bool checkIfRestaurantOpen(List<OpeningHoursModel> openingHours) {
  if (openingHours.isEmpty) return false;

  final now = DateTime.now();
  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String todayStr = weekdays[now.weekday - 1];
  final todayHours = openingHours.firstWhere(
    (hour) => hour.day.toLowerCase() == todayStr.toLowerCase(),
    orElse: () => OpeningHoursModel(
      day: '',
      opens: '',
      closes: '',
      isClosed: true,
      id: '',
    ),
  );
  if (todayHours.isClosed ||
      todayHours.opens.isEmpty ||
      todayHours.closes.isEmpty) {
    return false;
  }

  try {
    final openParts = todayHours.opens.split(':');
    final closeParts = todayHours.closes.split(':');

    final openTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(openParts[0]),
      int.parse(openParts[1]),
    );
    var closeTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(closeParts[0]),
      int.parse(closeParts[1]),
    );

    if (closeTime.isBefore(openTime)) {
      closeTime = closeTime.add(const Duration(days: 1));
    }

    return now.isAfter(openTime) && now.isBefore(closeTime);
  } catch (e) {
    return false;
  }
}
