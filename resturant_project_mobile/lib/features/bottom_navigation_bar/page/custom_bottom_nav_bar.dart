import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resturant_project/core/styles/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.home_filled, Icons.home_filled, "Home", 0),
          _buildItem(Icons.explore_outlined, Icons.explore, "Explore", 1),
          _buildItem(Icons.favorite_border, Icons.favorite, "Fvorites", 2),
          _buildItem(Icons.person_outline, Icons.person, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildItem(
    IconData icon,
    IconData iconSelected,
    String label,
    int index,
  ) {
    final bool isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? iconSelected : icon,
                size: 28.sp,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.grayColor,
              ),
              if (isSelected)
                ClipOpacity(
                  opacity: _animation.value,
                  child: Transform.translate(
                    offset: Offset((1 - _animation.value) * 10, 0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ClipOpacity extends StatelessWidget {
  final double opacity;
  final Widget child;

  const ClipOpacity({super.key, required this.opacity, required this.child});

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: opacity, child: child);
  }
}
