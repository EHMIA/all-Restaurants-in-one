import 'package:resturant_project/features/contact_us_screen/data/model/contact_us_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

class ContactUsRepo {

  final ApiConsumer api;

  ContactUsRepo({required this.api});
  Future<ContactUsModel> sendContactMessage(
   { required String email,
    required String message,
    required String name,
    }
    ) async {
      final response = await api.post(
        EndPoints.contact,
        data: {"name": name, "email": email,"message":message},
      );
      final contactModel = ContactUsModel.fromJson(response);
  return contactModel;
      
  }
}