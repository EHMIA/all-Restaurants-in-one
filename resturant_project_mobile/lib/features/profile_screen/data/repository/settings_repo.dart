import 'package:resturant_project/core/api/api_consumer.dart';
import 'package:resturant_project/core/api/end_points.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';

class SettingsRepo {
  final ApiConsumer api;

  SettingsRepo({required this.api});

  Future<String> deleteAccount() async {
    final userId = await StorageHelper.getUserId();

    final response = await api.delete(EndPoints.deleteAccount(userId ?? ''));

    // Clear all user data from storage
    await StorageHelper.clearAll();

    return response['message'] ?? 'Account deleted successfully';
  }
}
