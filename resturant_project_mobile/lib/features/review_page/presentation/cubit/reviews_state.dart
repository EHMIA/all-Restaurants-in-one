import 'package:resturant_project/features/review_page/data/model/reviews_model.dart';

abstract class ReviewsState {}

class ReviewInstial extends ReviewsState{}

class ReviewLoading extends ReviewsState{}

class ReviewSuccess extends ReviewsState{
  final List<Review> review;

  ReviewSuccess({required this.review});
}

class ReviewError extends ReviewsState{
  final String message;

  ReviewError({required this.message});
}