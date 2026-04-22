import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/repositories/restaurant_details_repo.dart';

import '../../../../core/errors/exceptions.dart';
import 'restaurant_page_state.dart';

class RestaurantPageCubit extends Cubit<RestaurantPageState> {
  RestaurantPageCubit({required this.repo}) : super(RestaurantPageInitial());
  final RestaurantDetailsRepo repo;
  Future<void>getRestaurantsDetails(String id)async{
    try {
  emit(RestaurantPageLoading());
  final result=await repo.getAllRestuarantDetails(id);
  emit(RestaurantPageSuccess(result));
} on ServerException catch (e) {
  emit(RestaurantPageError(message: e.errorModel.error));
}

  }
  
}
