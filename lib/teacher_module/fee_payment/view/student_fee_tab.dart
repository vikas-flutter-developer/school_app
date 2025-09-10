import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; //  Responsive helper
import '../../service_screen/features/common_widgets/status_chip.dart';
import '../bloc/fee_bloc.dart';
import '../bloc/fee_event.dart';
import '../bloc/fee_state.dart';
import '../model/student_fee_record.dart';
import '../widget/custom_dropdown.dart';

class StudentFeeTab extends StatefulWidget {
  const StudentFeeTab({super.key});

  @override
  State<StudentFeeTab> createState() => _StudentFeeTabState();
}

class _StudentFeeTabState extends State<StudentFeeTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final bloc = context.read<FeesBloc>();

    return BlocBuilder<FeesBloc, FeesState>(
      builder: (context, state) {
        if (state.status == FeesStatus.loading && state.allStudents.isEmpty) {
          // Show loading only on initial load
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == FeesStatus.failure) {
          return Center(
            child: Text('Failed to load data: ${state.errorMessage}'),
          );
        }

        // Update search controller if query changes externally (less common)
        if (_searchController.text != state.studentSearchQuery) {
          _searchController.text = state.studentSearchQuery;
          // Move cursor to end if needed
          _searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: _searchController.text.length),
          );
        }

        return Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)), //  Responsive
          child: Column(
            children: [
              // --- Filter Row ---
              _buildStudentFilters(context, state, bloc),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)), //  Responsive

              // --- Info Row (Total, Class, Search, Download) ---
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.center, // Align items vertically
                children: [
                  Text(
                    "Total Students: ${state.filteredStudents.length}",
                    style: TextStyle(fontWeight: AppStyles.weight.emphasis),
                  ),
                  const Spacer(), // Pushes search/download to the right
                  Text(
                    "Class: ${state.selectedStudentClass}",
                    style: TextStyle(fontWeight: AppStyles.weight.emphasis),
                  ), // Display selected class
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(12)), //  Responsive
              Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(
                      context,
                      bloc,
                      state.studentSearchQuery,
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(10)), //  Responsive
                  ElevatedButton.icon(
                    onPressed: () {
                      bloc.add(FeesDownloadRequested());
                    },
                    icon: Icon(Icons.download, size: ScreenUtilHelper.scaleWidth(18)), //  Responsive
                    label: const Text("Download"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(12), //  Responsive
                        vertical: ScreenUtilHelper.scaleHeight(10), //  Responsive
                      ),
                      textStyle: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small)), //  Responsive
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)), //  Responsive

              // --- Student List Header ---
              _buildListHeader(context),
              const Divider(height: 1, thickness: 1), // Header separator
              // --- Student List ---
              Expanded(
                child: _buildStudentList(context, state.filteredStudents),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudentFilters(
      BuildContext context,
      FeesState state,
      FeesBloc bloc,
      ) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdown(
            value: state.selectedStudentType,
            items: state.studentTypeOptions,
            onChanged: (value) {
              if (value != null) {
                bloc.add(FeesStudentFilterChanged(selectedType: value));
              }
            },
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(10)), //  Responsive
        Expanded(
          child: CustomDropdown(
            value: state.selectedStudentClass,
            items: state.studentClassOptions,
            onChanged: (value) {
              if (value != null) {
                bloc.add(FeesStudentFilterChanged(selectedClass: value));
              }
            },
          ),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(10)), //  Responsive
        Expanded(
          child: CustomDropdown(
            value: state.selectedStudentTerm,
            items: state.studentTermOptions,
            onChanged: (value) {
              if (value != null) {
                bloc.add(FeesStudentFilterChanged(selectedTerm: value));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(
      BuildContext context,
      FeesBloc bloc,
      String currentQuery,
      ) {
    // Use listener for debouncing or reacting to changes
    // Simple onChanged for immediate feedback:
    return SizedBox(
      height: ScreenUtilHelper.scaleHeight(45), //  Responsive
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          bloc.add(FeesStudentSearchChanged(query));
        },
        decoration: InputDecoration(
          hintText: 'Search by Name or Roll no',
          prefixIcon: Icon(Icons.search, size: ScreenUtilHelper.scaleWidth(20)), //  Responsive
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: ScreenUtilHelper.scaleWidth(10), //  Responsive
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8.0)), //  Responsive
            borderSide: BorderSide(color: AppColors.cloud),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8.0)), //  Responsive
            borderSide: BorderSide(color: AppColors.cloud),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8.0)), //  Responsive
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
          hintStyle: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall), color: AppColors.ash), // ✅ Responsive
        ),
        style: TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small)), //  Responsive
      ),
    );
  }

  Widget _buildListHeader(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: AppStyles.weight.heading,
      color: AppColors.slate,
      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), //  Responsive
    );
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(10.0), //  Responsive
        horizontal: ScreenUtilHelper.scaleWidth(8.0), //  Responsive
      ),
      color: AppColors.linen, // Subtle background for header
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Name', style: headerStyle)),
          Expanded(flex: 2, child: Text('Roll no', style: headerStyle)),
          Expanded(flex: 2, child: Text('Term', style: headerStyle)),
          Expanded(flex: 2, child: Text('Status', style: headerStyle)),
          Expanded(
            flex: 2,
            child: Text(
              'Amount Due',
              style: headerStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(
      BuildContext context,
      List<StudentFeeRecord> students,
      ) {
    if (students.isEmpty) {
      return const Center(child: Text('No students found matching filters.'));
    }
    final itemStyle = TextStyle(fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small)); //  Responsive

    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (context, index) => const Divider(height: 0, thickness: 0.5),
      itemBuilder: (context, index) {
        final student = students[index];
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.scaleHeight(12.0), //  Responsive
            horizontal: ScreenUtilHelper.scaleWidth(8.0), //  Responsive
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  student.name,
                  style: itemStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(flex: 2, child: Text(student.rollNo, style: itemStyle)),
              Expanded(flex: 2, child: Text(student.term, style: itemStyle)),
              Expanded(flex: 2, child: StatusChip(status: student.status)),
              Expanded(
                flex: 2,
                child: Text(
                  student.amountDue == 0 ? '-' : student.amountDue.toStringAsFixed(0),
                  style: itemStyle.copyWith(
                    color: student.amountDue > 0 ? AppColors.error : AppColors.blackHighEmphasis,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}