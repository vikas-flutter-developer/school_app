import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../models/service_request_model.dart';
import '../bloc/services_bloc.dart';
import '../bloc/services_event.dart';
import '../bloc/services_state.dart';

class ServiceRequestFormScreen extends StatefulWidget {
  const ServiceRequestFormScreen({super.key});

  @override
  State<ServiceRequestFormScreen> createState() => _ServiceRequestFormScreenState();
}

class _ServiceRequestFormScreenState extends State<ServiceRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  RequestTypes _requestType = RequestTypes.product;

  final _productNameController = TextEditingController(text: "Fan");
  final _quantityController = TextEditingController(text: "3");
  final _commentController = TextEditingController(text: "Please order white color fans");

  String? _selectedServiceType;
  RequestPrioritys _selectedPriority = RequestPrioritys.high;

  final List<String> _serviceTypes = ['Electrician', 'Plumber', 'Carpenter', 'Cleaning'];

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<ServiceRequestsBloc>().add(SubmitServiceRequest(
        type: _requestType,
        productName: _requestType == RequestTypes.product ? _productNameController.text : null,
        quantity: _requestType == RequestTypes.product ? int.tryParse(_quantityController.text) : null,
        serviceType: _requestType == RequestTypes.service || _selectedServiceType != null ? _selectedServiceType : "Electrician",
        priority: _selectedPriority,
        comment: _commentController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20)),
          onPressed: () => context.pop(),
        ),
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
      ),
      body: BlocListener<ServiceRequestsBloc, ServiceRequestState>(
        listener: (context, state) {
          if (state is ServiceRequestSubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            context.go(AppRoutes.hostelServiceRequestSent);
          } else if (state is ServiceRequestError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request ID', style: theme.textTheme.bodyMedium),
                Text(
                  '2025 2536 78',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text('04/03/2025', style: theme.textTheme.bodySmall),
                SizedBox(height: ScreenUtilHelper.height(16)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<RequestTypes>(
                        title: const Text('Product'),
                        value: RequestTypes.product,
                        groupValue: _requestType,
                        onChanged: (RequestTypes? value) {
                          setState(() {
                            _requestType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<RequestTypes>(
                        title: const Text('Service'),
                        value: RequestTypes.service,
                        groupValue: _requestType,
                        onChanged: (RequestTypes? value) {
                          setState(() {
                            _requestType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                if (_requestType == RequestTypes.product) ...[
                  _buildTextFormField(
                    controller: _productNameController,
                    label: 'Product Name *',
                  ),
                  _buildTextFormField(
                    controller: _quantityController,
                    label: 'Quantity *',
                    keyboardType: TextInputType.number,
                  ),
                ],
                _buildDropdownFormField<String>(
                  value: _selectedServiceType ?? (_requestType == RequestTypes.product ? "Electrician" : null),
                  label: 'Service Type *',
                  items: _serviceTypes,
                  onChanged: (value) => setState(() => _selectedServiceType = value),
                  validator: (value) {
                    if (value == null) return 'Please select a service type';
                    return null;
                  },
                ),
                _buildDropdownFormField<RequestPrioritys>(
                  value: _selectedPriority,
                  label: 'Priority *',
                  items: RequestPrioritys.values,
                  onChanged: (value) => setState(() => _selectedPriority = value!),
                  itemText: (priority) => priority.name.toUpperCase(),
                  validator: (value) {
                    if (value == null) return 'Please select a priority';
                    return null;
                  },
                ),
                _buildTextFormField(
                  controller: _commentController,
                  label: 'Comment',
                  maxLines: 3,
                  isOptional: true,
                ),
                SizedBox(height: ScreenUtilHelper.height(30)),
                BlocBuilder<ServiceRequestsBloc, ServiceRequestState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is ServiceRequestLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, ScreenUtilHelper.height(50)),
                      ),
                      child: state is ServiceRequestLoading
                          ? SizedBox(
                        height: ScreenUtilHelper.height(20),
                        width: ScreenUtilHelper.width(20),
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Submit'),
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
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isOptional = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: ScreenUtilHelper.height(4)),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(12),
              ),
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
    required T? value,
    required String label,
    required List<T> items,
    required void Function(T?) onChanged,
    String Function(T)? itemText,
    String? Function(T?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500)),
          SizedBox(height: ScreenUtilHelper.height(4)),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(4),
              ),
            ),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(itemText != null ? itemText(item) : item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator ?? (val) {
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