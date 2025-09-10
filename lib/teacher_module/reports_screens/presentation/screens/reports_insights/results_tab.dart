// lib/presentation/screens/reports_insights/results_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/screen_util_helper.dart';

import '../../../widgets/reports_insights/class_performance_chart.dart';
import '../../../widgets/reports_insights/class_selector_dropdown.dart';
import '../../../widgets/reports_insights/class_toppers_section.dart';
import '../../../widgets/reports_insights/results_table.dart';
import '../../blocs/reports_insights/reports_insights_bloc.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsInsightsBloc, ReportsInsightsState>(
      builder: (context, state) {
        // Calculate total unique students (handle potential duplicates in mock data)
        final totalStudents =
            state.studentResults.map((r) => r.studentId).toSet().length;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ReportsInsightsBloc>().add(
              LoadReportsData(
                classId: state.selectedClass,
                termId: state.selectedTerm,
              ),
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // Ensure scroll for refresh
            padding: EdgeInsets.all(ScreenUtilHelper.width(16)), //  Responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassSelectorDropdown(
                  selectedClass: state.selectedClass,
                  availableClasses: state.availableClasses,
                  onChanged: (newClass) {
                    if (newClass != null) {
                      context.read<ReportsInsightsBloc>().add(
                        SelectResultClass(newClass),
                      );
                    }
                  },
                ),
                SizedBox(height: ScreenUtilHelper.height(16)), //  Responsive spacing

                if (state.status == ReportsStatus.loading &&
                    state.studentResults.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.height(50)), //
                    child: const LoadingIndicator(),
                  )
                else if (state.status == ReportsStatus.failure &&
                    state.studentResults.isEmpty)
                  ErrorMessage(
                    message: state.errorMessage ?? "Failed to load results",
                  )
                else ...[
                    // Show content if success or if data exists
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtilHelper.height(8)), //
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Students: $totalStudents',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Class: ${state.selectedClass}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(8)), //

                    // Results Table (Simplified List View Style)
                    if (state.status == ReportsStatus.loading)
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtilHelper.height(10)), //
                        child: const LinearProgressIndicator(
                          minHeight: 2,
                        ), // Subtle loading bar during refresh
                      ),
                    ResultsTable(results: state.studentResults),
                    SizedBox(height: ScreenUtilHelper.height(24)), //

                    // Class Toppers
                    ClassToppersSection(
                      toppers: state.classToppers,
                      availableTerms: state.availableTerms,
                      selectedTerm: state.selectedTerm,
                      onTermChanged: (newTerm) {
                        if (newTerm != null) {
                          context.read<ReportsInsightsBloc>().add(
                            SelectResultTerm(newTerm),
                          );
                        }
                      },
                    ),
                    SizedBox(height: ScreenUtilHelper.height(24)), //

                    // Overall Class Performance
                    Text(
                      'Overall Class Performance',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)), //

                    // Chart
                    ClassPerformanceChart(
                      performanceData: state.classPerformanceData,
                    ),
                  ],
              ],
            ),
          ),
        );
      },
    );
  }
}
