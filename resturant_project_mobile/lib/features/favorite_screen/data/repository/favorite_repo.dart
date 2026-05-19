import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/features/favorite_screen/data/model/favorite_model.dart';

class FavoriteRepo {
  final ApiConsumer api;

  FavoriteRepo({required this.api});
  Future<FavoriteModel> getRestaurantFav() async {
    final response = await api.get(EndPoints.favorites);
    return FavoriteModel.fromJson(response);
  }


  Future<void>deleteResFromFavorites(String resId)async{
    await api.delete('${EndPoints.favorites}/$resId');
  }

  Future<void> addResToFavorites(String resId) async {
    await api.post('${EndPoints.favorites}/$resId');
  }
}