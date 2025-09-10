import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/visitor_bloc.dart';

class VisitorFormScreen extends StatefulWidget {
  const VisitorFormScreen({super.key});

  @override
  State<VisitorFormScreen> createState() => _VisitorFormScreenState();
}

class _VisitorFormScreenState extends State<VisitorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _visitorNameController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _commentController = TextEditingController();

  String? _selectedClass;
  String? _selectedRelation;
  String? _selectedPurpose;

  final List<String> _classes = ['VII B', 'VIII A', 'IX C', 'X D'];
  final List<String> _relations = ['Father', 'Mother', 'Guardian', 'Sibling'];
  final List<String> _purposes = [
    'Casual',
    'Meeting Teacher',
    'Fee Payment',
    'Official'
  ];

  @override
  void dispose() {
    _visitorNameController.dispose();
    _studentNameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<VisitorBloc>().add(SubmitNewVisitorPass(
        visitorName: _visitorNameController.text,
        studentName: _studentNameController.text,
        studentClass: _selectedClass!,
        relation: _selectedRelation!,
        purpose: _selectedPurpose!,
        comment: _commentController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop()),
        title: Text('Create Visitor Pass',
            style: TextStyle(color: theme.primaryColor)),
      ),
      body: BlocListener<VisitorBloc, VisitorState>(
        listener: (context, state) {
          if (state is VisitorFormSubmissionSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            context.go(AppRoutes.hostelVisitorPermissionGranted);
          } else if (state is VisitorError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Guest Pass ID', style: theme.textTheme.bodyMedium),
                Text('2025 2536 78',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text('04/03/2025', style: theme.textTheme.bodySmall),
                SizedBox(height: ScreenUtilHelper.height(24)),
                _buildTextFormField(
                    context: context,
                    controller: _visitorNameController,
                    label: 'Visitor Name *'),
                _buildTextFormField(
                    context: context,
                    controller: _studentNameController,
                    label: 'Student Name *'),
                _buildDropdownFormField(
                  context: context,
                  value: _selectedClass,
                  label: 'Class *',
                  items: _classes,
                  onChanged: (value) => setState(() => _selectedClass = value),
                ),
                _buildDropdownFormField(
                  context: context,
                  value: _selectedRelation,
                  label: 'Relation *',
                  items: _relations,
                  onChanged: (value) =>
                      setState(() => _selectedRelation = value),
                ),
                _buildDropdownFormField(
                  context: context,
                  value: _selectedPurpose,
                  label: 'Purpose *',
                  items: _purposes,
                  onChanged: (value) =>
                      setState(() => _selectedPurpose = value),
                ),
                _buildTextFormField(
                    context: context,
                    controller: _commentController,
                    label: 'Comment',
                    maxLines: 3,
                    isOptional: true),
                SizedBox(height: ScreenUtilHelper.height(30)),
                BlocBuilder<VisitorBloc, VisitorState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is VisitorLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              double.infinity, ScreenUtilHelper.height(50))),
                      child: state is VisitorLoading
                          ? SizedBox(
                          height: ScreenUtilHelper.scaleAll(20),
                          width: ScreenUtilHelper.scaleAll(20),
                          child: const CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ))
                          :  Text('Submit',),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    bool isOptional = false,
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
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(12)),
            ),
            validator: (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
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
    required BuildContext context,
    required T? value,
    required String label,
    required List<T> items,
    required void Function(T?) onChanged,
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
            validator: (val) {
              if (val == null) {
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