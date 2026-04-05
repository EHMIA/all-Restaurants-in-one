import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class SearchRestaurants extends HomeEvent {
  final String query;
  const SearchRestaurants(this.query);
  @override
  List<Object> get props => [query];
}

class FilterByCategory extends HomeEvent {
  final String category;
  const FilterByCategory(this.category);
  @override
  List<Object> get props => [category];
}

class ToggleFavorite extends HomeEvent {
  final String restaurantId;
  const ToggleFavorite(this.restaurantId);
  @override
  List<Object> get props => [restaurantId];
}

class ClearFilters extends HomeEvent {}
