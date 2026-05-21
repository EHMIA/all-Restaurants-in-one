import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_project/core/api/dio_consumer.dart';
import 'package:resturant_project/core/routing/route_name.dart';
import 'package:resturant_project/core/styles/app_colors.dart';
import 'package:resturant_project/core/utils/storage_helper.dart';
import 'package:resturant_project/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/bottom_navigation_bar/cubit/layout_cubit.dart';
import 'package:resturant_project/features/profile_screen/data/repository/profile_repo.dart';
import 'package:resturant_project/features/profile_screen/presentation/cubit/profile_cubit.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/info_tile.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/personal_information_section.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_card.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/profile_header.dart';
import 'package:resturant_project/features/profile_screen/presentation/page/widgets/quick_links_section.dart';
import 'package:resturant_project/features/review_page/data/repository/reviews_repo.dart';
import 'package:resturant_project/features/review_page/presentation/cubit/reviews_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/model/user_model.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, String> _userData = {};
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final data = await StorageHelper.getUserData();
    final imagePath = await StorageHelper.getProfileImagePath();
    if (mounted) {
      setState(() {
        _userData = data;
        _profileImagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        repo: UserRepo(api: DioConsumer(dio: Dio())),
      )..getProfile(),
      child: BlocProvider(
        create: (context) => ReviewsCubit(
          repo: ReviewRepo(api: DioConsumer(dio: Dio())),
        )..getUserReviews(),
        child: const _ProfileView(),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () =>
                  GoRouter.of(context).pushNamed(RouteName.settingsScreen),
              child: Icon(
                Icons.settings_outlined,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileSuccess) {
            final user = state.userModel.user;
            return _buildBody(context, user);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileHeader(user: user),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonalInformationSection(user: user),
                HeightSpace(height: 24),

                QuickLinksSection(user: user),
                HeightSpace(height: 94),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
