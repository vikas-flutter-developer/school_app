

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../bloc/mail_bloc.dart';
import '../models/mail_model.dart';
import 'common_widgets.dart'; // Make sure this file exists and contains `buildSectionTitle`
import '../../../../core/utils/screen_util_helper.dart'; // Import ScreenUtilHelper

class ScheduleTabWidget extends StatefulWidget {
  const ScheduleTabWidget({super.key});

  @override
  State<ScheduleTabWidget> createState() => _ScheduleTabWidgetState();
}

class _ScheduleTabWidgetState extends State<ScheduleTabWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _recipientGridScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MailBloc>().add(const RecipientTypeChanged('All'));
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    _recipientGridScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MailBloc, MailState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == FormStatus.success;
      },
      listener: (context, state) {
        showSuccessDialog(context, "Scheduled", state.sendVia);
        context.read<MailBloc>().add(const TitleChanged(''));
        context.read<MailBloc>().add(const MessageChanged(''));
        _titleController.clear();
        _messageController.clear();
      },
      builder: (context, state) {
        final bool showEmailField =
            state.sendVia == 'Email' ||
                state.recipientType == 'Teachers' ||
                state.recipientType == 'All';

        return SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(40)),
                child: buildSectionTitle('Recipients'),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(40)),
                child: _buildRecipientTypeDropdown(context, state),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),

              if (state.recipientType == 'Teachers')
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(40), bottom: ScreenUtilHelper.height(20)),
                  child: _buildDepartmentDropdown(context, state),
                ),

              if (state.recipientType == 'Parents') ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionTitle('Select Class'),
                            _buildClassDropdown(context, state),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.width(16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionTitle('Select Section'),
                            _buildSectionDropdown(context, state),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(20)),
              ],

              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(20)),
                child: buildSectionTitle('Send via'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildRadioOption(context, 'Email', state),
                    SizedBox(width: ScreenUtilHelper.width(150)),
                    _buildRadioOption(context, 'Text', state),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(7.9)),
                child: Row(
                  children: [
                    SizedBox(
                      width: ScreenUtilHelper.width(30),
                      height: ScreenUtilHelper.height(30),
                      child: Checkbox(
                        value: state.selectAll,
                        onChanged: (bool? value) {
                          context.read<MailBloc>().add(
                            SelectAllChanged(value ?? false),
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    Text(
                      "Select All",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(15),
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate,
                      ),
                    ),
                    const Spacer(flex: 1),
                    SizedBox(
                      width: ScreenUtilHelper.width(110),
                      height: ScreenUtilHelper.height(25),
                      child: TextField(
                        style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12)),
                        decoration: InputDecoration(
                          hintText: 'Search by name',
                          hintStyle: TextStyle(
                            color: AppColors.ash,
                            fontSize: ScreenUtilHelper.fontSize(12),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: ScreenUtilHelper.fontSize(16),
                            color: AppColors.ash,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: ScreenUtilHelper.width(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.ash),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.ash),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.info),
                          ),
                        ),
                      ),
                    ),
                    // --- FIX START ---
                    // Reduced the width of this SizedBox from 8 to 4 to prevent overflow.
                    SizedBox(width: ScreenUtilHelper.width(4)),
                    // --- FIX END ---
                    TextButton.icon(
                      icon: Icon(
                        Icons.person_add_alt_1,
                        size: ScreenUtilHelper.fontSize(18),
                        color: AppColors.info,
                      ),
                      label: Text(
                        'Add Recipient',
                        style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12), color: AppColors.info),
                      ),
                      onPressed: () {
                        print("Add Recipient button pressed (Schedule Tab)");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.info,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(8),
                          vertical: ScreenUtilHelper.height(4),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(10)),
              Center(child: _buildRecipientGrid()),
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(30)),
                child: Text(
                  "Choose date and time to schedule",
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: ScreenUtilHelper.fontSize(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(10)),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(30), bottom: ScreenUtilHelper.height(4)),
                child: Text(
                  "date",
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: ScreenUtilHelper.fontSize(11),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: state.selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      context.read<MailBloc>().add(DateChanged(picked));
                    }
                  },
                  child: Container(
                    width: ScreenUtilHelper.width(306),
                    height: ScreenUtilHelper.height(45),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
                    decoration: BoxDecoration(
                      color: AppColors.ivory,
                      border: Border.all(
                        color: AppColors.secondaryLighter,
                        width: ScreenUtilHelper.width(1),
                      ),
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: ScreenUtilHelper.fontSize(20),
                          color: AppColors.stone,
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Text(
                          DateFormat('dd-MM-yyyy').format(state.selectedDate),
                          style: TextStyle(
                            color: AppColors.charcoal,
                            fontSize: ScreenUtilHelper.fontSize(11),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(15)),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(30), bottom: ScreenUtilHelper.height(4)),
                child: Text(
                  "Time",
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: ScreenUtilHelper.fontSize(11),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: state.selectedTime,
                    );
                    if (picked != null) {
                      context.read<MailBloc>().add(TimeChanged(picked));
                    }
                  },
                  child: Container(
                    width: ScreenUtilHelper.width(306),
                    height: ScreenUtilHelper.height(45),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
                    decoration: BoxDecoration(
                      color: AppColors.ivory,
                      border: Border.all(
                        color: AppColors.secondaryLighter,
                        width: ScreenUtilHelper.width(1),
                      ),
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: ScreenUtilHelper.fontSize(20),
                          color: AppColors.stone,
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Text(
                          state.selectedTime.format(context),
                          style: TextStyle(
                            color: AppColors.charcoal,
                            fontSize: ScreenUtilHelper.fontSize(11),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)),
                child: buildSectionTitle('Title'),
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtilHelper.height(51),
                child: TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    context.read<MailBloc>().add(TitleChanged(value));
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      borderSide: const BorderSide(color: AppColors.info),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(12),
                      vertical: ScreenUtilHelper.height(10),
                    ),
                  ),
                ),
              ),

              if (showEmailField) ...[
                SizedBox(height: ScreenUtilHelper.height(20)),
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)),
                  child: buildSectionTitle('Email'),
                ),
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtilHelper.height(51),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                        borderSide: const BorderSide(color: AppColors.ash),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                        borderSide: const BorderSide(color: AppColors.ash),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                        borderSide: const BorderSide(color: AppColors.info),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                        vertical: ScreenUtilHelper.height(10),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)),
                child: buildSectionTitle('Message'),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.ash),
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(8),
                        vertical: ScreenUtilHelper.height(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              print("Add Template pressed (Schedule)");
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.parchment,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5)),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.width(12),
                                vertical: ScreenUtilHelper.height(6),
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Add Template',
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.fontSize(12),
                                color: AppColors.blackHighEmphasis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.ash),
                    _buildFormattingToolbar(),
                    _buildFormattingToolbarRow2(),
                    TextField(
                      controller: _messageController,
                      onChanged: (value) {
                        context.read<MailBloc>().add(MessageChanged(value));
                      },
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(30)),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final scheduledDateTime = DateTime(
                      state.selectedDate.year,
                      state.selectedDate.month,
                      state.selectedDate.day,
                      state.selectedTime.hour,
                      state.selectedTime.minute,
                    );
                    if (scheduledDateTime.isBefore(now)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Cannot schedule message for a past date/time. Please select a future time.",
                            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                          ),
                          backgroundColor: AppColors.error,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      return;
                    }
                    context.read<MailBloc>().add(const ScheduleMessage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarker,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(14)),
                  ),
                  child: Text('Schedule', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16))),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecipientTypeDropdown(BuildContext context, MailState state) {
    return SizedBox(
      width: ScreenUtilHelper.width(293),
      height: ScreenUtilHelper.height(51),
      child: DropdownButtonFormField<String>(
        value: state.recipientType,
        items: MessageData.recipientTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          context.read<MailBloc>().add(RecipientTypeChanged(value));
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.info),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
        isExpanded: true,
        dropdownColor: AppColors.white,
        menuMaxHeight: ScreenUtilHelper.height(200),
      ),
    );
  }

  Widget _buildDepartmentDropdown(BuildContext context, MailState state) {
    return SizedBox(
      width: ScreenUtilHelper.width(293),
      height: ScreenUtilHelper.height(51),
      child: DropdownButtonFormField<String>(
        value: state.selectedDepartment,
        hint: Text(
          'Select Department',
          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
        ),
        items: MessageData.departments.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          context.read<MailBloc>().add(DepartmentChanged(value));
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.info),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
        isExpanded: true,
        dropdownColor: AppColors.white,
        menuMaxHeight: ScreenUtilHelper.height(200),
      ),
    );
  }

  Widget _buildClassDropdown(BuildContext context, MailState state) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtilHelper.height(51),
      child: DropdownButtonFormField<String>(
        value: state.selectedClass,
        items: MessageData.classes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          context.read<MailBloc>().add(ClassChanged(value));
        },
        decoration: InputDecoration(
          hintText: 'Select Class',
          hintStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.info),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
        isExpanded: true,
        dropdownColor: AppColors.white,
        menuMaxHeight: ScreenUtilHelper.height(200),
      ),
    );
  }

  Widget _buildSectionDropdown(BuildContext context, MailState state) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtilHelper.height(51),
      child: DropdownButtonFormField<String>(
        value: state.selectedSection,
        items: MessageData.sections.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          context.read<MailBloc>().add(SectionChanged(value));
        },
        decoration: InputDecoration(
          hintText: 'Select Section',
          hintStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
            borderSide: const BorderSide(color: AppColors.info),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
        isExpanded: true,
        dropdownColor: AppColors.white,
        menuMaxHeight: ScreenUtilHelper.height(200),
      ),
    );
  }

  Widget _buildRadioOption(
      BuildContext context,
      String value,
      MailState state,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: state.sendVia,
          onChanged: (newValue) {
            context.read<MailBloc>().add(SendViaChanged(newValue!));
          },
          activeColor: AppColors.tertiaryAccent,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        GestureDetector(
          onTap: () {
            context.read<MailBloc>().add(SendViaChanged(value));
          },
          child: Text(
            value,
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(15),
              fontWeight: FontWeight.w600,
              color: AppColors.slate,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientGrid() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: ScreenUtilHelper.height(120)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cloud),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
      ),
      child: Scrollbar(
        controller: _recipientGridScrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _recipientGridScrollController,
          padding: EdgeInsets.all(ScreenUtilHelper.width(8)),
          child: Wrap(
            spacing: ScreenUtilHelper.width(8),
            runSpacing: ScreenUtilHelper.height(8),
            children: MessageData.getRecipients().map((recipient) {
              return Container(
                width: ScreenUtilHelper.width(74),
                height: ScreenUtilHelper.height(33),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(4),
                  vertical: ScreenUtilHelper.height(2),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
                  border: Border.all(
                    color: AppColors.silver,
                    width: ScreenUtilHelper.width(0.5),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      recipient.name,
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(9),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: ScreenUtilHelper.height(1)),
                    Text(
                      recipient.number,
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(7),
                        fontWeight: FontWeight.w400,
                        color: AppColors.ash,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ✅ ADDED: The missing _buildFormattingToolbar method.
  Widget _buildFormattingToolbar() {
    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8), vertical: ScreenUtilHelper.height(4)),
      child: Row(
        children: [
          _buildToolbarButton(Icons.format_bold, () {
            print("Bold button pressed");
          }),
          _buildToolbarButton(Icons.format_italic, () {
            print("Italic button pressed");
          }),
          _buildToolbarButton(Icons.format_underline, () {
            print("Underline button pressed");
          }),
          _buildToolbarButton(Icons.format_color_text, () {
            print("Text color button pressed");
          }),
          _buildToolbarButton(Icons.format_align_left, () {
            print("Align left button pressed");
          }),
          _buildToolbarButton(Icons.format_align_center, () {
            print("Align center button pressed");
          }),
          _buildToolbarButton(Icons.format_align_right, () {
            print("Align right button pressed");
          }),
          _buildToolbarButton(Icons.list, () {
            print("List button pressed");
          }),
          const Spacer(),
          _buildToolbarButton(Icons.attach_file, () {
            print("Attach file button pressed");
          }),
          SizedBox(width: ScreenUtilHelper.width(4)),
        ],
      ),
    );
  }

  // ✅ ADDED: The missing _buildFormattingToolbarRow2 method.
  Widget _buildFormattingToolbarRow2() {
    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8), vertical: ScreenUtilHelper.height(4)),
      child: Row(
        children: [
          _buildToolbarButton(Icons.font_download_outlined, () {
            print("Font button pressed");
          }),
          SizedBox(width: ScreenUtilHelper.width(4)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.silver),
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
            ),
            child: Row(
              children: [
                Text(
                  "12",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(12),
                    color: AppColors.charcoal,
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(4)),
                Icon(
                  Icons.arrow_drop_down,
                  size: ScreenUtilHelper.fontSize(16),
                  color: AppColors.charcoal,
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
          _buildToolbarButton(Icons.format_underline, () {
            print("Underline button pressed");
          }),
          _buildToolbarButton(Icons.text_fields, () {
            print("Text fields button pressed");
          }),
          _buildToolbarButton(Icons.superscript, () {
            print("Superscript button pressed");
          }),
          const Spacer(),
          _buildToolbarButton(Icons.horizontal_rule_sharp, () {
            print("Horizontal rule button pressed");
          }),
          _buildToolbarButton(Icons.link, () {
            print("Link button pressed");
          }),
        ],
      ),
    );
  }

  // ✅ ADDED: A helper for building consistent toolbar buttons.
  Widget _buildToolbarButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.width(4)),
        child: Icon(
          icon,
          size: ScreenUtilHelper.fontSize(18),
          color: AppColors.slate,
        ),
      ),
    );
  }
}