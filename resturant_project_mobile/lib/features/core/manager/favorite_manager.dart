class FavoriteManager {
  static final List<Map<String, dynamic>> favorites = [];

  static bool isFavorite(String name) {
    return favorites.any((r) => r['resName'] == name);
  }

  static void toggleFavorite(Map<String, dynamic> restaurant) {
    final index = favorites.indexWhere((r) => r['resName'] == restaurant['resName']);

    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(restaurant);
    }
  }
}
