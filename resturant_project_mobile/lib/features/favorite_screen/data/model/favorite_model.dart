import 'dart:convert';

import '../../../../core/models/restaurant_data_model.dart' as restaurant_model;

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  final String message;
  final List<Datum> data;

  FavoriteModel({required this.message, required this.data});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      message: json["message"] ?? '',
      data: List<Datum>.from(
        (json["Data"] ?? []).map((x) => Datum.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Datum {
  final String id;
  final Restaurant restaurant;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Datum({
    required this.id,
    required this.restaurant,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"] ?? '',
      restaurant: Restaurant.fromJson(json["restaurant"] ?? {}),
      user: json["user"] ?? '',
      createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "restaurant": restaurant.toJson(),
      "user": user,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}

class Restaurant {
  final CoverPhoto coverPhoto;
  final String id;
  final String name;
  final String description;
  final List<AddressModel> addresses;
  final double rating;
  final bool delivery;
  final String priceRange;
  final List<OpeningHour> openingHours;
  final bool isOpen;
  final String serverTime;
  final List<String> cuisineType;
  final int reviewsCount;
  final String status;
  final String phoneNumber;
  final String whatsappNumber;
  final bool isFavorite;
  final String? facebookLink;

  Restaurant({
    required this.coverPhoto,
    required this.id,
    required this.name,
    required this.description,
    required this.addresses,
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
    this.facebookLink,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      coverPhoto: CoverPhoto.fromJson(json["coverPhoto"] ?? {}),

      id: json["_id"] ?? '',

      name: json["name"] ?? '',

      description: json["description"] ?? '',

      addresses: json['address'] != null
          ? List<AddressModel>.from(
              (json['address'] as List).map((x) => AddressModel.fromJson(x)),
            )
          : [],

      rating: (json["rating"] ?? 0).toDouble(),

      delivery: json["delivery"] ?? false,

      priceRange: json["priceRange"] ?? '',

      openingHours: List<OpeningHour>.from(
        (json["openingHours"] ?? []).map((x) => OpeningHour.fromJson(x)),
      ),

      isOpen: json["isOpen"] ?? false,

      serverTime: json["serverTime"] ?? '',

      cuisineType: List<String>.from(json["cuisineType"] ?? []),

      reviewsCount: json["reviewsCount"] ?? 0,

      status: json["status"] ?? '',

      phoneNumber: json["phoneNumber"] ?? '',

      whatsappNumber: json["whatsappNumber"] ?? '',

      isFavorite: json["isFavorite"] ?? false,

      facebookLink: json["facebookLink"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "coverPhoto": coverPhoto.toJson(),
      "_id": id,
      "name": name,
      "description": description,
      "address": List<dynamic>.from(addresses.map((x) => x.toJson())),
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
      "facebookLink": facebookLink,
    };
  }

  /// Convert Favorite Restaurant -> Main RestaurantModel
  restaurant_model.RestaurantModel toRestaurantModel() {
    return restaurant_model.RestaurantModel(
      id: id,
      name: name,
      description: description,
      address: addresses
          .map(
            (a) => restaurant_model.AddressModel(
              governorate: a.governorate,
              city: a.city,
              street: a.street,
              details: a.details,
              id: a.id,
            ),
          )
          .toList(),
      coverPhoto: restaurant_model.CoverPhoto(
        url: coverPhoto.url,
        publicId: coverPhoto.publicId,
        id: '',
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
      facebookLink: facebookLink,
    );
  }
}

class AddressModel {
  final String governorate;
  final String city;
  final String street;
  final String details;
  final String id;

  AddressModel({
    required this.governorate,
    required this.city,
    required this.street,
    required this.details,
    required this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      details: json['details'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "governorate": governorate,
      "city": city,
      "street": street,
      "details": details,
      "_id": id,
    };
  }
}

class CoverPhoto {
  final String url;
  final String publicId;

  CoverPhoto({required this.url, required this.publicId});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(url: json["url"] ?? '', publicId: json["publicId"] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {"url": url, "publicId": publicId};
  }
}

class OpeningHour {
  final String day;
  final String opens;
  final String closes;
  final bool isClosed;
  final String id;

  OpeningHour({
    required this.day,
    required this.opens,
    required this.closes,
    required this.isClosed,
    required this.id,
  });

  factory OpeningHour.fromJson(Map<String, dynamic> json) {
    return OpeningHour(
      day: json["day"] ?? '',
      opens: json["opens"] ?? '',
      closes: json["closes"] ?? '',
      isClosed: json["isClosed"] ?? false,
      id: json["_id"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "day": day,
      "opens": opens,
      "closes": closes,
      "isClosed": isClosed,
      "_id": id,
    };
  }
}
