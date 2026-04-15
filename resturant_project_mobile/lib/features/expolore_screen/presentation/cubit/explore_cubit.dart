import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/constants/constant_data.dart';
import '../../../../core/models/restaurant_data_model.dart';
import '../../../../core/repositories/restaurant_data_repo.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({required this.repo})
    : super(const ExploreSuccess(restaurants: []));

  final RestaurantDataRepo repo;

  List<RestaurantModel> _allRestaurants = [];

  Future<void> getHomeFeature() async {
    if (_allRestaurants.isNotEmpty) return;

    final prevSearch = state.search;
    final prevCategory = state.selectedCategoryIndex;
    final prevOpenOnly = state.openOnly;
    final prevMinRating = state.minRating;

    try {
      emit(ExploreLoading());
      final result = await repo.getAllRestuarant();
      _allRestaurants = result.data;
      emit(
        ExploreSuccess(
          restaurants: _allRestaurants,
          search: prevSearch,
          selectedCategoryIndex: prevCategory,
          openOnly: prevOpenOnly,
          minRating: prevMinRating,
        ),
      );
    } catch (e) {
      emit(ExploreError(message: e.toString()));
    }
  }

  void setSearch(String query) {
    if (state is ExploreSuccess) {
      emit((state as ExploreSuccess).copyWith(search: query, visibleCount: 10));
    }
  }

  void changeCategory(int index) {
    if (state is ExploreSuccess) {
      emit(
        (state as ExploreSuccess).copyWith(
          selectedCategoryIndex: index,
          visibleCount: 10,
        ),
      );
    }
  }


  void applyFilter(bool openOnly, double? minRating) {
    if (state is ExploreSuccess) {
      emit(
        (state as ExploreSuccess).copyWith(
          openOnly: openOnly,
          minRating: minRating,
          visibleCount: 10,
        ),
      );
    }
  }

  void removeOpenFilter() {
    if (state is ExploreSuccess) {
      emit((state as ExploreSuccess).copyWith(openOnly: false));
    }
  }

  void removeRatingFilter() {
    if (state is ExploreSuccess) {
      emit((state as ExploreSuccess).copyWith(minRating: null));
    }
  }

  void loadMore() {
    if (state is ExploreSuccess) {
      final s = state as ExploreSuccess;
      emit(s.copyWith(visibleCount: s.visibleCount + 10));
    }
  }


  List<RestaurantModel> getFilteredRestaurants() {
    if (state is! ExploreSuccess) return [];
    final s = state as ExploreSuccess;

    return _allRestaurants.where((res) {
      final q = s.search.toLowerCase();
      final matchesSearch =
          q.isEmpty ||
          res.name.toLowerCase().contains(q) ||
          res.cuisineType.any((c) => c.toLowerCase().contains(q));
      final bool matchesCategory;
      if (s.selectedCategoryIndex == 0) {
        matchesCategory = true;
      } else {
        final selectedTitle = ConstantData
            .category[s.selectedCategoryIndex]['title']
            .toString()
            .toLowerCase();
        matchesCategory = res.cuisineType.any(
          (c) => c.toLowerCase() == selectedTitle,
        );
      }
      final matchesOpen = !s.openOnly || res.isOpen;
      final matchesRating = s.minRating == null || res.rating >= s.minRating!;

      return matchesSearch && matchesCategory && matchesOpen && matchesRating;
    }).toList();
  }
}
