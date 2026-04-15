import 'package:resturant_project/core/models/restaurant_data_model.dart';

class FavoriteRepository {
  static final FavoriteRepository _instance = FavoriteRepository._internal();

  final List<RestaurantModel> _favorites = [];

  FavoriteRepository._internal();

  factory FavoriteRepository() {
    return _instance;
  }

  List<RestaurantModel> getFavorites() {
    return _favorites;
  }

  bool isFavorite(String id) {
    return _favorites.any((r) => r.id == id);
  }

  void toggleFavorite(RestaurantModel restaurant) {
    final index = _favorites.indexWhere((r) => r.id == restaurant.id);

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(restaurant);
    }
  }
}
