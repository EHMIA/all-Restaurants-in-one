import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/review_page/data/repository/reviews_repo.dart';

import '../../../profile_screen/presentation/cubit/profile_cubit.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit({required this.repo}) : super(ReviewInstial());

  final ReviewRepo repo;

  Future<void> getUserReviews() async {
    try {
      emit(ReviewLoading());
      final response = await repo.getUserReviews();
      emit(ReviewSuccess(review: response));
    } on ServerException catch (e) {
      emit(ReviewError(message: e.errorModel.error));
    }
  }

  Future<void> addReview({
    required String restaurantId,
    required String content,
    required double rating,
    required ProfileCubit profileCubit,
  }) async {
    final previousState = state;

    try {
      emit(ReviewLoading());

      final review = await repo.addReview(
        restaurantId: restaurantId,
        content: content,
        rating: rating,
      );

      if (previousState is ReviewSuccess) {
        final updatedReviews = [review, ...previousState.review];

        emit(ReviewSuccess(review: updatedReviews));
      } else {
        emit(ReviewSuccess(review: [review]));
      }

      await profileCubit.getProfile();
    } on ServerException catch (e) {
      emit(ReviewError(message: e.errorModel.error));
    }
  }


Future<void> deleteReview({
    required String restaurantId,
    required String reviewId,
    required ProfileCubit profileCubit,
  }) async {
    try {
      if (state is ReviewSuccess) {
        final currentReviews = (state as ReviewSuccess).review;

        final updatedReviews = currentReviews
            .where((e) => e.id != reviewId)
            .toList();

        emit(ReviewSuccess(review: updatedReviews));

        await repo.deleteReview(restaurantId);

        await profileCubit.getProfile();
      }
    } on ServerException catch (e) {
      emit(ReviewError(message: e.errorModel.error));
    }
  }
} 
