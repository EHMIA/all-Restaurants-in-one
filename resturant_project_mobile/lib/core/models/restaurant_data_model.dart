class RestaurantDataModel {
  final List<RestaurantModel> data;

  RestaurantDataModel({required this.data});

  factory RestaurantDataModel.fromJson(Map<String, dynamic> json) {
    List<RestaurantModel> restaurants = [];
    final dataField = json['Data'];

    if (dataField is List) {
      // Multiple restaurants (from getAllRestaurants)
      restaurants = List<RestaurantModel>.from(
        dataField.map((x) => RestaurantModel.fromJson(x)),
      );
    } else if (dataField is Map<String, dynamic>) {
      // Single restaurant (from getOneRestaurant)
      restaurants = [RestaurantModel.fromJson(dataField)];
    }

    return RestaurantDataModel(data: restaurants);
  }
}

class RestaurantModel {
  final String id;
  final String name;
  final String? description;
  final CoverPhoto coverPhoto;
  final int rating;
  final bool delivery;
  final String priceRange;
  final String? owner;
  final String? facebookLink;
  final List<AddressModel> address;
  final String phoneNumber;
  final String? whatsappNumber;
  final List<String> cuisineType;
  final List<OpeningHoursModel> openingHours;
  final String status;
  final int reviewsCount;
  final bool isFavorite;
  final bool isOpen;
  final String serverTime;

  RestaurantModel({
    required this.id,
    required this.name,
    this.description,
    required this.coverPhoto,
    required this.rating,
    required this.delivery,
    required this.priceRange,
    this.owner,
    this.facebookLink,
    required this.address,
    required this.phoneNumber,
    this.whatsappNumber,
    required this.cuisineType,
    required this.openingHours,
    required this.status,
    required this.reviewsCount,
    required this.isFavorite,
    required this.isOpen,
    required this.serverTime,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      coverPhoto: CoverPhoto.fromJson(json['coverPhoto'] ?? {}),
      rating: json['rating'] ?? 0,
      delivery: json['delivery'] ?? false,
      priceRange: json['priceRange'] ?? 'low',
      owner: json['Owner'],
      facebookLink: json['facebookLink'],
      address: json['address'] != null
          ? List<AddressModel>.from(
              (json['address'] as List).map((x) => AddressModel.fromJson(x)),
            )
          : [],
      phoneNumber: json['phoneNumber'] ?? '',
      whatsappNumber: json['whatsappNumber'],
      cuisineType: json['cuisineType'] != null
          ? List<String>.from(json['cuisineType'])
          : [],
      openingHours: json['openingHours'] != null
          ? List<OpeningHoursModel>.from(
              (json['openingHours'] as List).map(
                (x) => OpeningHoursModel.fromJson(x),
              ),
            )
          : [],
      status: json['status'] ?? '',
      reviewsCount: json['reviewsCount'] ?? 0,
      isFavorite: json['userFavoriteData']?.isNotEmpty ?? false,
      isOpen: json['isOpen'] ?? false,
      serverTime: json['serverTime'] ?? '',
    );
  }

  /// Get full formatted address
  String getFullAddress() {
    if (address.isEmpty) return 'Address not available';
    final addr = address.first;
    return '${addr.governorate}, ${addr.city}\n${addr.street}\n${addr.details}';
  }

  /// Get price range display
  String getPriceRangeDisplay() {
    switch (priceRange.toLowerCase()) {
      case 'low':
        return r'$';
      case 'medium':
        return r'$•$';
      case 'high':
        return r'$•$•$';
      default:
        return r'$';
    }
  }
}

class CoverPhoto {
  final String url;
  final String publicId;
  final String id;

  CoverPhoto({required this.url, required this.publicId, required this.id});

  factory CoverPhoto.fromJson(Map<String, dynamic> json) {
    return CoverPhoto(
      url: json['url'] ?? '',
      publicId: json['publicId'] ?? '',
      id: json['_id'] ?? '',
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
}

class OpeningHoursModel {
  final String day;
  final String opens;
  final String closes;
  final bool isClosed;
  final String id;

  OpeningHoursModel({
    required this.day,
    required this.opens,
    required this.closes,
    required this.isClosed,
    required this.id,
  });

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursModel(
      day: json['day'] ?? '',
      opens: json['opens'] ?? '',
      closes: json['closes'] ?? '',
      isClosed: json['isClosed'] ?? false,
      id: json['_id'] ?? '',
    );
  }
}
