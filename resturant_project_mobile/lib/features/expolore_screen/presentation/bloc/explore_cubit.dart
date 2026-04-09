import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/expolore_screen/presentation/bloc/explore_state.dart';
import '../../../../core/constants/constant_data.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreState());

  void setSearch(String value) {
    emit(state.copyWith(search: value));
  }

  void changeCategory(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void applyFilter(bool openOnly, double? minRating) {
    emit(state.copyWith(openOnly: openOnly, minRating: minRating));
  }

  void removeOpenFilter() {
    emit(state.copyWith(openOnly: false));
  }

  void removeRatingFilter() {
    emit(state.copyWith(minRating: null));
  }

  void loadMore() {
    emit(state.copyWith(visibleCount: state.visibleCount + 4));
  }

  List<Map<String, dynamic>> getFilteredRestaurants() {
    final query = state.search.toLowerCase();

    final selectedCategory = state.selectedCategoryIndex == 0
        ? null
        : ConstantData.category[state.selectedCategoryIndex]['title'];

    return ConstantData.restaurants.where((r) {
      final name = (r['resName'] as String).toLowerCase();
      final cat = (r['category'] as String).toLowerCase();

      if (query.isNotEmpty && !name.contains(query) && !cat.contains(query)) {
        return false;
      }

      if (selectedCategory != null && r['category'] != selectedCategory) {
        return false;
      }

      if (state.openOnly && r['isOpen'] != true) return false;

      if (state.minRating != null) {
        final rate = double.tryParse(r['resRate'] ?? '0') ?? 0;
        if (rate < state.minRating!) return false;
      }

      return true;
    }).toList();
  }
}
