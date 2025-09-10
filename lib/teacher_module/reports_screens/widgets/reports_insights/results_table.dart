import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart'; // Ensure correct path
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../data/models/result.dart';
import '../../presentation/blocs/student_report/student_report_bloc.dart';
import '../../presentation/screens/student_report/student_report_screen.dart';

class ResultsTable extends StatelessWidget {
  final List<StudentResultSummary> results;

  const ResultsTable({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); //  Ensure initialization

    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(20.0)), //  responsive padding
          child: Text(
            "No results found for this class/term.",
            style: AppStyles.selectClass,
          ),
        ),
      );
    }

    // Header Style
    final headerStyle = AppStyles.boldDarkGrey;
    final header = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8.0),
        vertical: ScreenUtilHelper.scaleHeight(12.0),
      ), //  responsive padding
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Name', style: headerStyle)),
          Expanded(flex: 3, child: Text('Subject', style: headerStyle)),
          Expanded(flex: 2, child: Text('Exam', style: headerStyle)),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('Status', style: headerStyle),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)), //  responsive radius
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal,
            blurRadius: ScreenUtilHelper.scaleRadius(4), //  responsive shadow
            offset: Offset(0, ScreenUtilHelper.scaleHeight(2)), //  responsive offset
          ),
        ],
      ),
      child: Column(
        children: [
          header,
          const Divider(height: 1, thickness: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              final isPass = result.status == ResultStatus.Pass;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<StudentReportBloc>().add(
                      LoadStudentReport(
                        studentId: result.studentId,
                        initialTermId: result.examTerm,
                      ),
                    );
                    context.push(AppRoutes.studentReport);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(8.0),
                      vertical: ScreenUtilHelper.scaleHeight(12.0),
                    ), //  responsive padding
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            result.studentName,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.term,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            result.subject,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.term,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            result.examTerm,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.term,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isPass ? 'Pass' : 'Fail',
                              style: AppStyles.passFail(isPass),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => Divider(
              height: ScreenUtilHelper.scaleHeight(1),
              indent: ScreenUtilHelper.scaleWidth(8),
              endIndent: ScreenUtilHelper.scaleWidth(8),
            ), //  responsive separator
          ),
        ],
      ),
    );
  }
}
