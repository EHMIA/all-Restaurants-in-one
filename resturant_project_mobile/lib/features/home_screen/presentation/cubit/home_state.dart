import 'package:resturant_project/core/models/restaurant_data_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final RestaurantDataModel model;

  const HomeSuccess(this.model);
}

class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
}