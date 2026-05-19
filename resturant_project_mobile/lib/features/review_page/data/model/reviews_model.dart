
class Review {
  final String id;
  final Restaurant restaurant;
  final String content;
  final DateTime createdAt;
  final double rating;

  Review({
    required this.id,
    required this.restaurant,
    required this.content,
    required this.createdAt,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      restaurant: Restaurant.fromJson(json['restaurant']),
      content: json['Content'], 
      createdAt: DateTime.parse(json['createdAt']),
      rating: json['rating'],
    );
  }
}

class CoverPhoto {
  final String url;
  final String publicId;

  CoverPhoto({required this.url, required this.publicId});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(url: json['url'], publicId: json['publicId']);
  }
}

//====================================

class Restaurant {
  final String id;
  final String name;
  final CoverPhoto coverPhoto;

  Restaurant({required this.id, required this.name, required this.coverPhoto});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      coverPhoto: CoverPhoto.fromJson(json['coverPhoto']),
    );
  }
}

//====================================



//====================================

class GetReviewsModel {
  final List<Review> reviews;

  GetReviewsModel({required this.reviews});

  factory GetReviewsModel.fromJson(List<dynamic> json) {
    return GetReviewsModel(
      reviews: json.map((e) => Review.fromJson(e)).toList(),
    );
  }
}

//====================================
// ADD Review Model

class AddReviewModel {
  final String message;
  final Review review;

  AddReviewModel({required this.message, required this.review});

  factory AddReviewModel.fromJson(Map<String, dynamic> json) {
    return AddReviewModel(
      message: json['message'],
      review: Review.fromJson(json['data']),
    );
  }
}
