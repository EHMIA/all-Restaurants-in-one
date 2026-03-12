import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_info_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_menu_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_photo_page.dart';
import 'package:resturant_project/features/restaurant_page_screen/widgets/custom_res_reviews_page.dart';

class CustomResTabBarPage extends StatelessWidget {
  const CustomResTabBarPage({
    super.key,
    this.rate,
    this.numOfReviews,
    this.resSpace,
    this.category,
    this.resName,
    this.resImage,
    this.restaurantId,
  });
  final String? rate;
  final String? numOfReviews;
  final String? resSpace;
  final String? category;
  final String? resName;
  final String? resImage;
  final String? restaurantId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppColors.primaryColor,
          height: 54.h,
          indicatorColor: AppColors.primaryColor,
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.grayColor,
          ),
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        tabs: [Text('Menu'), Text('Photos'), Text('Reviews'), Text('Info')],
        views: [
          CustomResMenuPage(),
          CustomResPhotoPage(),
          CustomResReviewsPage(
            rate: rate,
            numOfReviews: numOfReviews,
            category: category,
            resImage: resImage,
            resName: resName,
            resSpace: resSpace,
            restaurantId: restaurantId,
          ),
          CustomResInfoPage(),
        ],
        onChange: (index) => print(index),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RestaurantDetailsScreen extends StatelessWidget {
//   const RestaurantDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//                 pinned: true,
//                 backgroundColor: Colors.white,
//                 elevation: 0,
//                 toolbarHeight: 0, // 👈 مهم جداً
//                 bottom: PreferredSize(
//                   preferredSize: Size(double.infinity, 60.h),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.grey.shade300,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: TabBar(
//                       indicatorColor: Colors.red,
//                       indicatorWeight: 3,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       labelColor: Colors.red,
//                       unselectedLabelColor: Colors.grey,
//                       labelStyle: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       tabs: const [
//                         Tab(text: "Menu"),
//                         Tab(text: "Photos"),
//                         Tab(text: "Reviews"),
//                         Tab(text: "Info"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },

//           // 👇 محتوى كل تاب
//           body: TabBarView(
//             children: [
//               _buildList("Menu"),
//               _buildList("Photos"),
//               _buildList("Reviews"),
//               _buildList("Info"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static Widget _buildList(String title) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 20,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text("$title Item ${index + 1}"),
//           ),
//         );
//       },
//     );
//   }
// }
