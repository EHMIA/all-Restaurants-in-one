import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/core/models/restaurant_data_model.dart';

class RestaurantDataRepo {
  final ApiConsumer api;

  RestaurantDataRepo({required this.api});

  Future<RestaurantDataModel> getAllRestuarant() async {
    final data = await api.get(EndPoints.getAllRestuarant);
    return RestaurantDataModel.fromJson(data);
  }
  Future<RestaurantDataModel> getMainDataRestuarant(String id) async {
    final data = await api.get(
      '${EndPoints.getAllRestuarant}/$id',
    );
    return RestaurantDataModel.fromJson(data);
  }
}
