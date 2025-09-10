class PerformanceData {
  final String selectedClass;
  final String selectedYear;
  final List<String> classes;
  final List<String> years;

  const PerformanceData({
    required this.selectedClass,
    required this.selectedYear,
    required this.classes,
    required this.years,
  });

  PerformanceData copyWith({
    String? selectedClass,
    String? selectedYear,
    List<String>? classes,
    List<String>? years,
  }) {
    return PerformanceData(
      selectedClass: selectedClass ?? this.selectedClass,
      selectedYear: selectedYear ?? this.selectedYear,
      classes: classes ?? this.classes,
      years: years ?? this.years,
    );
  }
}
