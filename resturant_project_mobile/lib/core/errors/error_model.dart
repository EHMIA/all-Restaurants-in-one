import 'package:resturant_project/core/api/end_points.dart';

class ErrorModel {
  String error;

  ErrorModel({required this.error});

  factory ErrorModel.fromJson(Map<String,dynamic> jsonData){
    return ErrorModel(error: jsonData[ApiKey.errorMessage]);
  }

}