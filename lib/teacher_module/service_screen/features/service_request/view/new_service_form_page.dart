// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import '../../../data/sources/mock_data_source.dart'; // For providing
// import '../../../models/enums.dart'; // Import enums
// import '../bloc/new_service_form_cubit.dart';
// import '../bloc/new_service_form_state.dart'; // Import Cubit and State
//
// class NewServiceFormPage extends StatefulWidget {
//   const NewServiceFormPage({Key? key}) : super(key: key);
//
//   @override
//   State<NewServiceFormPage> createState() => _NewServiceFormPageState();
// }
//
// class _NewServiceFormPageState extends State<NewServiceFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _productNameController = TextEditingController();
//   final _quantityController = TextEditingController();
//   final _commentController = TextEditingController();
//
//   bool _isService = true; // Default based on mockup
//   ServiceType? _selectedServiceType = ServiceType.electrician; // Default
//   Priority _selectedPriority = Priority.high; // Default
//
//   @override
//   void dispose() {
//     _productNameController.dispose();
//     _quantityController.dispose();
//     _commentController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Provide cubit here or higher up the tree
//     return BlocProvider(
//       create: (context) => NewServiceFormCubit(repository: MockDataSource()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('New Service Form'), // Or dynamic title
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () => GoRouter.of(context).pop(),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.notifications_none),
//               onPressed: () {},
//             ),
//           ],
//           backgroundColor: Colors.white, // Match mockup
//           foregroundColor: Colors.black, // Match mockup
//           elevation: 1,
//         ),
//         body: BlocConsumer<NewServiceFormCubit, NewServiceFormState>(
//           listener: (context, state) {
//             if (state.status == FormStatus.success) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Service Request Submitted Successfully!'),
//                 ),
//               );
//               GoRouter.of(context).pop(); // Go back after success
//             } else if (state.status == FormStatus.failure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Submission Failed: ${state.errorMessage ?? 'Unknown Error'}',
//                   ),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             bool isLoading = state.status == FormStatus.submitting;
//
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildHeader(),
//                     const SizedBox(height: 16),
//                     _buildRequestTypeSelector(),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _productNameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Product Name *',
//                       ),
//                       validator:
//                           (value) =>
//                               (value == null || value.isEmpty)
//                                   ? 'Please enter a product name'
//                                   : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _quantityController,
//                       decoration: const InputDecoration(
//                         labelText: 'Quantity *',
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty)
//                           return 'Please enter quantity';
//                         if (int.tryParse(value) == null ||
//                             int.parse(value) <= 0)
//                           return 'Please enter a valid quantity';
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<ServiceType>(
//                       value: _selectedServiceType,
//                       decoration: const InputDecoration(
//                         labelText: 'Service Type *',
//                       ),
//                       items:
//                           ServiceType.values.map((ServiceType type) {
//                             return DropdownMenuItem<ServiceType>(
//                               value: type,
//                               child: Text(
//                                 type.name,
//                               ), // Use display name if available
//                             );
//                           }).toList(),
//                       onChanged: (ServiceType? newValue) {
//                         setState(() {
//                           _selectedServiceType = newValue;
//                         });
//                       },
//                       validator:
//                           (value) =>
//                               value == null
//                                   ? 'Please select a service type'
//                                   : null,
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<Priority>(
//                       value: _selectedPriority,
//                       decoration: const InputDecoration(
//                         labelText: 'Priority *',
//                       ),
//                       items:
//                           Priority.values.map((Priority prio) {
//                             return DropdownMenuItem<Priority>(
//                               value: prio,
//                               child: Text(
//                                 prio.name,
//                               ), // Use display name if available
//                             );
//                           }).toList(),
//                       onChanged: (Priority? newValue) {
//                         setState(() {
//                           _selectedPriority = newValue!;
//                         });
//                       },
//                       validator:
//                           (value) =>
//                               value == null ? 'Please select priority' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _commentController,
//                       decoration: const InputDecoration(
//                         labelText: 'Comment',
//                         alignLabelWithHint: true, // Better for multi-line
//                       ),
//                       maxLines: 3,
//                       // No validator needed for optional comment
//                     ),
//                     const SizedBox(height: 32),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed:
//                             isLoading ? null : () => _submitForm(context),
//                         child:
//                             isLoading
//                                 ? const SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                                 : const Text('Submit'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 50,
//                             vertical: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     final dateFormat = DateFormat('dd/MM/yyyy');
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // You might fetch the actual next Request ID or generate one
//         const Text(
//           'Request ID\n2025 2536 78',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Text(
//           dateFormat.format(DateTime.now()),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRequestTypeSelector() {
//     // Using simple Checkboxes based on mockup, could be Radio buttons too
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Checkbox(
//               value: !_isService,
//               onChanged: (value) {
//                 setState(() {
//                   _isService = false;
//                 });
//               },
//             ),
//             const Text('Product'),
//           ],
//         ),
//         const SizedBox(width: 20),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Checkbox(
//               value: _isService,
//               onChanged: (value) {
//                 setState(() {
//                   _isService = true;
//                 });
//               },
//             ),
//             const Text('Service'),
//           ],
//         ),
//       ],
//     );
//   }
//
//   void _submitForm(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       // Form is valid, collect data
//       final formData = {
//         'isService': _isService,
//         'productName': _productNameController.text,
//         'quantity': int.parse(_quantityController.text),
//         'serviceType': _selectedServiceType?.name, // Send name or enum value
//         'priority': _selectedPriority.name, // Send name or enum value
//         'comment': _commentController.text,
//         // Add other relevant fields like user ID, request date etc.
//       };
//
//       // Call the Cubit method
//       context.read<NewServiceFormCubit>().submitForm(formData);
//     }
//   }
// }
