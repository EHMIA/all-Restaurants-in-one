import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/manager/favorite_repository.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';
import 'favorite_cubit_state.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  FavoriteCubit(this.repository)
    : super(FavoriteCubitState(favorites: repository.getFavorites()));

  final FavoriteRepository repository;

  void loadFavorites() {
    emit(state.copyWith(favorites: repository.getFavorites()));
  }

  void toggleFavorite(int index) {
    // Add index to pending removal list
    final updatedPendingRemoval = List<int>.from(state.pendingRemoval);
    if (updatedPendingRemoval.contains(index)) {
      updatedPendingRemoval.remove(index);
    } else {
      updatedPendingRemoval.add(index);
    }

    emit(state.copyWith(pendingRemoval: updatedPendingRemoval));

    // Remove the favorite from repository
    final restaurant = state.favorites[index];
    repository.toggleFavorite(restaurant);

    // Update favorites list
    emit(
      state.copyWith(
        favorites: repository.getFavorites(),
        pendingRemoval: const [],
      ),
    );
  }

  void toggleFavoriteRestaurant(RestaurantModel restaurant) {
    repository.toggleFavorite(restaurant);
    emit(state.copyWith(favorites: repository.getFavorites()));
  }
}
