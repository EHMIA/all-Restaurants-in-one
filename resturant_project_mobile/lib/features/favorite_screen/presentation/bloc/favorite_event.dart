abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final int index;

  ToggleFavorite(this.index);
}

class ToggleFavoriteRestaurant extends FavoriteEvent {
  final Map<String, dynamic> restaurant;

  ToggleFavoriteRestaurant(this.restaurant);
}
