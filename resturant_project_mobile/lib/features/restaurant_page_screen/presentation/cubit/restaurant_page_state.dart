import 'package:resturant_project/core/models/restaurant_details_model.dart';

abstract class RestaurantPageState {}

class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageLoading extends RestaurantPageState {}

class RestaurantPageSuccess extends RestaurantPageState {
  final RestaurantDetailsModel model;

   RestaurantPageSuccess(this.model);
}

class RestaurantPageError extends RestaurantPageState {
  final String message;
   RestaurantPageError({required this.message});
}