import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class InquiryFormScreen extends StatefulWidget {
  final String roomId;
  const InquiryFormScreen({super.key, required this.roomId});

  @override
  State<InquiryFormScreen> createState() => _InquiryFormScreenState();
}

class _InquiryFormScreenState extends State<InquiryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController(text: "Mayuri Shah");
  final _studentMobileController =
  TextEditingController(text: "+91 87589 65744");
  final _studentEmailController =
  TextEditingController(text: "mayurishah@gmail.com");

  String? _selectedDepartment;
  String? _selectedYear;
  String? _selectedAcademicYear;
  String? _selectedRelation;
  String? _selectedPaymentMode;

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentMobileController.dispose();
    _studentEmailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<OccupancyBloc>().add(SubmitInquiry(
        studentName: _studentNameController.text,
        roomId: widget.roomId,
        bedId: "1",
      ));
      context
          .push(AppRoutes.hostelBookingForm.replaceFirst(':roomId', widget.roomId));
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
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                size: ScreenUtilHelper.scaleAll(22)),
            onPressed: () => context.pop()),
      ),
      body: BlocListener<OccupancyBloc, OccupancyState>(
        listener: (context, state) {
          if (state is InquirySubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is OccupancyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Student Details'),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: ScreenUtilHelper.radius(50),
                          backgroundColor: AppColors.parchment,
                          child: Stack(
                            children: [
                              if (_studentNameController.text == "Mayuri Shah")
                                ClipOval(
                                    child: Image.network(
                                        'https://via.placeholder.com/150/FFC107/000000?Text=MS',
                                        fit: BoxFit.cover,
                                        width: ScreenUtilHelper.width(100),
                                        height: ScreenUtilHelper.height(100))),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: ScreenUtilHelper.radius(18),
                                  backgroundColor: theme.primaryColor,
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt,
                                        size: ScreenUtilHelper.scaleAll(18),
                                        color: AppColors.white),
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          )),
                      SizedBox(height: ScreenUtilHelper.height(4)),
                      Text("Upload Photo", style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                _buildTextFormField(
                    controller: _studentNameController, label: 'Name *'),
                _buildTextFormField(
                    controller: _studentMobileController,
                    label: 'Mobile Number *',
                    keyboardType: TextInputType.phone),
                _buildTextFormField(
                    controller: _studentEmailController,
                    label: 'Email ID *',
                    keyboardType: TextInputType.emailAddress),
                _buildDropdownFormField(
                  value: _selectedDepartment,
                  label: 'Department *',
                  items: ['Civil Engineering', 'CSE', 'Mechanical', 'EEE'],
                  onChanged: (value) =>
                      setState(() => _selectedDepartment = value),
                ),
                _buildDropdownFormField(
                  value: _selectedYear,
                  label: 'Year *',
                  items: ['1st Year', '2nd Year', '3rd Year', '4th Year'],
                  onChanged: (value) => setState(() => _selectedYear = value),
                ),
                _buildDropdownFormField(
                  value: _selectedAcademicYear,
                  label: 'Academic Year *',
                  items: ['2024 - 2025', '2023 - 2024'],
                  onChanged: (value) =>
                      setState(() => _selectedAcademicYear = value),
                ),
                _buildTextFormField(
                    controller: TextEditingController(
                        text: "92, kokay, deep bunglow chowk, Mysore, 468879"),
                    label: 'Permanent Address *',
                    maxLines: 3),
                SizedBox(height: ScreenUtilHelper.height(24)),
                _buildSectionHeader('Parent / Guardian Details'),
                _buildTextFormField(
                    controller: TextEditingController(text: "Priyanka Shah"),
                    label: 'Name *'),
                _buildDropdownFormField(
                  value: _selectedRelation,
                  label: 'Relation *',
                  items: ['Mother', 'Father', 'Guardian'],
                  onChanged: (value) =>
                      setState(() => _selectedRelation = value),
                ),
                _buildTextFormField(
                    controller: TextEditingController(text: "Service"),
                    label: 'Occupation *'),
                _buildTextFormField(
                    controller: TextEditingController(text: "+91 87589 64748"),
                    label: 'Mobile Number *',
                    keyboardType: TextInputType.phone),
                _buildTextFormField(
                    controller:
                    TextEditingController(text: "+91 87589 64748"),
                    label: 'Emergency Mobile Number *',
                    keyboardType: TextInputType.phone),
                _buildTextFormField(
                    controller:
                    TextEditingController(text: "priyankashah@gmail.com"),
                    label: 'Email ID *',
                    keyboardType: TextInputType.emailAddress),
                _buildTextFormField(
                    controller: TextEditingController(
                        text: "56 colony, deep bunglow chowk, Mysore, 466 879"),
                    label: 'Permanent Address *',
                    maxLines: 3),
                SizedBox(height: ScreenUtilHelper.height(24)),
                _buildSectionHeader('Payments'),
                _buildTextFormField(
                    controller: TextEditingController(text: "₹ 45,000"),
                    label: 'Advance *',
                    keyboardType: TextInputType.number),
                _buildTextFormField(
                    controller: TextEditingController(text: "₹ 1,00,000"),
                    label: 'Pending *',
                    keyboardType: TextInputType.number),
                _buildTextFormField(
                    controller: TextEditingController(text: "₹ 05,000"),
                    label: 'Caution Money *',
                    keyboardType: TextInputType.number),
                _buildDropdownFormField(
                  value: _selectedPaymentMode,
                  label: 'Mode of Payment *',
                  items: ['Google Pay', 'PhonePe', 'Cash', 'Bank Transfer'],
                  onChanged: (value) =>
                      setState(() => _selectedPaymentMode = value),
                ),
                Text("Proof of payment*", style: theme.textTheme.titleSmall),
                Container(
                  height: ScreenUtilHelper.height(100),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtilHelper.height(8)),
                  decoration: BoxDecoration(
                      color: AppColors.parchment,
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      border: Border.all(color: AppColors.silver)),
                  child: Center(
                      child: Text("Tap to upload (Transaction ID)",
                          style: TextStyle(color: AppColors.stone))),
                ),
                SizedBox(height: ScreenUtilHelper.height(30)),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                          double.infinity, ScreenUtilHelper.height(50))),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ScreenUtilHelper.height(16.0),
          top: ScreenUtilHelper.height(8.0)),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: ScreenUtilHelper.height(4)),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(12)),
            ),
            validator: validator ??
                    (value) {
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

  Widget _buildDropdownFormField<T>({
    required T? value,
    required String label,
    required List<T> items,
    required void Function(T?) onChanged,
    String? Function(T?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: ScreenUtilHelper.height(4)),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(12)),
            ),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator ??
                    (val) {
                  if (label.endsWith('*') && val == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}