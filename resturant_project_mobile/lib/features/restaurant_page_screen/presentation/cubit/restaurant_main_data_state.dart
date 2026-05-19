import 'package:resturant_project/core/models/restaurant_data_model.dart';

abstract class RestaurantMainDataState {}

class RestaurantMainDataInitial extends RestaurantMainDataState {}

class RestaurantMainDataLoading extends RestaurantMainDataState {}

class RestaurantMainDataSuccess extends RestaurantMainDataState {
  final RestaurantDataModel restaurant;

  RestaurantMainDataSuccess(this.restaurant);
}

class RestaurantMainDataError extends RestaurantMainDataState {
  final String message;
  RestaurantMainDataError({required this.message});
}
