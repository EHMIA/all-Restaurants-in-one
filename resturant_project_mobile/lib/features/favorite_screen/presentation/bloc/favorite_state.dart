import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final List<Map<String, dynamic>> favorites;
  final List<int> pendingRemoval;

  const FavoriteState({
    required this.favorites,
    this.pendingRemoval = const [],
  });

  FavoriteState copyWith({
    List<Map<String, dynamic>>? favorites,
    List<int>? pendingRemoval,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      pendingRemoval: pendingRemoval ?? this.pendingRemoval,
    );
  }

  @override
  List<Object> get props => [favorites, pendingRemoval];
}
