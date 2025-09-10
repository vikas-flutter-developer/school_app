import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/assignment/assignment_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/assignment/assignment_event.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/assignment/assignment_state.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/models/assignment_model.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/assignment_filter_row.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/assignment_item.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/assignment_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AssignmentBloc()..add(LoadAssignments()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
              const AssignmentSearchBar(),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
              const AssignmentFilterRow(),
              SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
              Expanded(
                child: BlocBuilder<AssignmentBloc, AssignmentState>(
                  builder: (context, state) {
                    if (state is AssignmentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AssignmentError) {
                      return Center(child: Text(state.message));
                    } else if (state is AssignmentLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSubmittedSection(context, state),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(40)),
                            _buildAssignedSection(context, state),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                            _buildCreateButton(context),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
                            Divider(
                              color: AppColors.cloud,
                              thickness: 1,
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmittedSection(BuildContext context, AssignmentLoaded state) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Submitted", style: AppStyles.bodyMedium),
              SizedBox(
                width: ScreenUtilHelper.scaleWidth(75),
                height: ScreenUtilHelper.scaleHeight(27),
                child: OutlinedButton(
                  onPressed: ()=>context.push(AppRoutes.assignmentGradeChart),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6.0)),
                    ),
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.primaryMedium,
                    ),
                  ),
                  child: Center(
                    child: Text("reports", style: AppStyles.bodyMedium),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
        _buildAssignmentGrid(state.submittedAssignments),
        SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
        _buildAssignmentGrid(state.submittedAssignments),
      ],
    );
  }

  Widget _buildAssignedSection(BuildContext context, AssignmentLoaded state) {
    return Column(
      children: [
        Divider(color: AppColors.cloud, thickness: 1),
        SizedBox(height: ScreenUtilHelper.scaleHeight(40)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8.0)),
          child: Row(
            children: [
              Text("Assigned", style: AppStyles.bodyMedium),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
        _buildAssignmentGrid(state.assignedAssignments),
      ],
    );
  }

  Widget _buildAssignmentGrid(List<Assignment> assignments) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8.0)),
      child: Wrap(
        spacing: ScreenUtilHelper.scaleWidth(17),
        runSpacing: ScreenUtilHelper.scaleHeight(20),
        children: assignments
            .map((assignment) => AssignmentItem(assignment: assignment))
            .toList(),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: ScreenUtilHelper.scaleWidth(100.0),
            height: ScreenUtilHelper.scaleHeight(30.0),
            child: ElevatedButton(
              onPressed: ()=>context.push(AppRoutes.createAssignment),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryMedium,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6.0)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Create", style: AppStyles.onlyText1Color),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(5.0)),
                  Icon(Icons.add, color: AppColors.white, size: ScreenUtilHelper.scaleWidth(20.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
