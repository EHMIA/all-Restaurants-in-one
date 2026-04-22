import '../api/api_consumer.dart';
import '../api/end_points.dart';
import '../models/restaurant_details_model.dart';

class RestaurantDetailsRepo {
  final ApiConsumer api;

  RestaurantDetailsRepo({required this.api});

  Future<RestaurantDetailsModel> getAllRestuarantDetails(String id) async {
    final data = await api.get('${EndPoints.getAllRestuarant}/$id/details',
      queryParameters: {"select": "all"},
    );
    return RestaurantDetailsModel.fromJson(data);
  }
}