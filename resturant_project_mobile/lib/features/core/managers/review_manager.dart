class ReviewManager {
  static final ReviewManager _instance = ReviewManager._internal();

  factory ReviewManager() {
    return _instance;
  }

  ReviewManager._internal();

  /// All reviews stored in app (restaurantId -> list of reviews)
  final Map<String, List<Map<String, dynamic>>> _reviewsByRestaurant = {};

  /// Add a review to a restaurant
  void addReview(String restaurantId, Map<String, dynamic> review) {
    if (!_reviewsByRestaurant.containsKey(restaurantId)) {
      _reviewsByRestaurant[restaurantId] = [];
    }
    _reviewsByRestaurant[restaurantId]!.insert(0, review);
  }

  /// Get all reviews for a restaurant
  List<Map<String, dynamic>> getReviewsForRestaurant(String restaurantId) {
    return _reviewsByRestaurant[restaurantId] ?? [];
  }

  /// Get all reviews by the current user across all restaurants
  List<Map<String, dynamic>> getUserReviews(String userId) {
    final userReviews = <Map<String, dynamic>>[];
    _reviewsByRestaurant.forEach((restaurantId, reviews) {
      for (var review in reviews) {
        if (review['userId'] == userId) {
          userReviews.add({...review, 'restaurantId': restaurantId});
        }
      }
    });
    // Sort by newest first
    userReviews.sort(
      (a, b) =>
          (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime),
    );
    return userReviews;
  }

  /// Delete a review
  bool deleteReview(String restaurantId, int reviewIndex) {
    if (_reviewsByRestaurant.containsKey(restaurantId) &&
        reviewIndex >= 0 &&
        reviewIndex < _reviewsByRestaurant[restaurantId]!.length) {
      _reviewsByRestaurant[restaurantId]!.removeAt(reviewIndex);
      return true;
    }
    return false;
  }

  /// Delete a specific review by matching userId and timestamp
  bool deleteReviewByUserAndTime(
    String restaurantId,
    String userId,
    DateTime timestamp,
  ) {
    if (!_reviewsByRestaurant.containsKey(restaurantId)) {
      return false;
    }

    final reviews = _reviewsByRestaurant[restaurantId]!;
    int indexToRemove = -1;

    for (int i = 0; i < reviews.length; i++) {
      if (reviews[i]['userId'] == userId &&
          reviews[i]['timestamp'] == timestamp) {
        indexToRemove = i;
        break;
      }
    }

    if (indexToRemove >= 0) {
      reviews.removeAt(indexToRemove);
      return true;
    }
    return false;
  }

  /// Get average rating for a restaurant
  double getAverageRating(String restaurantId) {
    final reviews = _reviewsByRestaurant[restaurantId] ?? [];
    if (reviews.isEmpty) return 0.0;

    double totalRating = reviews.fold(
      0.0,
      (sum, review) => sum + (review['rating'] as num),
    );
    return totalRating / reviews.length;
  }

  /// Get review count for a restaurant
  int getReviewCount(String restaurantId) {
    return _reviewsByRestaurant[restaurantId]?.length ?? 0;
  }

  /// Clear all reviews (for testing or reset)
  void clearAll() {
    _reviewsByRestaurant.clear();
  }
}
