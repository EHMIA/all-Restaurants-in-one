import 'package:resturant_project/core/models/restaurant_data_model.dart';

const _remove = Object();

abstract class ExploreState {
  const ExploreState();

  String get search => '';
  int get selectedCategoryIndex => 0;
  bool get openOnly => false;
  double? get minRating => null;
  int get visibleCount => 10;
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final List<RestaurantModel> restaurants;
  @override
  final String search;
  @override
  final int selectedCategoryIndex;
  @override
  final bool openOnly;
  @override
  final double? minRating;
  @override
  final int visibleCount;

  const ExploreSuccess({
    required this.restaurants,
    this.search = '',
    this.selectedCategoryIndex = 0,
    this.openOnly = false,
    this.minRating,
    this.visibleCount = 10,
  });

  ExploreSuccess copyWith({
    List<RestaurantModel>? restaurants,
    String? search,
    int? selectedCategoryIndex,
    bool? openOnly,
    Object? minRating = _remove,
    int? visibleCount,
  }) {
    return ExploreSuccess(
      restaurants: restaurants ?? this.restaurants,
      search: search ?? this.search,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      openOnly: openOnly ?? this.openOnly,
      minRating: minRating == _remove ? this.minRating : minRating as double?,
      visibleCount: visibleCount ?? this.visibleCount,
    );
  }
}

class ExploreError extends ExploreState {
  final String message;
  const ExploreError({required this.message});
}
