import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assume these are your actual paths
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ✅ RESPONSIVE: Import the helper
import '../bloc/message_bloc.dart';
import '../models/message_model.dart'; // For MessageData and Recipient
import 'common_widgets.dart'; // For buildSectionTitle, showSuccessDialog, buildToolbarIcon

class SmsTabWidget extends StatefulWidget {
  const SmsTabWidget({super.key});

  @override
  State<SmsTabWidget> createState() => _SmsTabWidgetState();
}

class _SmsTabWidgetState extends State<SmsTabWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _recipientGridScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentState = context.read<MessageBloc>().state;
        if (currentState.recipientType != 'Parents') {
          context.read<MessageBloc>().add(
            const RecipientTypeChanged('Parents'),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _searchController.dispose();
    _recipientGridScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ RESPONSIVE: Initialize the helper at the start of the build method
    ScreenUtilHelper.init(context);

    return BlocConsumer<MessageBloc, MessageState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == FormStatus.success;
      },
      listener: (context, state) {
        showSuccessDialog(
          context,
          "Sent",
          state.sendVia,
        );
        context.read<MessageBloc>().add(const TitleChanged(''));
        context.read<MessageBloc>().add(const MessageChanged(''));
        _titleController.clear();
        _messageController.clear();
        _emailController.clear();
        _searchController.clear();
      },
      builder: (context, state) {
        if (_titleController.text != state.title) {
          _titleController.text = state.title;
          _titleController.selection = TextSelection.fromPosition(
            TextPosition(offset: _titleController.text.length),
          );
        }
        if (_messageController.text != state.message) {
          _messageController.text = state.message;
          _messageController.selection = TextSelection.fromPosition(
            TextPosition(offset: _messageController.text.length),
          );
        }

        final bool showEmailFieldBasedOnSendViaOrType =
            state.sendVia == 'Email' ||
                state.recipientType == 'Teachers' ||
                state.recipientType == 'All';

        return SingleChildScrollView(
          // RESPONSIVE:
          padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // RESPONSIVE:
                padding:
                EdgeInsets.only(left: ScreenUtilHelper.width(40.0)),
                child: buildSectionTitle('Recipients'),
              ),
              Padding(
                // RESPONSIVE:
                padding:
                EdgeInsets.only(left: ScreenUtilHelper.width(40.0)),
                child: _buildRecipientTypeDropdown(context, state),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(20)),

              if (state.recipientType == 'Teachers')
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(
                    left: ScreenUtilHelper.width(40.0),
                    bottom: ScreenUtilHelper.height(20.0),
                  ),
                  child: _buildDepartmentDropdown(context, state),
                ),

              if (state.recipientType == 'Parents')
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(20.0)),
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
                      // RESPONSIVE:
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
              // RESPONSIVE:
              if (state.recipientType == 'Parents')
                SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                // RESPONSIVE:
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                child: buildSectionTitle('Send via'),
              ),
              Padding(
                // RESPONSIVE:
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(20.0)),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildRadioOption(
                        context,
                        'Email',
                        state.sendVia,
                            (val) => context.read<MessageBloc>().add(
                          SendViaChanged(val),
                        ),
                      ),
                    ),
                    // RESPONSIVE:
                    SizedBox(width: ScreenUtilHelper.width(150)),
                    Expanded(
                      child: _buildRadioOption(
                        context,
                        'Text',
                        state.sendVia,
                            (val) => context.read<MessageBloc>().add(
                          SendViaChanged(val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                // RESPONSIVE:
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(8.0)),
                // child: Row(
                //   children: [
                //     SizedBox(
                //       // RESPONSIVE:
                //       width: ScreenUtilHelper.width(30),
                //       height: ScreenUtilHelper.height(30),
                //       child: Checkbox(
                //         value: state.selectAll,
                //         onChanged: (bool? value) {
                //           context.read<MessageBloc>().add(
                //             SelectAllChanged(value ?? false),
                //           );
                //         },
                //         visualDensity: VisualDensity.compact,
                //         materialTapTargetSize:
                //         MaterialTapTargetSize.shrinkWrap,
                //       ),
                //     ),
                //     Text(
                //       "Select All",
                //       style: TextStyle(
                //         // RESPONSIVE:
                //         fontSize: ScreenUtilHelper.fontSize(15),
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.slate,
                //       ),
                //     ),
                //     const Spacer(flex: 1),
                //     SizedBox(
                //       // RESPONSIVE:
                //       width: ScreenUtilHelper.width(110),
                //       height: ScreenUtilHelper.height(25),
                //       child: TextField(
                //         controller: _searchController,
                //         // RESPONSIVE:
                //         style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12)),
                //         decoration: InputDecoration(
                //           hintText: 'Search by name',
                //           hintStyle: TextStyle(
                //             color: AppColors.ash,
                //             // RESPONSIVE:
                //             fontSize: ScreenUtilHelper.fontSize(12),
                //           ),
                //           prefixIcon: Icon(
                //             Icons.search,
                //             // RESPONSIVE: Using scaleAll for icons maintains aspect ratio
                //             size: ScreenUtilHelper.scaleAll(16),
                //             color: AppColors.ash,
                //           ),
                //           // RESPONSIVE:
                //           prefixIconConstraints: BoxConstraints(
                //             minWidth: ScreenUtilHelper.width(30),
                //           ),
                //           contentPadding: EdgeInsets.zero,
                //           border: OutlineInputBorder(
                //             // RESPONSIVE:
                //             borderRadius: BorderRadius.circular(
                //                 ScreenUtilHelper.radius(6.0)),
                //             borderSide:
                //             const BorderSide(color: AppColors.ash),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             // RESPONSIVE:
                //             borderRadius: BorderRadius.circular(
                //                 ScreenUtilHelper.radius(6.0)),
                //             borderSide:
                //             const BorderSide(color: AppColors.ash),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             // RESPONSIVE:
                //             borderRadius: BorderRadius.circular(
                //                 ScreenUtilHelper.radius(6.0)),
                //             borderSide:
                //             const BorderSide(color: AppColors.info),
                //           ),
                //         ),
                //         onChanged: (searchTerm) {
                //           // context.read<MessageBloc>().add(SearchRecipientsEvent(searchTerm));
                //         },
                //       ),
                //     ),
                //     // RESPONSIVE:
                //     SizedBox(width: ScreenUtilHelper.width(8)),
                //     TextButton.icon(
                //       icon: Icon(
                //         Icons.person_add_alt_1,
                //         // RESPONSIVE:
                //         size: ScreenUtilHelper.scaleAll(18),
                //         color: AppColors.info,
                //       ),
                //       label: Text(
                //         'Add Recipient',
                //         // RESPONSIVE:
                //         style: TextStyle(
                //             fontSize: ScreenUtilHelper.fontSize(12),
                //             color: AppColors.info),
                //       ),
                //       onPressed: () {
                //         print("Add Recipient button pressed");
                //       },
                //       style: TextButton.styleFrom(
                //         foregroundColor: AppColors.info,
                //         // RESPONSIVE:
                //         padding: EdgeInsets.symmetric(
                //           horizontal: ScreenUtilHelper.width(8),
                //           vertical: ScreenUtilHelper.height(4),
                //         ),
                //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //         shape: RoundedRectangleBorder(
                //           // RESPONSIVE:
                //           borderRadius: BorderRadius.circular(
                //               ScreenUtilHelper.radius(6.0)),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                child: Row(
                  children: [
                    SizedBox(
                      // RESPONSIVE:
                      width: ScreenUtilHelper.width(30),
                      height: ScreenUtilHelper.height(30),
                      child: Checkbox(
                        value: state.selectAll,
                        onChanged: (bool? value) {
                          context.read<MessageBloc>().add(
                            SelectAllChanged(value ?? false),
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    Text(
                      "Select All",
                      style: TextStyle(
                        // RESPONSIVE:
                        fontSize: ScreenUtilHelper.fontSize(15),
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate,
                      ),
                    ),
                    const Spacer(flex: 1),
                    SizedBox(
                      // RESPONSIVE:
                      width: ScreenUtilHelper.width(110),
                      height: ScreenUtilHelper.height(25),
                      child: TextField(
                        controller: _searchController,
                        // RESPONSIVE:
                        style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12)),
                        decoration: InputDecoration(
                          hintText: 'Search by name',
                          hintStyle: TextStyle(
                            color: AppColors.ash,
                            // RESPONSIVE:
                            fontSize: ScreenUtilHelper.fontSize(12),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            // RESPONSIVE: Using scaleAll for icons maintains aspect ratio
                            size: ScreenUtilHelper.scaleAll(16),
                            color: AppColors.ash,
                          ),
                          // RESPONSIVE:
                          prefixIconConstraints: BoxConstraints(
                            minWidth: ScreenUtilHelper.width(30),
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            // RESPONSIVE:
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(6.0)),
                            borderSide:
                            const BorderSide(color: AppColors.ash),
                          ),
                          enabledBorder: OutlineInputBorder(
                            // RESPONSIVE:
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(6.0)),
                            borderSide:
                            const BorderSide(color: AppColors.ash),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // RESPONSIVE:
                            borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(6.0)),
                            borderSide:
                            const BorderSide(color: AppColors.info),
                          ),
                        ),
                        onChanged: (searchTerm) {
                          // context.read<MessageBloc>().add(SearchRecipientsEvent(searchTerm));
                        },
                      ),
                    ),
                    // --- FIX START ---
                    // Overflow ko fix karne ke liye yahan space 8 se 4 kar diya gaya hai.
                    // The space here was reduced from 8 to 4 to fix the overflow.
                    SizedBox(width: ScreenUtilHelper.width(4)),
                    // --- FIX END ---
                    TextButton.icon(
                      icon: Icon(
                        Icons.person_add_alt_1,
                        // RESPONSIVE:
                        size: ScreenUtilHelper.scaleAll(18),
                        color: AppColors.info,
                      ),
                      label: Text(
                        'Add Recipient',
                        // RESPONSIVE:
                        style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(12),
                            color: AppColors.info),
                      ),
                      onPressed: () {
                        print("Add Recipient button pressed");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.info,
                        // RESPONSIVE:
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(8),
                          vertical: ScreenUtilHelper.height(4),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          // RESPONSIVE:
                          borderRadius: BorderRadius.circular(
                              ScreenUtilHelper.radius(6.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(10)),
              Center(child: _buildRecipientGrid(context, state)),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(20)),

              Padding(
                // RESPONSIVE:
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(8.0)),
                child: buildSectionTitle('Title'),
              ),
              TextField(
                controller: _titleController,
                onChanged: (value) =>
                    context.read<MessageBloc>().add(TitleChanged(value)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    // RESPONSIVE:
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                    borderSide: const BorderSide(color: AppColors.ash),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // RESPONSIVE:
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                    borderSide: const BorderSide(color: AppColors.ash),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // RESPONSIVE:
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                    borderSide: const BorderSide(color: AppColors.info),
                  ),
                  // RESPONSIVE:
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(12),
                    vertical: ScreenUtilHelper.height(15),
                  ),
                ),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(20)),

              if (showEmailFieldBasedOnSendViaOrType &&
                  state.recipientType ==
                      'SomeSpecificTypeRequiringDirectEmailInput') ...[
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(8.0)),
                  child: buildSectionTitle(
                    'Recipient Email (if specific case)',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  onChanged: (value) {
                    // context.read<MessageBloc>().add(DirectEmailChanged(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter specific email address',
                    border: OutlineInputBorder(
                      // RESPONSIVE:
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // RESPONSIVE:
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                      borderSide: const BorderSide(color: AppColors.ash),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // RESPONSIVE:
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                      borderSide: const BorderSide(color: AppColors.info),
                    ),
                    // RESPONSIVE:
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(12),
                      vertical: ScreenUtilHelper.height(15),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
              ],

              Padding(
                // RESPONSIVE:
                padding: EdgeInsets.only(left: ScreenUtilHelper.width(8.0)),
                child: buildSectionTitle('Message'),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.ash),
                  // RESPONSIVE:
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      // RESPONSIVE:
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(8.0),
                        vertical: ScreenUtilHelper.height(4.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () =>
                                print("Add Template button pressed"),
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.parchment,
                              shape: RoundedRectangleBorder(
                                // RESPONSIVE:
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(5)),
                              ),
                              // RESPONSIVE:
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilHelper.width(12),
                                vertical: ScreenUtilHelper.height(6),
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Add Template',
                              style: TextStyle(
                                // RESPONSIVE:
                                fontSize: ScreenUtilHelper.fontSize(12),
                                color: AppColors.blackHighEmphasis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // RESPONSIVE:
                    Divider(
                        height: ScreenUtilHelper.height(1),
                        color: AppColors.ash),
                    _buildFormattingToolbar(),
                    _buildFormattingToolbarRow2(),
                    TextField(
                      controller: _messageController,
                      onChanged: (value) =>
                          context.read<MessageBloc>().add(
                            MessageChanged(value),
                          ),
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                        // RESPONSIVE:
                        contentPadding:
                        EdgeInsets.all(ScreenUtilHelper.width(12.0)),
                      ),
                    ),
                  ],
                ),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(30)),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.status != FormStatus.submitting
                      ? () => context.read<MessageBloc>().add(
                    const SendMessage(),
                  )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarkest,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.silver,
                    shape: RoundedRectangleBorder(
                      // RESPONSIVE:
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                    ),
                    // RESPONSIVE:
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.height(14.0)),
                  ),
                  child: state.status == FormStatus.submitting
                      ? SizedBox(
                    // RESPONSIVE:
                    width: ScreenUtilHelper.width(20),
                    height: ScreenUtilHelper.height(20),
                    child: const CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 3,
                    ),
                  )
                      : Text('Send',
                      // RESPONSIVE:
                      style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(16))),
                ),
              ),
              // RESPONSIVE:
              SizedBox(height: ScreenUtilHelper.height(20)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown<T>({
    required BuildContext context,
    required String? currentValue,
    required List<String> items,
    required String hintText,
    required Function(String?) onChanged,
  }) {
    String? validValue = currentValue;
    if (currentValue != null && !items.contains(currentValue)) {
      print(
        "Warning: Dropdown value '$currentValue' for hint '$hintText' is not in items list. Resetting to null.",
      );
      validValue = null;
    }

    return DropdownButtonFormField<String>(
      value: validValue,
      hint: Text(
        hintText,
        // RESPONSIVE:
        style: TextStyle(
            fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.ash),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              // RESPONSIVE:
              fontSize: ScreenUtilHelper.fontSize(15),
              fontWeight: FontWeight.w600,
              color: AppColors.slate,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          // RESPONSIVE:
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          // RESPONSIVE:
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          // RESPONSIVE:
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          borderSide: const BorderSide(color: AppColors.info),
        ),
        // RESPONSIVE:
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(12),
          vertical: ScreenUtilHelper.height(15),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
      isExpanded: true,
      dropdownColor: AppColors.white,
      // RESPONSIVE:
      menuMaxHeight: ScreenUtilHelper.height(200),
    );
  }

  Widget _buildRecipientTypeDropdown(BuildContext context, MessageState state) {
    return SizedBox(
      // RESPONSIVE:
      width: ScreenUtilHelper.width(293.0),
      child: _buildDropdown(
        context: context,
        currentValue: state.recipientType,
        items: MessageData.recipientTypes,
        hintText: 'Select Recipient Type',
        onChanged: (value) {
          if (value != null) {
            context.read<MessageBloc>().add(RecipientTypeChanged(value));
          }
        },
      ),
    );
  }

  Widget _buildDepartmentDropdown(BuildContext context, MessageState state) {
    return Center(
      child: SizedBox(
        // RESPONSIVE:
        width: ScreenUtilHelper.width(161.0),
        child: _buildDropdown(
          context: context,
          currentValue: state.selectedDepartment,
          items: MessageData.departments,
          hintText: 'Select Department',
          onChanged: (value) =>
              context.read<MessageBloc>().add(DepartmentChanged(value)),
        ),
      ),
    );
  }

  Widget _buildClassDropdown(BuildContext context, MessageState state) {
    return _buildDropdown(
      context: context,
      currentValue: state.selectedClass,
      items: MessageData.classes,
      hintText: 'Select Class',
      onChanged: (value) =>
          context.read<MessageBloc>().add(ClassChanged(value)),
    );
  }

  Widget _buildSectionDropdown(BuildContext context, MessageState state) {
    return _buildDropdown(
      context: context,
      currentValue: state.selectedSection,
      items: MessageData.sections,
      hintText: 'Select Section',
      onChanged: (value) =>
          context.read<MessageBloc>().add(SectionChanged(value)),
    );
  }

  Widget _buildRadioOption(
      BuildContext context,
      String value,
      String groupValue,
      ValueChanged<String> onChanged,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
          activeColor: AppColors.tertiaryAccent,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () => onChanged(value),
            child: Text(
              value,
              style: TextStyle(
                // RESPONSIVE:
                fontSize: ScreenUtilHelper.fontSize(15),
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientGrid(BuildContext context, MessageState state) {
    final recipients = MessageData.getRecipients();

    if (recipients.isEmpty) {
      return Container(
        width: double.infinity,
        // RESPONSIVE:
        constraints: BoxConstraints(
            minHeight: ScreenUtilHelper.height(50),
            maxHeight: ScreenUtilHelper.height(120)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cloud),
          // RESPONSIVE:
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
        ),
        // RESPONSIVE:
        padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
        child: const Center(
          child: Text(
            'No recipients to display.',
            style: TextStyle(color: AppColors.ash),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      // RESPONSIVE:
      constraints: BoxConstraints(maxHeight: ScreenUtilHelper.height(120)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cloud),
        // RESPONSIVE:
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
      ),
      child: Scrollbar(
        controller: _recipientGridScrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _recipientGridScrollController,
          // RESPONSIVE:
          padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
          child: Wrap(
            // RESPONSIVE:
            spacing: ScreenUtilHelper.width(8.0),
            runSpacing: ScreenUtilHelper.height(8.0),
            children: recipients.map((recipient) {
              return InkWell(
                onTap: () {
                  // context.read<MessageBloc>().add(ToggleRecipientSelection(recipient.id));
                },
                child: Container(
                  // RESPONSIVE:
                  width: ScreenUtilHelper.width(74),
                  height: ScreenUtilHelper.height(33),
                  // RESPONSIVE:
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(4),
                    vertical: ScreenUtilHelper.height(2),
                  ),
                  decoration: BoxDecoration(
                    // RESPONSIVE:
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(4.0)),
                    border: Border.all(
                      color: AppColors.silver,
                      // RESPONSIVE:
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
                          // RESPONSIVE:
                          fontSize: ScreenUtilHelper.fontSize(9),
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      // RESPONSIVE:
                      SizedBox(height: ScreenUtilHelper.height(1)),
                      Text(
                        recipient.number,
                        style: TextStyle(
                          // RESPONSIVE:
                          fontSize: ScreenUtilHelper.fontSize(9),
                          color: AppColors.slate,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildFormattingToolbar() {
    return Padding(
      // RESPONSIVE:
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(8.0),
        vertical: ScreenUtilHelper.height(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => print("Paragraph style pressed"),
                child: Container(
                  // RESPONSIVE:
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(8),
                    vertical: ScreenUtilHelper.height(4),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.cloud),
                    // RESPONSIVE:
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Paragraph',
                          // RESPONSIVE:
                          style: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(12))),
                      // RESPONSIVE:
                      SizedBox(width: ScreenUtilHelper.width(4)),
                      Icon(Icons.keyboard_arrow_down,
                          // RESPONSIVE:
                          size: ScreenUtilHelper.scaleAll(16)),
                    ],
                  ),
                ),
              ),
              // RESPONSIVE:
              SizedBox(width: ScreenUtilHelper.width(10)),
              buildToolbarIcon(
                Icons.format_align_left,
                    () => print("Align Left"),
              ),
              buildToolbarIcon(
                Icons.format_align_center,
                    () => print("Align Center"),
              ),
              buildToolbarIcon(
                Icons.format_align_right,
                    () => print("Align Right"),
              ),
            ],
          ),
          Row(
            children: [
              buildToolbarIcon(
                Icons.format_list_numbered,
                    () => print("Numbered List"),
              ),
              buildToolbarIcon(
                Icons.format_list_bulleted,
                    () => print("Bulleted List"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormattingToolbarRow2() {
    return Padding(
      // RESPONSIVE:
      padding: EdgeInsets.fromLTRB(ScreenUtilHelper.width(8.0), 0,
          ScreenUtilHelper.width(8.0), ScreenUtilHelper.height(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              buildToolbarIcon(
                Icons.format_color_text,
                    () => print("Text Color"),
              ),
              buildToolbarIcon(
                Icons.format_color_fill,
                    () => print("Fill Color"),
              ),
              buildToolbarIcon(Icons.format_bold, () => print("Bold")),
              buildToolbarIcon(Icons.format_italic, () => print("Italic")),
              buildToolbarIcon(
                Icons.format_underline,
                    () => print("Underline"),
              ),
              buildToolbarIcon(
                Icons.format_strikethrough,
                    () => print("Strikethrough"),
              ),
            ],
          ),
          Row(
            children: [
              buildToolbarIcon(Icons.link, () => print("Link")),
              buildToolbarIcon(Icons.image_outlined, () => print("Image")),
            ],
          ),
        ],
      ),
    );
  }
}