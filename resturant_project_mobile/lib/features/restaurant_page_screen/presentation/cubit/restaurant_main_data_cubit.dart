import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/repositories/restaurant_data_repo.dart';
import 'package:resturant_project/features/restaurant_page_screen/presentation/cubit/restaurant_main_data_state.dart';

import '../../../../core/errors/exceptions.dart';

class RestaurantMainDataCubit extends Cubit<RestaurantMainDataState> {
  RestaurantMainDataCubit({required this.repo}) : super(RestaurantMainDataInitial());
  final RestaurantDataRepo repo;
  Future<void> getRestaurantsMainData(String id) async {
    try {
      emit(RestaurantMainDataLoading());
      final result = await repo.getMainDataRestuarant(id);
      emit(RestaurantMainDataSuccess(result));
    } on ServerException catch (e) {
      emit(RestaurantMainDataError(message: e.errorModel.error));
    }
  }
}
