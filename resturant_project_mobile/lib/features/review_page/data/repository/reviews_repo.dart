import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';

import '../model/reviews_model.dart';
class ReviewRepo {
  final ApiConsumer api;

  ReviewRepo({required this.api});

  //! GET all reviews for current user
  Future<List<Review>> getUserReviews() async {
    final response = await api.get(EndPoints.getRreviews);

    final List<dynamic> dataField = response['Data'] ?? [];
    return dataField.map((e) => Review.fromJson(e)).toList();
  }

  //! ADD review (POST)
  Future<Review> addReview({
    required String restaurantId,
    required String content,
    required double rating,
  }) async {
    final response = await api.post(
      '${EndPoints.addRreviews}/$restaurantId',
      data: {
        "Content": content,
        "rating": rating,
      },
    );

    return Review.fromJson(response['data']);
  }

  Future<void> deleteReview(String reviewId) async {
    await api.delete('${EndPoints.deleteRreviews}/$reviewId');
  }
}
