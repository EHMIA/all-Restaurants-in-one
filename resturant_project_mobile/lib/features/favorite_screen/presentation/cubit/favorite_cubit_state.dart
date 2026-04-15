import 'package:equatable/equatable.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';

class FavoriteCubitState extends Equatable {
  final List<RestaurantModel> favorites;
  final List<int> pendingRemoval;

  const FavoriteCubitState({
    required this.favorites,
    this.pendingRemoval = const [],
  });

  FavoriteCubitState copyWith({
    List<RestaurantModel>? favorites,
    List<int>? pendingRemoval,
  }) {
    return FavoriteCubitState(
      favorites: favorites ?? this.favorites,
      pendingRemoval: pendingRemoval ?? this.pendingRemoval,
    );
  }

  @override
  List<Object> get props => [favorites, pendingRemoval];
}
