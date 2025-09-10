import 'package:go_router/go_router.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/teacher_module/leave_management//screens/service_request_sent_screen.dart' show ServiceRequestSentScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '../bloc/permission_bloc/permission_bloc.dart';
import '../models/permission.dart';
import '../widgets/notification_badge.dart';
import '../widgets/screen_header.dart';

class NewPermissionScreen extends StatefulWidget {
  const NewPermissionScreen({super.key});

  @override
  State<NewPermissionScreen> createState() => _NewPermissionScreenState();
}

class _NewPermissionScreenState extends State<NewPermissionScreen> {
  final int notificationCount = 3;
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _anotherReasonController = TextEditingController();
  DateTime? _fromDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;

  String? _reasonError;
  String? _anotherReasonError;
  String? _fromDateError;
  String? _fromTimeError;
  String? _toTimeError;

  bool get _isFormValid {
    return _formKey.currentState?.validate() == true &&
        _fromDate != null &&
        _fromTime != null &&
        _toTime != null &&
        _reasonController.text.isNotEmpty &&
        _anotherReasonController.text.isNotEmpty;
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fromDate) {
      setState(() {
        _fromDate = picked;
        _fromDateError = null;
      });
    }
  }

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _fromTime) {
      setState(() {
        _fromTime = picked;
        _fromTimeError = null;
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _toTime) {
      setState(() {
        _toTime = picked;
        _toTimeError = null;
      });
    }
  }

  void _validateForm() {
    setState(() {
      _reasonError =
          _reasonController.text.isEmpty ? 'Please enter a reason' : null;
      _anotherReasonError =
          _anotherReasonController.text.isEmpty
              ? 'Please enter another reason'
              : null;
      _fromDateError = _fromDate == null ? 'Please select a date' : null;
      _fromTimeError = _fromTime == null ? 'Please select a time' : null;
      _toTimeError = _toTime == null ? 'Please select a time' : null;
    });

    if (_isFormValid) {
      final fromDateTime = DateTime(
        _fromDate!.year,
        _fromDate!.month,
        _fromDate!.day,
        _fromTime!.hour,
        _fromTime!.minute,
      );
      final toDateTime = DateTime(
        _fromDate!.year,
        _fromDate!.month,
        _fromDate!.day,
        _toTime!.hour,
        _toTime!.minute,
      );

      final formattedDateRange =
          '${DateFormat('EEE dd MMM, hh:mma').format(fromDateTime)}-${DateFormat('hh:mma').format(toDateTime)}';

      final difference = toDateTime.difference(fromDateTime);
      final hours = '${difference.inHours} Hours';

      final newPermission = Permission(
        hours: hours,
        dateRange: formattedDateRange,
        reason: _reasonController.text,
        status: 'Pending',
        statusColor: AppColors.chapterTile2Bg,
        statusIcon: Icons.lock_clock,
        iconColor: AppColors.pending,
      );

      BlocProvider.of<PermissionBloc>(
        context,
      ).add(ApplyPermission(newPermission));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionBloc, PermissionState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.push(AppRoutes.requestSent);
        }
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: ScreenHeader(title: "New Permission"),
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          actions: const [NotificationBadge(count: 3)],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reason Field (First)
                      _buildFieldWithLabel(
                        label: "Reason",
                        isRequired: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 51,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.cloud,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: TextFormField(
                                  controller: _reasonController,
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize:  AppStyles.size.medium,
                                      color: AppColors.graphite,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _reasonError =
                                          value.isEmpty
                                              ? 'Please enter a reason'
                                              : null;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            if (_reasonError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _reasonError!,
                                  style:  TextStyle(
                                    color: AppColors.error,
                                    fontSize:  AppStyles.size.small,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // From Date Field
                      _buildFieldWithLabel(
                        label: "From Date",
                        isRequired: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDateField(
                              context,
                              value:
                                  _fromDate != null
                                      ? DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(_fromDate!)
                                      : null,
                              onTap: () => _selectFromDate(context),
                            ),
                            if (_fromDateError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _fromDateError!,
                                  style:  TextStyle(
                                    color: AppColors.error,
                                    fontSize: AppStyles.size.small,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // From Time Field
                      _buildFieldWithLabel(
                        label: "From Time",
                        isRequired: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTimeField(
                              context,
                              value: _fromTime?.format(context),
                              onTap: () => _selectFromTime(context),
                            ),
                            if (_fromTimeError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _fromTimeError!,
                                  style:  TextStyle(
                                    color: AppColors.error,
                                    fontSize: AppStyles.size.small,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // To Time Field
                      _buildFieldWithLabel(
                        label: "To Time",
                        isRequired: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTimeField(
                              context,
                              value: _toTime?.format(context),
                              onTap: () => _selectToTime(context),
                            ),
                            if (_toTimeError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _toTimeError!,
                                  style:  TextStyle(
                                    color: AppColors.error,
                                    fontSize: AppStyles.size.small,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Another Reason Field (Last)
                      _buildFieldWithLabel(
                        label: "Reason",
                        isRequired: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.cloud,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: TextFormField(
                                  controller: _anotherReasonController,
                                  maxLines: null,
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: AppStyles.size.medium,
                                      color:AppColors.graphite,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _anotherReasonError =
                                          value.isEmpty
                                              ? 'Please enter another reason'
                                              : null;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            if (_anotherReasonError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _anotherReasonError!,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: AppStyles.size.small,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // In your button code (make sure you have BuildContext available):
                          SizedBox(
                            width: 186,
                            height: 51,
                            child: ElevatedButton(
                              onPressed: _validateForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDarkest,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child:  Text(
                                "Apply",
                                style: TextStyle(
                                  fontSize: AppStyles.size.heading,
                                  fontWeight: AppStyles.weight.emphasis,
                                  color:  AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              style:  TextStyle(
                fontSize: AppStyles.size.heading,
                fontWeight: AppStyles.weight.regular,
                color: AppColors.blackHighEmphasis,
              ),
            ),
            if (isRequired)
               Text(
                "*",
                style: TextStyle(
                  fontSize: AppStyles.size.heading ,
                  fontWeight:  AppStyles.weight.regular,
                  color:  AppColors.error,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        child,
      ],
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 51,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color:  AppColors.cloud,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? "Select date",
                  style: TextStyle(
                    fontSize:  AppStyles.size.medium,
                    color:
                        value != null
                            ? AppColors.blackHighEmphasis
                            : AppColors.cloud,
                  ),
                ),
              ),
              const Icon(
                Icons.calendar_today,
                color:  AppColors.primaryMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField(
    BuildContext context, {
    String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 51,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color:  AppColors.cloud,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? "Select time",
                  style: TextStyle(
                    fontSize:  AppStyles.size.medium,
                    color:
                        value != null
                            ? AppColors.blackHighEmphasis
                            : AppColors.cloud,

                  ),
                ),
              ),
              const Icon(
                Icons.access_time,
                color:  AppColors.primaryMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
