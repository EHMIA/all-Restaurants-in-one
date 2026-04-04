class ExploreState {
  final String search;
  final int selectedCategoryIndex;
  final bool openOnly;
  final double? minRating;
  final int visibleCount;

  ExploreState({
    this.search = '',
    this.selectedCategoryIndex = 0,
    this.openOnly = false,
    this.minRating,
    this.visibleCount = 4,
  });

  ExploreState copyWith({
    String? search,
    int? selectedCategoryIndex,
    bool? openOnly,
    double? minRating,
    int? visibleCount,
  }) {
    return ExploreState(
      search: search ?? this.search,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      openOnly: openOnly ?? this.openOnly,
      minRating: minRating ?? this.minRating,
      visibleCount: visibleCount ?? this.visibleCount,
    );
  }
}
