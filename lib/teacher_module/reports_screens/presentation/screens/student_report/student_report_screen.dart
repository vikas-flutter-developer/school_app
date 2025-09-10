
import 'package:edudibon_flutter_bloc/admin_module/Student_Academic/bloc/student_academics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../widgets/student_report/student_header.dart';
import '../../../widgets/student_report/student_performance_chart.dart';
import '../../../widgets/student_report/subject_results_table.dart';
import '../../blocs/student_report/student_report_bloc.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';

class StudentReportScreen extends StatelessWidget {
  const StudentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // initialize here

    return Scaffold(
      appBar: const CommonAppBar(title: 'Student Report'),
      body: BlocBuilder<StudentReportBloc, StudentReportState>(
        builder: (context, state) {
          if (state.status == StudentReportStatus.loading &&
              state.studentDetails == null) {
            return const LoadingIndicator();
          }
          if (state.status == StudentReportStatus.failure &&
              state.studentDetails == null) {
            return ErrorMessage(
              message: state.errorMessage ?? "Failed to load student report",
            );
          }
          if (state.studentDetails == null) {
            return const ErrorMessage(message: "Student data not available.");
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)), // responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StudentHeader(
                  student: state.studentDetails!,
                  onNext: () {
                    /* TODO: Implement student navigation logic */
                  },
                  onPrevious: () {
                    /* TODO: Implement student navigation logic */
                  },
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                // Term Selector and Download
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: ScreenUtilHelper.scaleWidth(150), // responsive width
                      child: DropdownButtonFormField<String>(
                        value: state.availableTerms.contains(state.selectedTerm)
                            ? state.selectedTerm
                            : null,
                        items: state.availableTerms.map((String term) {
                          return DropdownMenuItem<String>(
                            value: term,
                            child: Text(term),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<StudentReportBloc>().add(
                              SelectStudentTerm(selectedTermId: value),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtilHelper.scaleWidth(10),
                            vertical: ScreenUtilHelper.scaleHeight(5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.scaleWidth(8)),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        /* TODO: Implement download logic */
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.scaleWidth(12),
                          vertical: ScreenUtilHelper.scaleHeight(8),
                        ),
                        textStyle: AppStyles.font14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),

                if (state.status == StudentReportStatus.loading)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.scaleHeight(10)),
                    child: LinearProgressIndicator(
                      minHeight: ScreenUtilHelper.scaleHeight(2),
                    ),
                  ),

                if (state.status == StudentReportStatus.failure &&
                    state.subjectResults.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.scaleHeight(20)),
                    child: ErrorMessage(
                      message: state.errorMessage ?? "Failed to load term data",
                    ),
                  ),

                if (state.subjectResults.isNotEmpty ||
                    state.status != StudentReportStatus.failure)
                  SubjectResultsTable(results: state.subjectResults),

                SizedBox(height: ScreenUtilHelper.scaleHeight(24)),

                if (state.studentPerformanceData != null ||
                    state.status != StudentReportStatus.failure) ...[
                  Text(
                    'Performance Analysis',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  StudentPerformanceChart(
                    performanceData: state.studentPerformanceData,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
