import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_profile_cubit.dart';
import '../../cubit/edit_profile_state.dart';
import 'custom_toggle_switch_widget.dart';

class EditProfileNotificationsToggle extends StatelessWidget {
  const EditProfileNotificationsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        return CustomToggleSwitchWidget(
          label: 'App Notifications',
          description: 'Stay updated with restaurant deals',
          value: cubit.notificationsEnabled,
          onChanged: (value) =>
              context.read<EditProfileCubit>().toggleNotifications(value),
        );
      },
    );
  }
}
