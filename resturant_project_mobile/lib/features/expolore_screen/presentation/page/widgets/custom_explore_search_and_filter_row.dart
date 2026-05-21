import 'package:flutter/material.dart';
import '../../../../../core/widgets/spacing_widgets.dart';
import '../../../../home_screen/presentation/page/widgets/search_text_field_widget.dart';
import 'filter_icon_button.dart';

class ExploreSearchAndFilterRow extends StatelessWidget {
  const ExploreSearchAndFilterRow({
    super.key,
    required this.controller,
    required this.hasActiveFilter,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final bool hasActiveFilter;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchTextFieldWidget(
            controller: controller,
            hintText: 'Search restaurants, cuisines...',
          ),
        ),
        WidthSpace(width: 10),
        FilterIconButton(hasActiveFilter: hasActiveFilter, onTap: onFilterTap),
      ],
    );
  }
}
