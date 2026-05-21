import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/info_tile.dart';

import '../../../data/model/user_model.dart';

class PersonalInformationSection extends StatelessWidget {
  final User user;

  const PersonalInformationSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeightSpace(height: 24),
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        HeightSpace(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              InfoTile(label: "FULL NAME", value: user.fullname),
              const Divider(height: 1, thickness: 0.5),
              InfoTile(label: "EMAIL ADDRESS", value: user.email),
              const Divider(height: 1, thickness: 0.5),
              InfoTile(label: "PHONE NUMBER", value: user.phone),
              const Divider(height: 1, thickness: 0.5),
              InfoTile(label: "ADDRESS", value: user.address.details),
            ],
          ),
        ),
      ],
    );
  }
}
