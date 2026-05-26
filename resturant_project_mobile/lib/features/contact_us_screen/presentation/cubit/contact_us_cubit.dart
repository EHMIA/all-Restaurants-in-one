import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/features/contact_us_screen/data/repository/contact_us_repo.dart';

import 'contact_us_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactUsRepo contactUsRepo;

  ContactCubit({required this.contactUsRepo}) : super(ContactInitial());

  Future<void> submitMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      emit(ContactLoading());

      final contactModel = await contactUsRepo.sendContactMessage(
        name: name,
        email: email,
        message: message,
      );

      emit(ContactSuccess('Message sent successfully'));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
