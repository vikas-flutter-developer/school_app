import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../models/ticket.dart';
import '../bloc/raise_ticket_cubit.dart';


class RaiseTicketScreen extends StatefulWidget {
  const RaiseTicketScreen({super.key});

  @override
  State<RaiseTicketScreen> createState() => _RaiseTicketScreenState();
}

class _RaiseTicketScreenState extends State<RaiseTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _raisedByController = TextEditingController(
    text: 'English Teacher (Anita Kapoor)',
  );
  final _ticketIdController = TextEditingController(
    text: 'XXXXXX',
  );

  String? _selectedCategory;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _reasonController.dispose();
    _raisedByController.dispose();
    _ticketIdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // <-- ScreenUtilHelper init added

    return BlocProvider(
      create: (context) => RaiseTicketCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffBFBCEF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 23, // you can also wrap with ScreenUtilHelper.width(23) if needed
              color: AppColors.blackHighEmphasis,
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            'Raise Ticket',
            style: TextStyle(
              color: AppColors.blackHighEmphasis,
              fontWeight: AppStyles.weight.emphasis,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.headingLarge), // wrapped fontSize
            ),
          ),
        ),
        body: BlocConsumer<RaiseTicketCubit, RaiseTicketState>(
          listener: (context, state) {
            if (state is RaiseTicketSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ticket submitted successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
              GoRouter.of(context).pop(true);
            } else if (state is RaiseTicketFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            bool isSubmitting = state is RaiseTicketSubmitting;

            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.width(20)), // wrapped padding
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Ticket Id'),
                    TextFormField(
                      controller: _ticketIdController,
                      readOnly: true,
                      style: TextStyle(color: AppColors.stone),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.parchment,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(12),  // wrapped padding
                          vertical: ScreenUtilHelper.height(14),   // wrapped padding
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)), // wrapped height

                    _buildLabel('Category', isRequired: true),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      hint: const Text('Select Category'),
                      decoration: _inputDecoration(),
                      items: ticketCategories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: isSubmitting ? null : (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Please select a category' : null,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)), // wrapped height

                    _buildLabel('Raised By', isRequired: true),
                    TextFormField(
                      controller: _raisedByController,
                      readOnly: true,
                      style: TextStyle(color: AppColors.stone),
                      decoration: _inputDecoration().copyWith(
                        filled: true,
                        fillColor: AppColors.parchment,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)), // wrapped height

                    _buildLabel('Date', isRequired: true),
                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedDate == null ? '' : DateFormatter.formatDateInput(_selectedDate!),
                      ),
                      decoration: _inputDecoration().copyWith(
                        hintText: 'DD-MM-YYYY',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryDarkest,
                          ),
                          onPressed: isSubmitting ? null : () => _selectDate(context),
                        ),
                      ),
                      onTap: isSubmitting ? null : () => _selectDate(context),
                      validator: (value) => _selectedDate == null ? 'Please select a date' : null,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)), // wrapped height

                    _buildLabel('Reason', isRequired: true),
                    TextFormField(
                      controller: _reasonController,
                      decoration: _inputDecoration().copyWith(
                        hintText: 'Enter reason here...',
                      ),
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      enabled: !isSubmitting,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a reason';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: ScreenUtilHelper.height(30)), // wrapped height

                    Center(
                      child: SizedBox(
                        width: ScreenUtilHelper.width(186), // wrapped width
                        height: ScreenUtilHelper.height(50), // wrapped height
                        child: ElevatedButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<RaiseTicketCubit>().submitTicket(
                                category: _selectedCategory!,
                                raisedBy: _raisedByController.text,
                                date: _selectedDate!,
                                reason: _reasonController.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0E4F9C),
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilHelper.height(15), // wrapped padding
                            ),
                            textStyle: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.headingLarge), // wrapped fontSize
                              fontWeight: AppStyles.weight.emphasis,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // wrapped radius
                            ),
                          ),
                          child: isSubmitting
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                              : const Text(
                            'Submit',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)), // wrapped padding
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: AppStyles.weight.emphasis,
              color: AppColors.blackHighEmphasis,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // wrapped fontSize
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                color: AppColors.error,
                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // wrapped fontSize
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
        borderSide: BorderSide(color: AppColors.silver),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
        borderSide: BorderSide(color: AppColors.silver),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
        borderSide: BorderSide(color: AppColors.primaryDarkest, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // wrapped radius
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(12), // wrapped padding
        vertical: ScreenUtilHelper.height(14), // wrapped padding
      ),
      isDense: true,
    );
  }
}
