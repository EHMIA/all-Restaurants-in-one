import 'package:resturant_project/features/favorite_screen/data/model/favorite_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Datum> favorites; 

  FavoriteSuccess({required this.favorites});

  FavoriteSuccess copyWith({List<Datum>? favorites}) {
    return FavoriteSuccess(favorites: favorites ?? this.favorites);
  }
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError({required this.message});
}

class AddToFavorite extends FavoriteState{}

class RemoveFromFavorite extends FavoriteState{}

class AddOrRemoveSuccess extends FavoriteState{}