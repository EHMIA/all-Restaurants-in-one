class RestaurantDetailsModel {
  final String message;
  final RestaurantData data;

  RestaurantDetailsModel({required this.message, required this.data});

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      message: json['message']??'',
      data: RestaurantData.fromJson(json['Data']), 
    );
  }
}

class RestaurantData {
  final String id;
  final String? name;
  final List<MenuItemModel> menu;
  final List<GalleryItemModel> gallery;
  final List<ReviewModel> reviews;

  RestaurantData({
    required this.id,
    this.name,
    required this.menu,
    required this.gallery,
    required this.reviews,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      id: json['_id']??'',
      name: json['name']??'',
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
}


class MenuItemModel {
  final String dishName;
  final int price;
  final String description;
  final String category; 
  final String imageUrl;

  MenuItemModel.fromJson(Map<String, dynamic> json)
    : dishName = json['dishName']??'',
      price = json['price']??'',
      description = json['description']??'',
      category = json['category']??'',
      imageUrl = json['image']['url']??'';
}

class GalleryItemModel {
  final String url;
  GalleryItemModel.fromJson(Map<String, dynamic> json) : url = json['url']??'';
}

class ReviewModel {
  final String userName;
  final String content;
  final int rating;
  final String title;
  final DateTime createdAt;

  ReviewModel.fromJson(Map<String, dynamic> json)
    : userName = json['userName']??'Deleted Account',
      content = json['Content']??'',
      rating = json['rating']??'',
      title=json['title']??'',
      createdAt= DateTime.parse(json['createdAt']??'');
}
