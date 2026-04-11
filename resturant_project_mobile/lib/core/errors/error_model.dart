import 'package:resturant_project/core/api/end_points.dart';

class ErrorModel {
  final String error;

  ErrorModel({required this.error});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      error:
          jsonData[ApiKey.errorMessage] ??
          jsonData['message'] ??
          "An error occurred, please try again",
    );
  }
}
