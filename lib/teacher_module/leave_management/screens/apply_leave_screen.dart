import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:edudibon_flutter_bloc/teacher_module/leave_management/screens/permission_screen.dart';
import '../bloc/leave_bloc/leave_bloc.dart';
import '../models/leave.dart';
import '../widgets/notification_badge.dart';
import '../widgets/screen_header.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _leaveTypeController = TextEditingController();
  final _reasonController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _fromDateError;
  String? _toDateError;

  @override
  void dispose() {
    _leaveTypeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Widget _buildLeaveTypeField() {
    return _buildFieldWithLabel(
      label: "Leave Type",
      isRequired: true,
      child: Container(
        width: double.infinity,
        height: ScreenUtilHelper.scaleHeight(51),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
          border: Border.all(color: AppColors.cloud, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
          child: TextFormField(
            controller: _leaveTypeController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(17),
                color: AppColors.graphite,
              ),
            ),
            validator: (value) =>
            (value == null || value.isEmpty) ? 'Please enter leave type' : null,
            onChanged: (_) => _formKey.currentState?.validate(),
          ),
        ),
      ),
    );
  }

  Widget _buildFromDateField(BuildContext context) {
    return _buildFieldWithLabel(
      label: "From",
      isRequired: true,
      child: GestureDetector(
        onTap: () => _selectFromDate(context),
        child: Container(
          width: double.infinity,
          height: ScreenUtilHelper.scaleHeight(51),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
            border: Border.all(color: AppColors.cloud, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _fromDate != null
                        ? DateFormat('yyyy-MM-dd').format(_fromDate!)
                        : "Select date",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(17),
                      color: _fromDate != null
                          ? AppColors.blackHighEmphasis
                          : AppColors.graphite,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today, color: AppColors.primaryMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToDateField(BuildContext context) {
    return _buildFieldWithLabel(
      label: "To",
      isRequired: true,
      child: GestureDetector(
        onTap: () => _selectToDate(context),
        child: Container(
          width: double.infinity,
          height: ScreenUtilHelper.scaleHeight(51),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
            border: Border.all(color: AppColors.cloud, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _toDate != null
                        ? DateFormat('yyyy-MM-dd').format(_toDate!)
                        : "Select date",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                      color: _toDate != null
                          ? AppColors.blackHighEmphasis
                          : AppColors.graphite,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today, color: AppColors.primaryMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReasonField() {
    return _buildFieldWithLabel(
      label: "Reason",
      isRequired: true,
      child: Container(
        width: double.infinity,
        height: ScreenUtilHelper.scaleHeight(90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
          border: Border.all(color: AppColors.cloud, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
          child: TextFormField(
            controller: _reasonController,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                color: AppColors.graphite,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter reason';
              } else if (value.length < 10) {
                return 'Reason must be at least 10 characters long';
              }
              return null;
            },
            onChanged: (_) => _formKey.currentState?.validate(),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldWithLabel({
    required String label,
    required bool isRequired,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                fontWeight: AppStyles.weight.regular,
                color: AppColors.blackHighEmphasis,
              ),
            ),
            if (isRequired)
              Text(
                "*",
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                  fontWeight: AppStyles.weight.regular,
                  color: AppColors.error,
                ),
              ),
          ],
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
        child,
        if ((label == "From" && _fromDateError != null) ||
            (label == "To" && _toDateError != null))
          Padding(
            padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(5)),
            child: Text(
              label == "From" ? _fromDateError! : _toDateError!,
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
        _fromDateError = null;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _toDate = picked;
        _toDateError = null;
      });
    }
  }

  Widget _buildApplyLeaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: ScreenUtilHelper.scaleWidth(186),
          height: ScreenUtilHelper.scaleHeight(51),
          child: ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(6)),
              ),
            ),
            child: Text(
              "Apply Leave",
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                fontWeight: AppStyles.weight.emphasis,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: ScreenHeader(
          title: "Apply Leave",
          onBackPressed: () => GoRouter.of(context).pop(),
        ),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        actions: const [NotificationBadge(count: 3)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
                _buildLeaveTypeField(),
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                _buildFromDateField(context),
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                _buildToDateField(context),
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                _buildReasonField(),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                _buildApplyLeaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    bool isValid = true;
    if (_fromDate == null) {
      setState(() => _fromDateError = 'Please select a start date');
      isValid = false;
    }
    if (_toDate == null) {
      setState(() => _toDateError = 'Please select an end date');
      isValid = false;
    }
    if (_formKey.currentState?.validate() ?? false && isValid) {
      final leave = Leave(
        type: _leaveTypeController.text,
        fromDate: _fromDate!,
        toDate: _toDate!,
        reason: _reasonController.text,
        status: 'Pending',
      );
      context.read<LeaveBloc>().add(ApplyLeave(leave));

     context.push(AppRoutes.requestSent);
    }
  }

  Widget _buildDialogContent(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: ScreenUtilHelper.scaleWidth(320),
          height: ScreenUtilHelper.scaleHeight(320),
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtilHelper.scaleWidth(279),
                height: ScreenUtilHelper.scaleHeight(291),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                  border: Border.all(color: Colors.grey[400]!, width: 1),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.cancel_sharp),
                        onPressed: () => context.go(AppRoutes.leaveOverview),
                      ),
                    ),
                    Image.asset(
                      'assets/images/success.png',
                      width: ScreenUtilHelper.scaleWidth(72),
                      height: ScreenUtilHelper.scaleHeight(72),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
                    Text(
                      "Leave Application Submitted",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                        fontWeight: AppStyles.weight.emphasis,
                        color: const Color.fromRGBO(60, 59, 59, 1),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
                      child: Text(
                        "Your leave application has been sent successfully.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                          color: AppColors.charcoal,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                        _formKey.currentState?.reset();
                        setState(() {
                          _fromDate = null;
                          _toDate = null;
                          _fromDateError = null;
                          _toDateError = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          ScreenUtilHelper.scaleWidth(133),
                          ScreenUtilHelper.scaleHeight(33),
                        ),
                        backgroundColor: AppColors.primaryDarkest,
                      ),
                      child: Text(
                        "Create New",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                          fontWeight: AppStyles.weight.emphasis,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
