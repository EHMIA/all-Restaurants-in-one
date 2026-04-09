import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';
import 'package:resturant_project/core/manager/favorite_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository repository;

  FavoriteBloc(this.repository)
    : super(FavoriteState(favorites: repository.getFavorites())) {
    on<LoadFavorites>((event, emit) {
      emit(state.copyWith(favorites: repository.getFavorites()));
    });

    on<ToggleFavorite>((event, emit) {
      // Add index to pending removal list
      final updatedPendingRemoval = List<int>.from(state.pendingRemoval);
      if (updatedPendingRemoval.contains(event.index)) {
        updatedPendingRemoval.remove(event.index);
      } else {
        updatedPendingRemoval.add(event.index);
      }

      emit(state.copyWith(pendingRemoval: updatedPendingRemoval));

      // Remove the favorite from repository
      final restaurant = state.favorites[event.index];
      repository.toggleFavorite(restaurant);

      // Update favorites list
      emit(
        state.copyWith(
          favorites: repository.getFavorites(),
          pendingRemoval: const [],
        ),
      );
    });

    on<ToggleFavoriteRestaurant>((event, emit) {
      repository.toggleFavorite(event.restaurant);

      emit(state.copyWith(favorites: repository.getFavorites()));
    });
  }
}
