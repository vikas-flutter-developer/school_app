import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../bloc/indent_management/indent_management_bloc.dart';
import '../bloc/indent_management/indent_management_event.dart';
import '../data/models/indent_model.dart';

class AddIndentDialog extends StatefulWidget {
  const AddIndentDialog({super.key});

  @override
  State<AddIndentDialog> createState() => _AddIndentDialogState();
}

class _AddIndentDialogState extends State<AddIndentDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String? _selectedStore;
  String _productDetails = '';
  String _remarks = '';

  final List<String> _stores = ['Store A', 'Store B', 'Store C'];

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0))),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(20.0)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Indents',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => GoRouter.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.height(20)),
                _buildTextFormField(
                  context,
                  label: 'Title / Description',
                  onSaved: (value) => _title = value ?? '',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter a title'
                      : null,
                ),
                SizedBox(height: ScreenUtilHelper.height(15)),
                _buildDropdownFormField(
                  context,
                  label: 'Request to store',
                  value: _selectedStore,
                  items: _stores,
                  onChanged: (value) => setState(() => _selectedStore = value),
                  validator: (value) =>
                  value == null ? 'Please select a store' : null,
                ),
                SizedBox(height: ScreenUtilHelper.height(15)),
                _buildTextFormField(
                  context,
                  label: 'Product / Stock / Qty',
                  onSaved: (value) => _productDetails = value ?? '',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter product details'
                      : null,
                ),
                SizedBox(height: ScreenUtilHelper.height(15)),
                _buildTextFormField(
                  context,
                  label: 'Remarks / Narration',
                  onSaved: (value) => _remarks = value ?? '',
                  maxLines: 3,
                ),
                SizedBox(height: ScreenUtilHelper.height(25)),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryMedium,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(50),
                        vertical: ScreenUtilHelper.height(15),
                      ),
                      textStyle:
                      TextStyle(fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newIndent = IndentModel(
                          srNo: '',
                          indentNo: '',
                          date: DateTime.now(),
                          title: _title,
                          raisedBy: 'Current User',
                          department: 'User Department',
                          status: IndentStatus.pending,
                          storeRequested: _selectedStore!,
                          productDetails: _productDetails,
                          remarks: _remarks,
                        );
                        context.read<IndentBloc>().add(AddIndent(newIndent));
                        GoRouter.of(context).pop();
                      }
                    },
                    child: const Text('Add Indents',style: TextStyle(color: AppColors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      BuildContext context, {
        required String label,
        required FormFieldSetter<String> onSaved,
        FormFieldValidator<String>? validator,
        int maxLines = 1,
      }) {
    ScreenUtilHelper.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: ScreenUtilHelper.height(5)),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black),
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(10),
            ),
          ),
          maxLines: maxLines,
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdownFormField(
      BuildContext context, {
        required String label,
        required String? value,
        required List<String> items,
        required ValueChanged<String?> onChanged,
        FormFieldValidator<String>? validator,
      }) {
    ScreenUtilHelper.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: ScreenUtilHelper.height(5)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black),
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(10),
            ),
          ),
          value: value,
          hint: Text('Select $label'),
          items: items
              .map(
                (item) => DropdownMenuItem(value: item, child: Text(item)),
          )
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}