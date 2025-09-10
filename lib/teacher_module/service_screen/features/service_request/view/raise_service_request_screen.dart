import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
//import '../../../../utils/app_colors.dart';
//import '../../../../utils/date_formatter.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../models/service_request.dart';

import '../bloc/raise_service_request_cubit.dart'; // For generating mock IDs

class RaiseServiceRequestScreen extends StatefulWidget {
  const RaiseServiceRequestScreen({super.key});

  @override
  State<RaiseServiceRequestScreen> createState() =>
      _RaiseServiceRequestScreenState();
}

class _RaiseServiceRequestScreenState extends State<RaiseServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController(
    text: '1',
  ); // Default quantity
  // final _servicetypeController = TextEditingController(text: 'Electrician');
  // final _priorityController = TextEditingController(text: 'High');
  final _commentController = TextEditingController();

  // State variables for form fields
  RequestType _selectedRequestType = RequestType.Product; // Default selection
  String? _selectedServiceType;
  RequestPriority _selectedPriority =
      RequestPriority.Medium; // Default priority
  int? _selectedQuantity = 1; // Default

  // Mock data for display - replace with actual data source if needed
  final String _mockRequestId =
      '${DateTime.now().year}${const Uuid().v4().substring(0, 8).replaceAll('-', '')}'
          .substring(0, 10); // Generate a somewhat realistic ID
  final DateTime _mockRequestDate = DateTime.now();

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (context) => RaiseServiceRequestCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.blackHighEmphasis,size: 24,),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/edudibon_logo.png',
                  height: ScreenUtilHelper.height(30),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>context.push(AppRoutes.notifications),
                  child: Image.asset(
                    'assets/images/notification.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          // elevation: 1.0,
        ),
        body: BlocConsumer<RaiseServiceRequestCubit, RaiseServiceRequestState>(
          listener: (context, state) {
            if (state is RaiseServiceRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Service request submitted!'),
                  backgroundColor: AppColors.success,
                ),
              );
              GoRouter.of(context).pop(true); // Pop with success indicator
            } else if (state is RaiseServiceRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            bool isSubmitting = state is RaiseServiceRequestSubmitting;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  ScreenUtilHelper.scaleAll(20.0),
                ), // ScreenUtilHelper

                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Request ID and Date (Display Only)
                      _buildReadOnlyField(
                        'Request ID',
                        _formatDisplayId(_mockRequestId),
                      ),
                      SizedBox(
                        height: ScreenUtilHelper.height(15),
                      ), // ScreenUtilHelper

                      _buildReadOnlyField(
                        'Date',
                        DateFormatter.formatDateSimple(_mockRequestDate),
                      ),
                      SizedBox(
                        height: ScreenUtilHelper.height(20),
                      ), // ScreenUtilHelper
                      // Product or Service Selection
                      _buildLabel('Request Type', isRequired: true),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<RequestType>(
                              title: const Text('Product'),
                              value: RequestType.Product,
                              groupValue: _selectedRequestType,
                              onChanged:
                                  isSubmitting
                                      ? null
                                      : (value) => setState(
                                        () => _selectedRequestType = value!,
                                      ),
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<RequestType>(
                              title: const Text('Service'),
                              value: RequestType.Service,
                              groupValue: _selectedRequestType,
                              onChanged:
                                  isSubmitting
                                      ? null
                                      : (value) => setState(
                                        () => _selectedRequestType = value!,
                                      ),
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtilHelper.height(20),
                      ), // ScreenUtilHelper
                      const Divider(),
                      SizedBox(
                        height: ScreenUtilHelper.height(20),
                      ), // ScreenUtilHelper
                      // Conditional Fields based on RequestType
                      if (_selectedRequestType == RequestType.Product) ...[
                        _buildLabel('Product Name', isRequired: true),
                        TextFormField(
                          controller: _productNameController,
                          decoration: _inputDecoration(
                            hint: 'Enter product name',
                          ),
                          enabled: !isSubmitting,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Product name is required'
                                      : null,
                          textCapitalization: TextCapitalization.words,
                        ),
                        SizedBox(
                          height: ScreenUtilHelper.height(20),
                        ), // ScreenUtilHelper

                        _buildLabel('Quantity', isRequired: true),
                        DropdownButtonFormField<int>(
                          value: _selectedQuantity,
                          items:
                              List.generate(
                                    10,
                                    (index) => index + 1,
                                  ) // Example: 1 to 10
                                  .map(
                                    (qty) => DropdownMenuItem(
                                      value: qty,
                                      child: Text(qty.toString()),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              isSubmitting
                                  ? null
                                  : (value) =>
                                      setState(() => _selectedQuantity = value),
                          decoration: _inputDecoration(hint: 'Select quantity'),
                          validator:
                              (value) =>
                                  value == null ? 'Quantity is required' : null,
                        ),
                      ] else ...[
                        // Service Fields
                        _buildLabel('Service Type', isRequired: true),
                        DropdownButtonFormField<String>(
                          value: _selectedServiceType,
                          hint: const Text('Select service type'),
                          items:
                              serviceTypes
                                  .map(
                                    (service) => DropdownMenuItem(
                                      value: service,
                                      child: Text(service),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              isSubmitting
                                  ? null
                                  : (value) => setState(
                                    () => _selectedServiceType = value,
                                  ),
                          decoration: _inputDecoration(
                            hint: 'Select service type',
                          ),
                          validator:
                              (value) =>
                                  value == null
                                      ? 'Service type is required'
                                      : null,
                        ),
                        SizedBox(
                          height: ScreenUtilHelper.height(20),
                        ), // ScreenUtilHelper

                        _buildLabel('Priority', isRequired: true),
                        DropdownButtonFormField<RequestPriority>(
                          value: _selectedPriority,
                          items:
                              priorities
                                  .map(
                                    (p) => DropdownMenuItem(
                                      value: p,
                                      child: Text(p.name),
                                    ),
                                  ) // Use enum name
                                  .toList(),
                          onChanged:
                              isSubmitting
                                  ? null
                                  : (value) => setState(
                                    () => _selectedPriority = value!,
                                  ),
                          decoration: _inputDecoration(hint: 'Select priority'),
                          validator:
                              (value) =>
                                  value == null ? 'Priority is required' : null,
                        ),
                      ],
                      SizedBox(
                        height: ScreenUtilHelper.height(20),
                      ), // ScreenUtilHelper
                      // Comment Field (Common)
                      _buildLabel(
                        'Comment',
                      ), // Not strictly required per UI, but good practice
                      TextFormField(
                        controller: _commentController,
                        decoration: _inputDecoration(
                          hint: 'Please order white color fans',
                        ).copyWith(
                          hintStyle: TextStyle(
                            color: AppColors.silver,
                          ), // Lighter hint
                        ),
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        enabled: !isSubmitting,
                        // No validator needed if optional
                      ),
                      SizedBox(
                        height: ScreenUtilHelper.height(30),
                      ), // ScreenUtilHelper
                      // Submit Button
                      Center(
                        child: SizedBox(
                          width: ScreenUtilHelper.width(
                            150,
                          ), // ScreenUtilHelper

                          child: ElevatedButton(
                            onPressed:
                                isSubmitting
                                    ? null
                                    : () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<RaiseServiceRequestCubit>()
                                            .submitRequest(
                                              requestType: _selectedRequestType,
                                              productName:
                                                  _selectedRequestType ==
                                                          RequestType.Product
                                                      ? _productNameController
                                                          .text
                                                      : null,
                                              quantity:
                                                  _selectedRequestType ==
                                                          RequestType.Product
                                                      ? _selectedQuantity
                                                      : null,
                                              serviceType:
                                                  _selectedRequestType ==
                                                          RequestType.Service
                                                      ? _selectedServiceType
                                                      : null,
                                              priority:
                                                  _selectedRequestType ==
                                                          RequestType.Service
                                                      ? _selectedPriority
                                                      : null,
                                              comment:
                                                  _commentController.text
                                                      .trim(),
                                              // Pass generated ID and Date if backend doesn't handle it
                                              // generatedId: _mockRequestId,
                                              // requestDate: _mockRequestDate,
                                            );
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.white, // White background
                              foregroundColor:
                                  AppColors.primaryDarkest, // Blue text
                              side: const BorderSide(
                                color: Color(0xffAFADDF),
                              ), // Blue border
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtilHelper.height(
                                  15,
                                ), // ScreenUtilHelper
                              ),

                              textStyle: TextStyle(
                                fontSize: ScreenUtilHelper.fontSize(
                                  AppStyles.size.body,
                                ), // ScreenUtilHelper

                                fontWeight: AppStyles.weight.heading,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtilHelper.radius(10),
                                ), // ScreenUtilHelper
                              ),
                            ),
                            child:
                                isSubmitting
                                    ? SizedBox(
                                      height: ScreenUtilHelper.height(
                                        20,
                                      ), // ScreenUtilHelper
                                      width: ScreenUtilHelper.width(
                                        20,
                                      ), // ScreenUtilHelper

                                      child: CircularProgressIndicator(
                                        strokeWidth: ScreenUtilHelper.scaleAll(
                                          2,
                                        ), // ScreenUtilHelper

                                        color: AppColors.primaryDarkest,
                                      ),
                                    )
                                    : const Text('Submit'),
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

  // Helper for consistent labels
  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtilHelper.height(8.0),
      ), // ScreenUtilHelper

      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight:
                  AppStyles.weight.medium, // Slightly lighter than ticket form
              color: AppColors.blackHighEmphasis,
              fontSize: ScreenUtilHelper.fontSize(
                AppStyles.size.bodySmall,
              ), // ScreenUtilHelper
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                color: AppColors.error,
                fontSize: ScreenUtilHelper.fontSize(
                  AppStyles.size.bodySmall,
                ), // ScreenUtilHelper
              ),
            ),
        ],
      ),
    );
  }

  // Helper for consistent input decoration
  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.silver),
      filled: true, // Fill background
      fillColor: AppColors.white, // White fill
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.radius(8),
        ), // ScreenUtilHelper

        borderSide: BorderSide(color: AppColors.cloud), // Lighter border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.radius(8),
        ), // ScreenUtilHelper

        borderSide: BorderSide(color: AppColors.cloud),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.radius(8),
        ), // ScreenUtilHelper

        borderSide: BorderSide(
          color: AppColors.primaryDarkest,
          width: ScreenUtilHelper.width(1), // ScreenUtilHelper
        ), // Thinner focus border
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtilHelper.radius(8),
        ), // ScreenUtilHelper

        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(12), // ScreenUtilHelper
        vertical: ScreenUtilHelper.height(14), // ScreenUtilHelper
      ),

      isDense: true,
    );
  }

  // Helper for read-only fields with grey background
  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12), // ScreenUtilHelper
            vertical: ScreenUtilHelper.height(14), // ScreenUtilHelper
          ),
          decoration: BoxDecoration(
            color: AppColors.linen.withOpacity(0.7), // Grey background
            borderRadius: BorderRadius.circular(
              ScreenUtilHelper.radius(8),
            ), // ScreenUtilHelper
          ),

          child: Text(
            value,
            style: TextStyle(
              color: AppColors.blackMediumEmphasis,
              fontSize: ScreenUtilHelper.fontSize(
                AppStyles.size.bodySmall,
              ), // ScreenUtilHelper
            ),
          ),
        ),
      ],
    );
  }

  // Format ID for display like "YYYY XXXX XX"
  String _formatDisplayId(String id) {
    if (id.length == 10) {
      return '${id.substring(0, 4)} ${id.substring(4, 8)} ${id.substring(8)}';
    }
    return id; // Return original if format doesn't match
  }
}
