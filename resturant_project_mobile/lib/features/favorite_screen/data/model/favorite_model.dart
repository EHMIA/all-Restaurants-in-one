import 'dart:convert';

import '../../../../core/models/restaurant_data_model.dart' as restaurant_model;

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  String message;
  List<Datum> data;

  FavoriteModel({required this.message, required this.data});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  Restaurant restaurant;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.restaurant,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
    user: json["user"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "restaurant": restaurant.toJson(),
    "user": user,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Restaurant {
  CoverPhoto coverPhoto;
  String id;
  String name;
  int rating;
  bool delivery;
  String priceRange;
  List<OpeningHour> openingHours;
  bool isOpen;
  String serverTime;
  List<String> cuisineType;
  int reviewsCount;
  String status;
  String phoneNumber;
  String whatsappNumber;
  bool isFavorite;

  Restaurant({
    required this.coverPhoto,
    required this.id,
    required this.name,
    required this.rating,
    required this.delivery,
    required this.priceRange,
    required this.openingHours,
    required this.isOpen,
    required this.serverTime,
    required this.cuisineType,
    required this.reviewsCount,
    required this.status,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.isFavorite,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    coverPhoto: CoverPhoto.fromJson(json["coverPhoto"]),
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    rating: json["rating"] ?? 0,
    delivery: json["delivery"] ?? false,
    priceRange: json["priceRange"] ?? '',
    openingHours: List<OpeningHour>.from(
      (json["openingHours"] as List?)?.map((x) => OpeningHour.fromJson(x)) ??
          [],
    ),
    isOpen: json["isOpen"] ?? false,
    serverTime: json["serverTime"] ?? '',
    cuisineType: List<String>.from(json["cuisineType"] as List? ?? []),
    reviewsCount: json["reviewsCount"] ?? 0,
    status: json["status"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    whatsappNumber: json["whatsappNumber"] ?? '',
    isFavorite: json["isFavorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "coverPhoto": coverPhoto.toJson(),
    "_id": id,
    "name": name,
    "rating": rating,
    "delivery": delivery,
    "priceRange": priceRange,
    "openingHours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
    "isOpen": isOpen,
    "serverTime": serverTime,
    "cuisineType": cuisineType,
    "reviewsCount": reviewsCount,
    "status": status,
    "phoneNumber": phoneNumber,
    "whatsappNumber": whatsappNumber,
    "isFavorite": isFavorite,
  };

  /// Convert Restaurant to RestaurantModel for navigation
  restaurant_model.RestaurantModel toRestaurantModel() {
    return restaurant_model.RestaurantModel(
      id: id,
      name: name,
      coverPhoto: restaurant_model.CoverPhoto(
        url: coverPhoto.url,
        publicId: coverPhoto.publicId,
      ),
      rating: rating,
      delivery: delivery,
      priceRange: priceRange,
      cuisineType: cuisineType,
      openingHours: openingHours
          .map(
            (oh) => restaurant_model.OpeningHoursModel(
              day: oh.day,
              opens: oh.opens,
              closes: oh.closes,
              isClosed: oh.isClosed,
              id: oh.id,
            ),
          )
          .toList(),
      status: status,
      reviewsCount: reviewsCount,
      isFavorite: isFavorite,
      isOpen: isOpen,
      serverTime: serverTime,
      phoneNumber: phoneNumber,
      whatsappNumber: whatsappNumber,
    );
  }
}

class CoverPhoto {
  String url;
  String publicId;

  CoverPhoto({required this.url, required this.publicId});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) =>
      CoverPhoto(url: json["url"], publicId: json["publicId"]);

  Map<String, dynamic> toJson() => {"url": url, "publicId": publicId};
}

class OpeningHour {
  String day;
  String opens;
  String closes;
  bool isClosed;
  String id;

  OpeningHour({
    required this.day,
    required this.opens,
    required this.closes,
    required this.isClosed,
    required this.id,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
    day: json["day"],
    opens: json["opens"],
    closes: json["closes"],
    isClosed: json["isClosed"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "opens": opens,
    "closes": closes,
    "isClosed": isClosed,
    "_id": id,
  };
}
