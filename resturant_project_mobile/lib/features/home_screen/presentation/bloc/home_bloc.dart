import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constant_data.dart';
import 'home_state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final restaurants = _convertToRestaurants();

        final featured = restaurants.take(4).toList();

        emit(
          HomeLoaded(
            featuredRestaurants: featured,
            allRestaurants: restaurants,
          ),
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<SearchRestaurants>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(
          HomeLoaded(
            featuredRestaurants: currentState.featuredRestaurants,
            allRestaurants: currentState.allRestaurants,
            searchQuery: event.query,
            selectedCategory: currentState.selectedCategory,
          ),
        );
      }
    });

    on<FilterByCategory>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(
          HomeLoaded(
            featuredRestaurants: currentState.featuredRestaurants,
            allRestaurants: currentState.allRestaurants,
            searchQuery: currentState.searchQuery,
            selectedCategory: event.category,
          ),
        );
      }
    });

    on<ToggleFavorite>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;

        final updatedRestaurants = currentState.allRestaurants.map((
          restaurant,
        ) {
          if (restaurant.id == event.restaurantId) {
            restaurant.isFavorite = !restaurant.isFavorite;
          }
          return restaurant;
        }).toList();

        final updatedFeatured = currentState.featuredRestaurants.map((
          restaurant,
        ) {
          if (restaurant.id == event.restaurantId) {
            restaurant.isFavorite = !restaurant.isFavorite;
          }
          return restaurant;
        }).toList();

        emit(
          HomeLoaded(
            featuredRestaurants: updatedFeatured,
            allRestaurants: updatedRestaurants,
            searchQuery: currentState.searchQuery,
            selectedCategory: currentState.selectedCategory,
          ),
        );

        emit(FavoriteToggled());
      }
    });

    on<ClearFilters>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(
          HomeLoaded(
            featuredRestaurants: currentState.featuredRestaurants,
            allRestaurants: currentState.allRestaurants,
          ),
        );
      }
    });
  }

  List<Restaurant> _convertToRestaurants() {
    return ConstantData.restaurants.map((item) {
      return Restaurant(
        id: item['id'] ?? DateTime.now().toString(),
        name: item['resName'] ?? '',
        image: item['image'] ?? '',
        rating: double.tryParse(item['resRate']?.toString() ?? '0') ?? 0,
        distance: item['resSpace'] ?? '0.0 km',
        category: item['category'] ?? '',
        isOpen: item['isOpen'] ?? false,
        isFavorite: false,
      );
    }).toList();
  }
}
