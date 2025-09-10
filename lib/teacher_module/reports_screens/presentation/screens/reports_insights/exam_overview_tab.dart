// lib/presentation/screens/reports_insights/exam_overview_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../widgets/exam_overview/exam_plan_list.dart';
import '../../../widgets/exam_overview/exam_timetable_list.dart';
import '../../blocs/exam_overview/exam_overview_bloc.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';
import '../../../../../core/utils/screen_util_helper.dart'; // added for responsiveness

class ExamOverviewTab extends StatefulWidget {
  const ExamOverviewTab({super.key});

  @override
  State<ExamOverviewTab> createState() => _ExamOverviewTabState();
}

class _ExamOverviewTabState extends State<ExamOverviewTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize based on BLoC state if possible, otherwise default
    final initialIndex = context.read<ExamOverviewBloc>().state.activeTabIndex;
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Dispatch event to BLoC when tab changes
        context.read<ExamOverviewBloc>().add(
          SwitchExamTab(_tabController.index),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // added for responsiveness
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    return BlocConsumer<ExamOverviewBloc, ExamOverviewState>(
      listener: (context, state) {
        // Sync TabController if BLoC state changes externally
        if (state.activeTabIndex != _tabController.index) {
          _tabController.animateTo(state.activeTabIndex);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ExamOverviewBloc>().add(const LoadExamOverview());
          },
          child: Column(
            children: [
              // Inner TabBar for Plan/Timetable
              TabBar(
                controller: _tabController,
                labelColor: AppColors.secondaryMedium,
                unselectedLabelColor: AppColors.graphite,
                indicatorColor: AppColors.primaryMedium,
                tabs: const [Tab(text: 'Exam Plan'), Tab(text: 'Timetable')],
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? ScreenUtilHelper.scaleWidth(12.0) : ScreenUtilHelper.scaleWidth(24.0),
                    vertical: isMobile ? ScreenUtilHelper.scaleHeight(8.0) : ScreenUtilHelper.scaleHeight(12.0),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildDropdown(
                          value: state.selectedClass,
                          items: state.availableClasses,
                          onChanged: (value) {
                            if (value != null) {
                              context.read<ExamOverviewBloc>().add(
                                SelectExamClass(value),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(10), height: ScreenUtilHelper.scaleHeight(8)),
                      Flexible(
                        flex: 1,
                        child: _buildDropdown(
                          value: state.selectedTerm,
                          items: state.availableTerms,
                          onChanged: (value) {
                            if (value != null) {
                              context.read<ExamOverviewBloc>().add(
                                SelectExamTerm(value),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(10), height: ScreenUtilHelper.scaleHeight(8)),
                      Flexible(
                        flex: 1,
                        child: _buildDropdown(
                          value: state.activeTabIndex == 1
                              ? state.selectedMonth ?? 'All'
                              : state.selectedSubject ?? 'All',
                          items: ['All'] + (state.activeTabIndex == 1
                              ? state.availableMonths.where((m) => m != 'All').toList()
                              : state.availableSubjects.where((s) => s != 'All').toList()),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<ExamOverviewBloc>().add(
                                state.activeTabIndex == 1
                                    ? SelectExamMonth(value)
                                    : SelectExamSubject(value),
                              );
                            }
                          },
                          hint: state.activeTabIndex == 1 ? null : 'Subject',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Area
              Expanded(
                child: BlocBuilder<ExamOverviewBloc, ExamOverviewState>(
                  builder: (context, state) {
                    if (state.status == ExamOverviewStatus.loading &&
                        state.examPlanItems.isEmpty &&
                        state.examTimetableItems.isEmpty) {
                      return const LoadingIndicator();
                    }
                    if (state.status == ExamOverviewStatus.failure) {
                      return ErrorMessage(
                        message: state.errorMessage ?? "Failed to load data",
                      );
                    }
                    return IndexedStack(
                      index: state.activeTabIndex,
                      children: [
                        // Exam Plan View (Index 0)
                        ExamPlanList(
                          items: state.examTimetableItems,
                          isLoading: state.status == ExamOverviewStatus.loading,
                        ),
                        // Timetable View (Index 1)
                        ExamTimetableList(
                          items: state.examPlanItems,
                          isLoading: state.status == ExamOverviewStatus.loading,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper for dropdowns in this tab
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.font14,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
      ),
      isExpanded: true,
    );
  }
}
