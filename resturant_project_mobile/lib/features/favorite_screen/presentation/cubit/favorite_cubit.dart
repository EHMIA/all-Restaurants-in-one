import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/favorite_screen/data/model/favorite_model.dart';
import 'package:resturant_project/features/favorite_screen/data/repository/favorite_repo.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({required this.repo}) : super(FavoriteInitial());

  final FavoriteRepo repo;
  List<Datum> _allFavorites = [];

  Future<void> getAllFavoriteRestaurant() async {
    try {
      emit(FavoriteLoading());
      final result = await repo.getRestaurantFav();

      _allFavorites = result.data;

      emit(FavoriteSuccess(favorites: _allFavorites));
    } catch (e) {
      
      emit(FavoriteError(message: e.toString()));
    }
  }

  // advanced remove
  // Future<void> removeCardFromFav(String resId) async {
  //   try {
  //     final oldlist = List<Datum>.from(_allFavorites);

  //     _allFavorites.removeWhere((e) => e.restaurant.id == resId);
  //     emit(FavoriteSuccess(favorites: _allFavorites));

  //     await repo.deleteResFromFavorites(resId);
  //   } catch (e) {
  //     // rollback
  //     final oldlist = List<Datum>.from(_allFavorites);
  //     _allFavorites = oldlist;
  //     emit(FavoriteSuccess(favorites: _allFavorites));

  //     emit(FavoriteError(message: e.toString()));
  //   }
  // }

  Future<void> removeCardFromFav(String resId) async {
    try {
      await repo.deleteResFromFavorites(resId);

      _allFavorites.removeWhere((e) => e.restaurant.id == resId);

      emit(FavoriteSuccess(favorites: _allFavorites));
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  Future<void> addResToFavorites(String resId) async {
    try {
      await repo.addResToFavorites(resId);

      await getAllFavoriteRestaurant();
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }

  bool isFavorite(String resId) {
    return _allFavorites.any((e) => e.restaurant.id == resId);
  }
}
