class FavoriteRepository {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> getFavorites() {
    return _favorites;
  }

  bool isFavorite(String name) {
    return _favorites.any((r) => r['resName'] == name);
  }

  void toggleFavorite(Map<String, dynamic> restaurant) {
    final index = _favorites.indexWhere(
      (r) => r['resName'] == restaurant['resName'],
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(restaurant);
    }
  }
}
