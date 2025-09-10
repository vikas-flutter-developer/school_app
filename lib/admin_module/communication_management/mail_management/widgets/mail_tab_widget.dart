import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/mail_bloc.dart';
import '../models/mail_model.dart';
import 'common_widgets.dart';

// Main Widget
class MailTabWidget extends StatefulWidget {
  const MailTabWidget({super.key});

  @override
  State<MailTabWidget> createState() => _MailTabWidgetState();
}

// State Class for the Widget

class _MailTabWidgetState extends State<MailTabWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
    _emailController.dispose();
    _messageController.dispose();
    _recipientGridScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocConsumer<MailBloc, MailState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          current.status == FormStatus.success,
      listener: (context, state) {
        showSuccessDialog(context, "Sent", state.sendVia);
        context.read<MailBloc>().add(const TitleChanged(''));
        context.read<MailBloc>().add(const MessageChanged(''));
        _titleController.clear();
        _messageController.clear();
        _emailController.clear();
      },
      builder: (context, state) {
        final bool showEmailField = state.sendVia == 'Email' ||
            state.recipientType == 'Teachers' ||
            state.recipientType == 'All';

        if (state.title.isEmpty && _titleController.text.isNotEmpty) {
          _titleController.text = '';
        }
        if (state.message.isEmpty && _messageController.text.isNotEmpty) {
          _messageController.text = '';
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Recipients
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(40)),
                child: buildSectionTitle('Recipients'),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(40)),
                child: _buildRecipientTypeDropdown(context, state),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),

              // Conditional Dropdowns
              if (state.recipientType == 'Teachers')
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtilHelper.width(40),
                    bottom: ScreenUtilHelper.height(20),
                  ),
                  child: _buildDepartmentDropdown(context, state),
                ),
              if (state.recipientType == 'Parents')
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(20)),
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

              // Section: Send via
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(20)),
                child: buildSectionTitle('Send via'),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
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

              // Section: Recipient Selection
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                child: Row(
                  children: [
                    SizedBox(
                      width: ScreenUtilHelper.width(30),
                      height: ScreenUtilHelper.height(30),
                      child: Checkbox(
                        value: state.selectAll,
                        onChanged: (bool? value) {
                          context
                              .read<MailBloc>()
                              .add(SelectAllChanged(value ?? false));
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
                        style:
                        TextStyle(fontSize: ScreenUtilHelper.fontSize(12)),
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
                              horizontal: 0, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.ash),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.ash),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(ScreenUtilHelper.radius(6)),
                            borderSide: const BorderSide(color: AppColors.info),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.width(4)),
                    TextButton.icon(
                      icon: Icon(
                        Icons.person_add_alt_1,
                        size: ScreenUtilHelper.fontSize(18),
                        color: AppColors.info,
                      ),
                      label: Text(
                        'Add Recipient',
                        style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(12),
                            color: AppColors.info),
                      ),
                      onPressed: () {
                        print("Add Recipient button pressed (Mail Tab)");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.info,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(8),
                          vertical: ScreenUtilHelper.height(4),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(ScreenUtilHelper.radius(6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(10)),
              Center(child: _buildRecipientGrid()),
              SizedBox(height: ScreenUtilHelper.height(20)),

              // Section: Title
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
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(8)),
                        borderSide: const BorderSide(color: AppColors.ash),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(8)),
                        borderSide: const BorderSide(color: AppColors.ash),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(8)),
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

              // Section: Message
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
                              print("Add Template pressed (Mail)");
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.parchment,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(5)),
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
                        contentPadding:
                        EdgeInsets.all(ScreenUtilHelper.width(12)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(30)),

              // Section: Final Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MailBloc>().add(const SendMessage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarker,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.height(14)),
                  ),
                  child: Text('Send',
                      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16))),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),
            ],
          ),
        );
      },
    );
  }

  //---------------------------------------------------------
  // Helper methods for building UI parts
  //---------------------------------------------------------

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
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.radius(4)),
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

  Widget _buildFormattingToolbar() {
    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(8),
          vertical: ScreenUtilHelper.height(4)),
      child: Row(
        children: [
          _buildToolbarButton(Icons.format_bold, () {}),
          _buildToolbarButton(Icons.format_italic, () {}),
          _buildToolbarButton(Icons.format_underline, () {}),
          _buildToolbarButton(Icons.format_color_text, () {}),
          _buildToolbarButton(Icons.format_align_left, () {}),
          _buildToolbarButton(Icons.format_align_center, () {}),
          _buildToolbarButton(Icons.format_align_right, () {}),
          _buildToolbarButton(Icons.list, () {}),
          const Spacer(),
          _buildToolbarButton(Icons.attach_file, () {}),
          SizedBox(width: ScreenUtilHelper.width(4)),
        ],
      ),
    );
  }

  Widget _buildFormattingToolbarRow2() {
    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(8),
          vertical: ScreenUtilHelper.height(4)),
      child: Row(
        children: [
          _buildToolbarButton(Icons.font_download_outlined, () {}),
          SizedBox(width: ScreenUtilHelper.width(4)),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
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
          _buildToolbarButton(Icons.format_underline, () {}),
          _buildToolbarButton(Icons.text_fields, () {}),
          _buildToolbarButton(Icons.superscript, () {}),
          const Spacer(),
          _buildToolbarButton(Icons.horizontal_rule_sharp, () {}),
          _buildToolbarButton(Icons.link, () {}),
        ],
      ),
    );
  }

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


// Top-Level Helper Functions (Outside the class)

Widget _buildRecipientTypeDropdown(BuildContext context, MailState state) {
  return SizedBox(
    width: ScreenUtilHelper.width(293.0),
    height: ScreenUtilHelper.height(51.0),
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
        context.read<MailBloc>().add(RecipientTypeChanged(value!));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
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
      menuMaxHeight: 200,
    ),
  );
}

Widget _buildDepartmentDropdown(BuildContext context, MailState state) {
  return Center(
    child: SizedBox(
      width: ScreenUtilHelper.width(293.0),
      height: ScreenUtilHelper.height(51.0),
      child: DropdownButtonFormField<String>(
        value: state.selectedDepartment,
        hint: Text(
          'Select Department',
          style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
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
          context.read<MailBloc>().add(DepartmentChanged(value!));
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            borderSide: const BorderSide(color: AppColors.ash),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
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
        menuMaxHeight: 200,
      ),
    ),
  );
}

Widget _buildClassDropdown(BuildContext context, MailState state) {
  return SizedBox(
    width: double.infinity,
    height: ScreenUtilHelper.height(51.0),
    child: DropdownButtonFormField<String>(
      value: state.selectedClass,
      hint: Text(
        'Select Class',
        style: TextStyle(
            fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
      ),
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
        context.read<MailBloc>().add(ClassChanged(value!));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
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
      menuMaxHeight: 200,
    ),
  );
}

Widget _buildSectionDropdown(BuildContext context, MailState state) {
  return SizedBox(
    width: double.infinity,
    height: ScreenUtilHelper.height(51.0),
    child: DropdownButtonFormField<String>(
      value: state.selectedSection,
      hint: Text(
        'Select Section',
        style: TextStyle(
            fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
      ),
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
        context.read<MailBloc>().add(SectionChanged(value!));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
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
      menuMaxHeight: 200,
    ),
  );
}

Widget _buildRadioOption(BuildContext context, String value, MailState state) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<String>(
        value: value,
        groupValue: state.sendVia,
        onChanged: (newValue) {
          if (newValue != null) {
            context.read<MailBloc>().add(SendViaChanged(newValue));
          }
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