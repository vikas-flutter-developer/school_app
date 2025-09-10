import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/staff_form_bloc/staff_form_bloc.dart';
import '../widgets/confirmation_dialog.dart';
import 'approve_request_sent_screen.dart';

class HostelStaffFormScreen extends StatefulWidget {
  const HostelStaffFormScreen({super.key});

  @override
  State<HostelStaffFormScreen> createState() => _HostelStaffFormScreenState();
}

class _HostelStaffFormScreenState extends State<HostelStaffFormScreen> {
  EdgeInsets get _fieldContentPadding {
    return EdgeInsets.symmetric(
      horizontal: ScreenUtilHelper.width(12.0),
      vertical: ScreenUtilHelper.height(10.0),
    );
  }

  Widget _buildTextField({
    required String label,
    required String currentValue,
    required Function(String) onChanged,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isObscure = false,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppStyles.bodySmall.copyWith(color: AppColors.black),
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: AppStyles.weight.medium,
                ),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(6)),
        TextFormField(
          initialValue: currentValue,
          keyboardType: keyboardType,
          obscureText: isObscure,
          maxLines: maxLines,
          style: AppStyles.bodySmall.copyWith(color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.bodySmall.copyWith(color: AppColors.ash),
            filled: true,
            fillColor: AppColors.ivory,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide:  BorderSide(
                color: AppColors.parchment,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide: const BorderSide(color: AppColors.ash),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: ScreenUtilHelper.width(1.5),
              ),
            ),
            contentPadding: _fieldContentPadding,
            isDense: true,
          ),
          onChanged: onChanged,
        ),
        SizedBox(height: ScreenUtilHelper.height(16)),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String? currentValue,
    required ValueChanged<String?> onChanged,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.blackHighEmphasis),
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: AppStyles.weight.medium,
                ),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(6)),
        DropdownButtonFormField<String>(
          value: currentValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppStyles.bodySmall.copyWith(color: AppColors.blackHighEmphasis),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: AppStyles.bodySmall.copyWith(color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.ivory,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
              borderSide: const BorderSide(color: AppColors.ash),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.ash),
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: ScreenUtilHelper.width(1.5),
              ),
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            ),
            contentPadding: _fieldContentPadding,
            isDense: true,
          ),
          icon:  Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
        ),
        SizedBox(height: ScreenUtilHelper.height(16)),
      ],
    );
  }

  Widget _buildUploadButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: ScreenUtilHelper.width(100),
      height: ScreenUtilHelper.height(30),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.ash),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: AppStyles.bodySmall.copyWith(color: AppColors.slate),
        ),
      ),
    );
  }

  Widget _buildTopicContainer({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(20.0)),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16.0),
        vertical: ScreenUtilHelper.height(12.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackDisabled,
            spreadRadius: 0,
            blurRadius: ScreenUtilHelper.radius(8),
            offset: Offset(0, ScreenUtilHelper.height(2)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: ScreenUtilHelper.height(8)), ...children],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocConsumer<StaffFormBloc, StaffFormState>(
      listener: (context, state) {
        if (state.status == StaffFormStatus.success) {
          context.pushReplacement(AppRoutes.hostelStaffRequestSent);
        } else if (state.status == StaffFormStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        final staffData = state.staffMember;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.blackMediumEmphasis,
                size: ScreenUtilHelper.scaleAll(20),
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
            title: SizedBox(
              width: ScreenUtilHelper.width(159),
              height: ScreenUtilHelper.height(39),
              child: Image.asset("assets/images/edudibon.png"),
            ),
            centerTitle: false,
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.blackMediumEmphasis,
                      size: ScreenUtilHelper.scaleAll(28),
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: ScreenUtilHelper.height(10),
                    right: ScreenUtilHelper.width(10),
                    child: Container(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(1)),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: ScreenUtilHelper.width(14),
                        minHeight: ScreenUtilHelper.height(14),
                      ),
                      child: Text(
                        '3',
                        style: AppStyles.label1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: ScreenUtilHelper.width(10)),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0),
                vertical: ScreenUtilHelper.height(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: ScreenUtilHelper.height(202),
                    decoration: BoxDecoration(
                      color: AppColors.ivory,
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(15)),
                    ),
                    padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Staff Id',
                                style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: ScreenUtilHelper.height(4)),
                              Text(
                                staffData.id,
                                style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.black),
                              ),
                              const Spacer(),
                              Text(
                                staffData.status,
                                style: TextStyle(
                                  fontSize: AppStyles.size.bodySmall,
                                  color: staffData.status == "Verified"
                                      ? AppColors.success
                                      : staffData.status == "Pending"
                                      ? AppColors.pending
                                      : AppColors.error,
                                  fontWeight: AppStyles.weight.regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.width(16)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ScreenUtilHelper.width(123),
                              height: ScreenUtilHelper.height(140),
                              decoration: BoxDecoration(
                                color: AppColors.cloud,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(12)),
                                image: DecorationImage(
                                  image: AssetImage(
                                    staffData.imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: staffData.imageUrl.isEmpty ||
                                  !staffData.imageUrl.startsWith(
                                    'assets/images/profile_hostel_empleyee.jpeg',
                                  )
                                  ? Icon(
                                Icons.person,
                                size: ScreenUtilHelper.scaleAll(50),
                                color: AppColors.stone,
                              )
                                  : null,
                            ),
                            SizedBox(height: ScreenUtilHelper.height(8)),
                            GestureDetector(
                              onTap: () {
                                context.read<StaffFormBloc>().add(
                                  UploadProfilePhoto(),
                                );
                              },
                              child: Text(
                                'Upload Photo',
                                style: AppStyles.bodySmall.copyWith(color: AppColors.secondaryContrast,
                                  decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Personal Details',
                        style: AppStyles.heading.copyWith(color: AppColors.blackHighEmphasis),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtilHelper.width(8.0)),
                        child: Text(
                          'Inquiry Form',
                          style: AppStyles.small.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  _buildTopicContainer(
                    children: [
                      _buildTextField(
                        label: 'Name',
                        currentValue: staffData.name,
                        onChanged: (val) =>
                            context.read<StaffFormBloc>().add(NameChanged(val)),
                        hintText: 'Enter full name',
                      ),
                      _buildTextField(
                        label: 'Mobile Number',
                        currentValue: staffData.mobile,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(MobileChanged(val)),
                        hintText: 'Enter mobile number',
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: 'Email Id',
                        currentValue: staffData.email,
                        onChanged: (val) =>
                            context.read<StaffFormBloc>().add(EmailChanged(val)),
                        hintText: 'Enter email address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildDropdownField(
                        label: 'Department',
                        items: ['Kitchen', 'Teaching', 'Admin', 'Transport'],
                        currentValue: staffData.department,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(DepartmentChanged(val)),
                      ),
                      _buildDropdownField(
                        label: 'Academic Year',
                        items: ['2023 - 2024', '2024 - 2025', '2025 - 2026'],
                        currentValue: staffData.academicYear,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(AcademicYearChanged(val)),
                      ),
                      _buildTextField(
                        label: 'Permanent Address',
                        currentValue: staffData.address,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(PermanentAddressChanged(val)),
                        hintText: 'Enter permanent address',
                        maxLines: 3,
                      ),
                      _buildTextField(
                        label: 'Employee Type',
                        currentValue: staffData.type,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(EmployeeTypeChanged(val)),
                        hintText: 'e.g., Permanent, Contract',
                      ),
                      _buildTextField(
                        label: 'Highest Education',
                        currentValue: staffData.highestEducation ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(HighestEducationChanged(val)),
                        hintText: 'e.g., Bachelors, Masters',
                      ),
                      _buildTextField(
                        label: 'Grades / Percentage',
                        currentValue: staffData.grades ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(GradesChanged(val)),
                        hintText: 'Enter grades or percentage',
                      ),
                    ],
                  ),
                  Text(
                    'Documents',
                    style: AppStyles.heading.copyWith(color: AppColors.blackHighEmphasis),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  _buildTopicContainer(
                    children: [
                      _buildTextField(
                        label: 'Adhar Card Number',
                        currentValue: staffData.adharCardNumber ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(AdharCardNumberChanged(val)),
                        hintText: 'Enter Adhar number',
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        label: 'Pancard Number',
                        currentValue: staffData.pancardNumber ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(PancardNumberChanged(val)),
                        hintText: 'Enter Pancard number',
                      ),
                      _buildTextField(
                        label: 'Emergency Mobile Number',
                        currentValue: staffData.emergencyMobileNumber ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(EmergencyMobileNumberChanged(val)),
                        hintText: 'Enter emergency contact',
                        keyboardType: TextInputType.phone,
                      ),
                      Text(
                        'Upload ID Proof',
                        style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.blackHighEmphasis),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(6)),
                      _buildUploadButton(
                        'Upload',
                            () =>
                            context.read<StaffFormBloc>().add(UploadIdProof()),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                    ],
                  ),
                  Text(
                    'Salary Details',
                    style: AppStyles.heading.copyWith(color: AppColors.blackHighEmphasis),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  _buildTopicContainer(
                    children: [
                      _buildTextField(
                        label: 'Salary Amount',
                        currentValue: staffData.salaryAmount ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(SalaryAmountChanged(val)),
                        hintText: 'Enter salary amount',
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        label: 'PF Deduction',
                        currentValue: staffData.pfDeduction ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(PfDeductionChanged(val)),
                        hintText: 'Enter PF amount',
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        label: 'Bank account number',
                        currentValue: staffData.bankAccountNumber ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(BankAccountNumberChanged(val)),
                        hintText: 'Enter bank account number',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  Text(
                    'Admin Details',
                    style: AppStyles.heading.copyWith(color: AppColors.blackHighEmphasis),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  _buildTopicContainer(
                    children: [
                      _buildTextField(
                        label: 'Joining Date',
                        currentValue: staffData.joiningDate ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(JoiningDateChanged(val)),
                        hintText: 'DD/MM/YYYY',
                      ),
                      _buildTextField(
                        label: 'Reliving Date',
                        currentValue: staffData.relivingDate ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(RelivingDateChanged(val)),
                        hintText: 'DD/MM/YYYY',
                        isRequired: false,
                      ),
                      _buildDropdownField(
                        label: 'Verification',
                        items: ['Verified', 'Pending', 'Rejected'],
                        currentValue: staffData.status,
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(VerificationChanged(val)),
                      ),
                      _buildTextField(
                        label: 'Any Message',
                        currentValue: staffData.anyMessage ?? '',
                        onChanged: (val) => context
                            .read<StaffFormBloc>()
                            .add(AnyMessageChanged(val)),
                        hintText: 'Enter any message',
                        maxLines: 3,
                        isRequired: false,
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  if (state.status == StaffFormStatus.loading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Center(
                      child: SizedBox(
                        width: ScreenUtilHelper.width(150),
                        height: ScreenUtilHelper.height(50),
                        child: ElevatedButton(
                          onPressed: () => showAppConfirmationDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.tertiaryDarkest,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtilHelper.radius(8.0)),
                            ),
                            side: BorderSide(
                              color: AppColors.accent,
                              width: ScreenUtilHelper.width(1.5),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Submit',
                            style: AppStyles.bodyEmphasis,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: ScreenUtilHelper.height(40)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}