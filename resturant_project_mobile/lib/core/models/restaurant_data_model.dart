class RestaurantDataModel {
  List<RestaurantModel> data;
  MetaModel meta;

  RestaurantDataModel({required this.data, required this.meta});

  factory RestaurantDataModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDataModel(
      data: List<RestaurantModel>.from(
        json['data'].map((x) => RestaurantModel.fromJson(x)),
      ),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class RestaurantModel {
  String id;
  String name;
  String coverPhoto;
  int rating;
  bool delivery;
  String priceRange;
  List<String> cuisineType;
  List<OpeningHoursModel> openingHours;
  String status;
  int reviewsCount;
  bool isFavorite;
  bool isOpen;
  String serverTime;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.coverPhoto,
    required this.rating,
    required this.delivery,
    required this.priceRange,
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
      id: json['_id'],
      name: json['name'],
      coverPhoto: json['coverPhoto'],
      rating: json['rating'],
      delivery: json['delivery'],
      priceRange: json['priceRange'],
      cuisineType: List<String>.from(json['cuisineType']),
      openingHours: List<OpeningHoursModel>.from(
        json['openingHours'].map((x) => OpeningHoursModel.fromJson(x)),
      ),
      status: json['status'],
      reviewsCount: json['reviewsCount'],
      isFavorite: json['isFavorite'],
      isOpen: json['isOpen'],
      serverTime: json['serverTime'],
    );
  }
}

class OpeningHoursModel {
  String day;
  String opens;
  String closes;
  bool isClosed;
  String id;

  OpeningHoursModel({
    required this.day,
    required this.opens,
    required this.closes,
    required this.isClosed,
    required this.id,
  });

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursModel(
      day: json['day'],
      opens: json['opens'],
      closes: json['closes'],
      isClosed: json['isClosed'],
      id: json['_id'],
    );
  }
}

class MetaModel {
  int totalResNumber;
  int pagesCount;
  int page;
  int limit;

  MetaModel({
    required this.totalResNumber,
    required this.pagesCount,
    required this.page,
    required this.limit,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      totalResNumber: json['totalResNumber'],
      pagesCount: json['pagesCount'],
      page: json['Page'],
      limit: json['Limit'],
    );
  }
}
