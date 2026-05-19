class RestaurantDetailsModel {
  final String message;
  final RestaurantData data;

  RestaurantDetailsModel({required this.message, required this.data});

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      message: json['message'] ?? '',
      data: RestaurantData.fromJson(json['Data']),
    );
  }
}

class RestaurantData {
  final String id;
  final String? name;
  final String? description;
  final CoverPhotoModel? coverPhoto;
  final int rating;
  final bool delivery;
  final String priceRange;
  final String? owner;
  final String? facebookLink;
  final List<AddressItemModel> address;
  final String phoneNumber;
  final String? whatsappNumber;
  final List<String> cuisineType;
  final List<OpeningHoursItemModel> openingHours;
  final String status;
  final int reviewsCount;
  final bool isOpen;
  final String serverTime;
  final List<MenuItemModel> menu;
  final List<GalleryItemModel> gallery;
  final List<ReviewModel> reviews;

  RestaurantData({
    required this.id,
    this.name,
    this.description,
    this.coverPhoto,
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
    required this.isOpen,
    required this.serverTime,
    required this.menu,
    required this.gallery,
    required this.reviews,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      id: json['_id'] ?? '',
      name: json['name'],
      description: json['description'],
      coverPhoto: json['coverPhoto'] != null
          ? CoverPhotoModel.fromJson(json['coverPhoto'])
          : null,
      rating: json['rating'] ?? 0,
      delivery: json['delivery'] ?? false,
      priceRange: json['priceRange'] ?? 'low',
      owner: json['Owner'],
      facebookLink: json['facebookLink'],
      address: json['address'] != null
          ? List<AddressItemModel>.from(
              (json['address'] as List).map(
                (i) => AddressItemModel.fromJson(i),
              ),
            )
          : [],
      phoneNumber: json['phoneNumber'] ?? '',
      whatsappNumber: json['whatsappNumber'],
      cuisineType: json['cuisineType'] != null
          ? List<String>.from(json['cuisineType'])
          : [],
      openingHours: json['openingHours'] != null
          ? List<OpeningHoursItemModel>.from(
              (json['openingHours'] as List).map(
                (i) => OpeningHoursItemModel.fromJson(i),
              ),
            )
          : [],
      status: json['status'] ?? '',
      reviewsCount: json['reviewsCount'] ?? 0,
      isOpen: json['isOpen'] ?? false,
      serverTime: json['serverTime'] ?? '',
      menu: json['menu'] != null
          ? (json['menu'] as List)
                .map((i) => MenuItemModel.fromJson(i))
                .toList()
          : [],
      gallery: json['Gallery'] != null
          ? (json['Gallery'] as List)
                .map((i) => GalleryItemModel.fromJson(i))
                .toList()
          : [],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
                .map((i) => ReviewModel.fromJson(i))
                .toList()
          : [],
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

class CoverPhotoModel {
  final String url;
  final String publicId;
  final String id;

  CoverPhotoModel({
    required this.url,
    required this.publicId,
    required this.id,
  });

  factory CoverPhotoModel.fromJson(Map<String, dynamic> json) {
    return CoverPhotoModel(
      url: json['url'] ?? '',
      publicId: json['publicId'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class AddressItemModel {
  final String governorate;
  final String city;
  final String street;
  final String details;
  final String id;

  AddressItemModel({
    required this.governorate,
    required this.city,
    required this.street,
    required this.details,
    required this.id,
  });

  factory AddressItemModel.fromJson(Map<String, dynamic> json) {
    return AddressItemModel(
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      details: json['details'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class OpeningHoursItemModel {
  final String day;
  final String opens;
  final String closes;
  final bool isClosed;
  final String id;

  OpeningHoursItemModel({
    required this.day,
    required this.opens,
    required this.closes,
    required this.isClosed,
    required this.id,
  });

  factory OpeningHoursItemModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursItemModel(
      day: json['day'] ?? '',
      opens: json['opens'] ?? '',
      closes: json['closes'] ?? '',
      isClosed: json['isClosed'] ?? false,
      id: json['_id'] ?? '',
    );
  }
}

class MenuItemModel {
  final String dishName;
  final int price;
  final String description;
  final String category;
  final String imageUrl;

  MenuItemModel.fromJson(Map<String, dynamic> json)
    : dishName = json['dishName'] ?? '',
      price = json['price'] ?? 0,
      description = json['description'] ?? '',
      category = json['category'] ?? '',
      imageUrl = (json['image'] is Map && json['image']['url'] != null)
          ? json['image']['url']
          : '';
}

class GalleryItemModel {
  final String url;

  GalleryItemModel.fromJson(Map<String, dynamic> json)
    : url = json['url'] ?? '';
}

class ReviewModel {
  final String userName;
  final String profilePic;
  final String content;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.userName,
    required this.profilePic,
    required this.content,
    required this.rating,
    required this.createdAt, required this.updatedAt,
  });

  ReviewModel.fromJson(Map<String, dynamic> json)
    : userName = json['user']?['name'] ?? 'Deleted Account',
      profilePic = json['user']?['profile']?['url'] ?? '',
      content = json['Content'] ?? '',
      rating = (json['rating'] ?? 0).toDouble(),
      createdAt = json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt = json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now();
}
