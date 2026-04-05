import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String distance;
  final String category;
  final bool isOpen;
  bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.distance,
    required this.category,
    required this.isOpen,
    this.isFavorite = false,
  });

  @override
  List<Object> get props => [id, isFavorite];
}

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Restaurant> featuredRestaurants;
  final List<Restaurant> allRestaurants;
  final String? searchQuery;
  final String? selectedCategory;

  const HomeLoaded({
    required this.featuredRestaurants,
    required this.allRestaurants,
    this.searchQuery,
    this.selectedCategory,
  });

  List<Restaurant> get filteredRestaurants {
    List<Restaurant> result = allRestaurants;

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      result = result
          .where(
            (r) => r.name.toLowerCase().contains(searchQuery!.toLowerCase()),
          )
          .toList();
    }

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      result = result.where((r) => r.category == selectedCategory).toList();
    }

    return result;
  }

  @override
  List<Object> get props => [
    featuredRestaurants,
    allRestaurants,
    searchQuery ?? '',
    selectedCategory ?? '',
  ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object> get props => [message];
}

class FavoriteToggled extends HomeState {}
