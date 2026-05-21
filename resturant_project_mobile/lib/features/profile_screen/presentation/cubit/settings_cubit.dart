import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_project/core/errors/exceptions.dart';
import 'package:resturant_project/features/profile_screen/data/repository/settings_repo.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo repo;

  SettingsCubit({required this.repo}) : super(SettingsInitial());

  // ── Delete account ─────────────────────────────────────────────────────
  Future<void> deleteAccount() async {
    try {
      emit(DeleteAccountLoading());
      final message = await repo.deleteAccount();
      emit(DeleteAccountSuccess(message: message));
    } on ServerException catch (e) {
      emit(DeleteAccountError(error: e.errorModel.error));
    } catch (e, stackTrace) {
      print('❌ DeleteAccount error: $e');
      print('❌ StackTrace: $stackTrace');
      emit(DeleteAccountError(error: 'Something went wrong'));
    }
  }
}
