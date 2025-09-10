import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class BookingFormMedicalScreen extends StatefulWidget {
  final String roomId;
  final String studentName;
  const BookingFormMedicalScreen({super.key, required this.roomId, required this.studentName});

  @override
  State<BookingFormMedicalScreen> createState() => _BookingFormMedicalScreenState();
}

class _BookingFormMedicalScreenState extends State<BookingFormMedicalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medicalConditionsController = TextEditingController(text: "NA");
  final _allergiesController = TextEditingController(text: "NA");
  final _phobiasController = TextEditingController(text: "NA");
  final _familyDoctorNumberController = TextEditingController(text: "+91 98446 64759");
  final _anythingElseController = TextEditingController();

  bool _agreedToConditions = false;

  @override
  void dispose() {
    _medicalConditionsController.dispose();
    _allergiesController.dispose();
    _phobiasController.dispose();
    _familyDoctorNumberController.dispose();
    _anythingElseController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_agreedToConditions) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to the conditions.')),
        );
        return;
      }
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to confirm this booking?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () => GoRouter.of(dialogContext).pop(),
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  GoRouter.of(dialogContext).pop();
                  context.read<OccupancyBloc>().add(
                    ConfirmBooking(
                      roomId: widget.roomId,
                      studentId: "someStudentIdFromInquiry",
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.scaleWidth(100),
          height: ScreenUtilHelper.scaleHeight(50),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleWidth(20)),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<OccupancyBloc, OccupancyState>(
        listener: (context, state) {
          if (state is BookingConfirmedSuccess) {
            context.go(AppRoutes.hostelSeatConfirmed);
          } else if (state is OccupancyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                _buildSectionHeader('Medical History'),
                Text('Booking Form', style: theme.textTheme.bodySmall),
                SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                _buildTextFormField(controller: _medicalConditionsController, label: 'Do you have any medical Conditions *'),
                _buildTextFormField(controller: _allergiesController, label: 'Do you have any kinds of allergies'),
                _buildTextFormField(controller: _phobiasController, label: 'Do you have any kind of phobias?'),
                _buildTextFormField(controller: _familyDoctorNumberController, label: 'Family Doctor\'s Number *', keyboardType: TextInputType.phone),
                _buildTextFormField(controller: _anythingElseController, label: 'Anything else to know *', maxLines: 3),
                SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
                _buildTermsAndConditions(context),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToConditions,
                      onChanged: (bool? value) => setState(() => _agreedToConditions = value ?? false),
                    ),
                    Expanded(
                      child: Text('I Agree to all the conditions.', style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Later'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(0, ScreenUtilHelper.scaleHeight(50)),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(16)),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Confirm'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, ScreenUtilHelper.scaleHeight(50)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Triple Occupancy', style: theme.textTheme.bodyMedium),
            Text('Room ${widget.roomId}', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
            Row(
              children: [
                Container(width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(20), color: AppColors.pendingAlt, margin: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(5))),
                Container(width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(20), color: AppColors.success, margin: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(5))),
                Container(width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(20), color: AppColors.cloud, margin: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(5))),
              ],
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: ScreenUtilHelper.scaleWidth(40),
              backgroundColor: AppColors.parchment,
              backgroundImage: NetworkImage('https://via.placeholder.com/150/FFC107/000000?Text=${widget.studentName.substring(0, 1)}'),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
            Text("Upload Photo", style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(8)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(12),
                vertical: ScreenUtilHelper.scaleHeight(12),
              ),
            ),
            validator: (value) {
              if (label.endsWith('*') && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
      decoration: BoxDecoration(
        color: AppColors.linen,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
      ),
      child: Text(
        "I, hereby undertake to abide by all the rules and regulations of hostel, maintain discipline, and respect hostel property. I understand that any violation may result in disciplinary action, including suspension or expulsion*",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
      ),
    );
  }
}