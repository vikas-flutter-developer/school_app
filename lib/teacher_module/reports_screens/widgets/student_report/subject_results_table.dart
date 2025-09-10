import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../data/models/result.dart';

class SubjectResultsTable extends StatelessWidget {
  final List<SubjectResultDetail> results;

  const SubjectResultsTable({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final headerStyle = AppStyles.boldDarkGrey;
    int totalMarksSum = 0;
    int scoreSum = 0;
    bool overallPass = true;

    for (var result in results) {
      totalMarksSum += result.totalMarks;
      scoreSum += result.score;
      if (result.result == ResultStatus.Fail) {
        overallPass = false;
      }
    }

    double overallPercentage =
    totalMarksSum > 0 ? (scoreSum / totalMarksSum) * 100 : 0.0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cloud),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(7)),
        child: DataTable(
          headingRowHeight: ScreenUtilHelper.height(40),
          dataRowMinHeight: ScreenUtilHelper.height(45),
          dataRowMaxHeight: ScreenUtilHelper.height(50),
          columnSpacing: ScreenUtilHelper.width(16),
          headingRowColor: MaterialStateProperty.all(AppColors.linen),
          columns: [
            DataColumn(label: Text('Subject', style: headerStyle)),
            DataColumn(
                label: Text('Total', style: headerStyle), numeric: true),
            DataColumn(
                label: Text('Score', style: headerStyle), numeric: true),
            DataColumn(label: Text('%', style: headerStyle), numeric: true),
            DataColumn(label: Text('Result', style: headerStyle)),
          ],
          rows: [
            ...results.map(
                  (result) => DataRow(
                cells: [
                  DataCell(Text(result.subject,
                      style: AppStyles.body13Medium.copyWith(
                        fontSize: ScreenUtilHelper.fontSize(13),
                      ))),
                  DataCell(Text(result.totalMarks.toString(),
                      style: AppStyles.body13Medium.copyWith(
                        fontSize: ScreenUtilHelper.fontSize(13),
                      ))),
                  DataCell(Text(result.score.toString(),
                      style: AppStyles.body13Medium.copyWith(
                        fontSize: ScreenUtilHelper.fontSize(13),
                      ))),
                  DataCell(Text('${result.percentage.toStringAsFixed(1)}%',
                      style: AppStyles.body13Medium.copyWith(
                        fontSize: ScreenUtilHelper.fontSize(13),
                      ))),
                  DataCell(Text(
                    result.result == ResultStatus.Pass ? 'Pass' : 'Fail',
                    style: AppStyles.passFailMedium(result.result == ResultStatus.Pass).copyWith(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ),
                  )),
                ],
              ),
            ),
            // Footer row for totals
            DataRow(
              color: MaterialStateProperty.all(AppColors.parchment),
              cells: [
                DataCell(Text('Total',
                    style: AppStyles.bold.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ))),
                DataCell(Text(totalMarksSum.toString(),
                    style: AppStyles.bold.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ))),
                DataCell(Text(scoreSum.toString(),
                    style: AppStyles.bold.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ))),
                DataCell(Text('${overallPercentage.toStringAsFixed(1)}%',
                    style: AppStyles.bold.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(13),
                    ))),
                DataCell(Text(
                  overallPass ? 'Pass' : 'Fail',
                  style: AppStyles.overallResult(overallPass).copyWith(
                    fontSize: ScreenUtilHelper.fontSize(13),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
