import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/features/core/styles/app_colors.dart';
import 'package:resturant_project/features/core/widgets/spacing_widgets.dart';
import 'package:resturant_project/features/expolore_screen/widgets/rating_chip.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialOpenOnly,
    required this.initialMinRating,
    required this.onApply,
  });

  final bool initialOpenOnly;
  final double? initialMinRating;
  final void Function(bool openOnly, double? minRating) onApply;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late bool _tempOpenOnly;
  late double? _tempMinRating;

  @override
  void initState() {
    super.initState();
    _tempOpenOnly = widget.initialOpenOnly;
    _tempMinRating = widget.initialMinRating;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          HeightSpace(height: 16),

          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _tempOpenOnly = false;
                  _tempMinRating = null;
                }),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          HeightSpace(height: 8),

          // Open Now toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Open Now',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch.adaptive(
                value: _tempOpenOnly,
                activeThumbColor: AppColors.primaryColor,
                onChanged: (v) => setState(() => _tempOpenOnly = v),
              ),
            ],
          ),
          HeightSpace(height: 12),

          // Min rating label
          Text(
            'Minimum Rating',
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          HeightSpace(height: 10),

          // Rating chips row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [null, 3.0, 3.5, 4.0, 4.5].map((rating) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: RatingChip(
                    rating: rating,
                    isSelected: _tempMinRating == rating,
                    onTap: () => setState(() => _tempMinRating = rating),
                  ),
                );
              }).toList(),
            ),
          ),
          HeightSpace(height: 24),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: () {
                widget.onApply(_tempOpenOnly, _tempMinRating);
                Navigator.pop(context);
              },
              child: Text(
                'Apply Filters',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
