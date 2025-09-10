import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/complaint_form_bloc/complaint_form_bloc.dart';
import '../widgets/labeled_dropdown_widget.dart';
import 'approve_request_sent_screen.dart';

class ComplaintFormScreen extends StatefulWidget {
  const ComplaintFormScreen({super.key});

  @override
  State<ComplaintFormScreen> createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(
      text: "Please order white color fans",
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(
      BuildContext context,
      ComplaintFormBloc formBloc,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(16)),
          ),
          contentPadding: EdgeInsets.all(ScreenUtilHelper.width(24)),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ScreenUtilHelper.width(350),
              maxHeight: ScreenUtilHelper.height(200),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ScreenUtilHelper.height(10)),
                Text(
                  'Are you sure?',
                  style: AppStyles.headingLargeEmphasis),
                SizedBox(height: ScreenUtilHelper.height(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: ScreenUtilHelper.width(100),
                      height: ScreenUtilHelper.height(40),
                      child: OutlinedButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.ash),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(10)),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: AppStyles.weight.emphasis,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtilHelper.width(100),
                      height: ScreenUtilHelper.height(40),
                      child: ElevatedButton(
                        onPressed: () {
                          formBloc.add(SubmitComplaintForm());
                          GoRouter.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryContrast,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(10)),
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(fontWeight:AppStyles.weight.emphasis ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.height(10)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => ComplaintFormBloc()..add(LoadComplaintFormData()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blackMediumEmphasis,
              size: ScreenUtilHelper.scaleAll(20),
            ),
            onPressed: ()=>GoRouter.of(context).pop(),
          ),
          title: SizedBox(
            width: ScreenUtilHelper.width(159),
            height: ScreenUtilHelper.height(39),
            child: Image.asset("assets/images/edudibon.png"),
          ),
          centerTitle: false,
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.blackMediumEmphasis,
                    size: ScreenUtilHelper.scaleAll(28),
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: ScreenUtilHelper.width(8),
                  top: ScreenUtilHelper.height(8),
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtilHelper.width(2)),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    constraints: BoxConstraints(
                      minWidth: ScreenUtilHelper.width(16),
                      minHeight: ScreenUtilHelper.height(16),
                    ),
                    child: Text(
                      '3',
                      style: AppStyles.badgeLarge.copyWith(color:AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: ScreenUtilHelper.width(8)),
          ],
        ),
        body: BlocConsumer<ComplaintFormBloc, ComplaintFormState>(
          listener: (context, state) {
            if (state.submissionStatus == FormSubmissionStatus.success) {
              context.push(AppRoutes.hostelComplaintSent);
            }
            if (state.comment != _commentController.text) {
              _commentController.text = state.comment;
            }
          },
          builder: (context, state) {
            final formBloc = BlocProvider.of<ComplaintFormBloc>(context);

            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
                  side: BorderSide(
                      color: AppColors.ash,
                      width: ScreenUtilHelper.width(1.0)),
                ),
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtilHelper.width(20.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Complain ID",
                                style:AppStyles.small.copyWith(color: AppColors.black)
                              ),
                              SizedBox(height: ScreenUtilHelper.height(4)),
                              Text(
                                "2025 2536 78",
                                style: AppStyles.heading.copyWith(fontWeight: AppStyles.weight.regular),
                              ),
                            ],
                          ),
                          Text(
                            "04/03/2025",
                            style: AppStyles.feedbackNote.copyWith(color: AppColors.ash),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      Divider(
                          height: ScreenUtilHelper.height(1),
                          color: AppColors.blackDivider),
                      SizedBox(height: ScreenUtilHelper.height(20)),
                      LabeledDropdownWidget(
                        label: "Action*",
                        value: state.selectedAction,
                        items: state.actionItems,
                        onChanged: (value) {
                          formBloc.add(ActionChanged(value));
                        },
                      ),
                      SizedBox(height: ScreenUtilHelper.height(20)),
                      LabeledDropdownWidget(
                        label: "Status *",
                        value: state.selectedStatus,
                        items: state.statusItems,
                        onChanged: (value) {
                          formBloc.add(StatusChanged(value));
                        },
                      ),
                      SizedBox(height: ScreenUtilHelper.height(20)),
                      LabeledDropdownWidget(
                        label: "Resolved date *",
                        value: state.selectedResolvedDate,
                        items: state.dateItems,
                        onChanged: (value) {
                          formBloc.add(ResolvedDateChanged(value));
                        },
                      ),
                      SizedBox(height: ScreenUtilHelper.height(20)),
                      Text(
                        "Comment",
                        style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.slate)
                      ),
                      SizedBox(height: ScreenUtilHelper.height(8)),
                      SizedBox(
                        width: double.infinity,
                        height: ScreenUtilHelper.height(78),
                        child: TextFormField(
                          controller: _commentController,
                          onChanged: (value) {
                            formBloc.add(CommentChanged(value));
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Please order white cor fans",
                            hintStyle:
                             TextStyle(color: AppColors.silver),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtilHelper.radius(8.0)),
                              borderSide:
                               BorderSide(color: AppColors.cloud),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilHelper.width(12),
                              vertical: ScreenUtilHelper.height(10),
                            ),
                          ),
                          style: AppStyles.body.copyWith(color: AppColors.blackHighEmphasis)
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(50)),
                      Center(
                        child: SizedBox(
                          width: ScreenUtilHelper.width(150),
                          height: ScreenUtilHelper.height(35),
                          child: ElevatedButton(
                            onPressed: state.submissionStatus ==
                                FormSubmissionStatus.submitting
                                ? null
                                : () {
                              _showConfirmationDialog(context, formBloc);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(8.0)),
                              ),
                              textStyle: AppStyles.bodyEmphasis,
                            ),
                            child: state.submissionStatus ==
                                FormSubmissionStatus.submitting
                                ? SizedBox(
                              height: ScreenUtilHelper.height(20),
                              width: ScreenUtilHelper.width(20),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                              ),
                            )
                                : const Text(
                              "Done",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}