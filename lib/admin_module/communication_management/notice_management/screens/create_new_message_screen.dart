import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
// RESPONSIVE: Import the screen utility helper
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/notice/notice_bloc.dart';
import '../model/notice_model.dart';
import '../widgets/success_dialog_content.dart';

class CreateNewMesage extends StatefulWidget {
  const CreateNewMesage({super.key});

  @override
  State<CreateNewMesage> createState() => _CreateNewMesageState();
}

class _CreateNewMesageState extends State<CreateNewMesage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _recipientGridScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _recipientGridScrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            // RESPONSIVE:
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10.0)),
          ),
          // RESPONSIVE:
          insetPadding: EdgeInsets.all(ScreenUtilHelper.width(10)),
          child: SuccessDialogContent(isPublish: true),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // RESPONSIVE: Initialize the helper at the start of the build method
    ScreenUtilHelper.init(context);

    return BlocBuilder<NoticeBloc, NoticeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const MessageScreen(),
          ),
          body: SingleChildScrollView(
            // RESPONSIVE:
            padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buildSectionTitle('Recipients')],
                  ),
                ),
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                  child: SizedBox(
                    // RESPONSIVE:
                    width: ScreenUtilHelper.width(363.0),
                    height: ScreenUtilHelper.height(51.0),
                    child: _buildRecipientTypeDropdown(context, state),
                  ),
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                  child: _buildSectionTitle('Send via'),
                ),
                Padding(
                  // RESPONSIVE:
                  padding: EdgeInsets.only(left: ScreenUtilHelper.width(20.0)),
                  child: SizedBox(
                    // RESPONSIVE:
                    width: ScreenUtilHelper.width(363.0),
                    height: ScreenUtilHelper.height(51.0),
                    child: _buildSendViaDropdown(context, state),
                  ),
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
                Row(
                  children: [
                    SizedBox(
                      // RESPONSIVE:
                      width: ScreenUtilHelper.width(30),
                      height: ScreenUtilHelper.height(30),
                      child: Checkbox(
                        value: state.selectAll,
                        onChanged: (value) {
                          context.read<NoticeBloc>().add(
                            ToggleSelectAllRecipients(value ?? false),
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    // RESPONSIVE:
                    SizedBox(width: ScreenUtilHelper.width(10)),
                    SizedBox(
                      // RESPONSIVE:
                      width: ScreenUtilHelper.width(110),
                      height: ScreenUtilHelper.height(20),
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
                          contentPadding: EdgeInsets.symmetric(
                            // RESPONSIVE:
                            horizontal: ScreenUtilHelper.width(8),
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            // RESPONSIVE:
                            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
                            borderSide: const BorderSide(color: AppColors.info),
                          ),
                        ),
                        onChanged: (value) {
                          context.read<NoticeBloc>().add(
                            SearchRecipients(value),
                          );
                        },
                      ),
                    ),
                    // RESPONSIVE:
                    SizedBox(width: ScreenUtilHelper.width(8)),
                    TextButton.icon(
                      icon: Icon(Icons.person_add_alt_1, size: ScreenUtilHelper.scaleAll(18)), // RESPONSIVE
                      label: Text(
                        'Add Recipient',
                        // RESPONSIVE:
                        style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12)),
                      ),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        // RESPONSIVE:
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(8),
                          vertical: ScreenUtilHelper.height(4),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(10)),
                Center(child: _buildRecipientGrid(context, state)),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
                _buildSectionTitle('Title'),
                SizedBox(
                  width: double.infinity,
                  // RESPONSIVE:
                  height: ScreenUtilHelper.height(51.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
                if (state.shouldShowSubjectField) ...[
                  _buildSectionTitle('Subject'),
                  SizedBox(
                    // RESPONSIVE:
                    width: ScreenUtilHelper.width(363),
                    height: ScreenUtilHelper.height(51),
                    child: TextField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // RESPONSIVE:
                  SizedBox(height: ScreenUtilHelper.height(20)),
                ],
                _buildSectionTitle('Message'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.ash),
                    // RESPONSIVE:
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
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
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.parchment,
                                shape: RoundedRectangleBorder(
                                  // RESPONSIVE:
                                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5)),
                                ),
                                // RESPONSIVE:
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
                      Divider(height: ScreenUtilHelper.height(1), color: AppColors.ash),
                      _buildFormattingToolbar(),
                      _buildFormattingToolbarRow2(),
                      TextField(
                        controller: _messageController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                          // RESPONSIVE:
                          contentPadding: EdgeInsets.all(ScreenUtilHelper.width(12.0)),
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
                    onPressed: () {
                      final newNotice = Notice(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleController.text,
                        body: _messageController.text,
                        status: 'Draft',
                        statusColor: AppColors.warningAccent,
                        bgColor: AppColors.ivory,
                        barColor: AppColors.dottedLineColor,
                        sentTo: state.selectedRecipientType,
                        showEditDelete: true,
                      );

                      context.read<NoticeBloc>().add(CreateNotice(newNotice));
                      _showSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarker,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        // RESPONSIVE:
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
                      ),
                      // RESPONSIVE:
                      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(14.0)),
                    ),
                    child: Text(
                      'Publish',
                      // RESPONSIVE:
                      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                  ),
                ),
                // RESPONSIVE:
                SizedBox(height: ScreenUtilHelper.height(20)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecipientTypeDropdown(BuildContext context, NoticeState state) {
    return DropdownButtonFormField<String>(
      value: state.selectedRecipientType,
      items: ['Parents', 'Teachers', 'All'].map((String value) {
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
      onChanged: (String? value) {
        if (value != null) {
          context.read<NoticeBloc>().add(SelectRecipientType(value));
        }
      },
      decoration: const InputDecoration(border: OutlineInputBorder()),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
      isExpanded: true,
      dropdownColor: AppColors.white,
      // RESPONSIVE:
      menuMaxHeight: ScreenUtilHelper.height(200),
    );
  }

  Widget _buildSendViaDropdown(BuildContext context, NoticeState state) {
    return DropdownButtonFormField<String>(
      value: state.selectedSendVia,
      items: ['Email', 'Text'].map((String value) {
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
      onChanged: (String? value) {
        if (value != null) {
          context.read<NoticeBloc>().add(SelectSendVia(value));
        }
      },
      decoration: const InputDecoration(border: OutlineInputBorder()),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
      isExpanded: true,
      dropdownColor: AppColors.white,
      // RESPONSIVE:
      menuMaxHeight: ScreenUtilHelper.height(200),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      // RESPONSIVE:
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8.0)),
      child: Text(
        title,
        style: TextStyle(
          // RESPONSIVE:
          fontSize: ScreenUtilHelper.fontSize(16),
          fontWeight: FontWeight.w600,
          color: AppColors.graphite,
        ),
      ),
    );
  }

  Widget _buildRecipientGrid(BuildContext context, NoticeState state) {
    return Container(
      // RESPONSIVE:
      width: ScreenUtilHelper.width(340),
      height: ScreenUtilHelper.height(110),
      child: Scrollbar(
        controller: _recipientGridScrollController,
        child: SingleChildScrollView(
          controller: _recipientGridScrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              (state.filteredRecipients.length / 4).ceil(),
                  (rowIndex) {
                return Row(
                  children: List.generate(4, (columnIndex) {
                    final index = rowIndex * 4 + columnIndex;
                    if (index < state.filteredRecipients.length) {
                      final recipient = state.filteredRecipients[index];
                      final isSelected = state.selectedRecipients[index];
                      return Padding(
                        // RESPONSIVE:
                        padding: EdgeInsets.only(
                          right: ScreenUtilHelper.width(8.0),
                          bottom: ScreenUtilHelper.height(8.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<NoticeBloc>().add(
                              ToggleRecipientSelection(index, !isSelected),
                            );
                          },
                          child: Container(
                            // RESPONSIVE:
                            width: ScreenUtilHelper.width(74),
                            height: ScreenUtilHelper.height(40),
                            decoration: BoxDecoration(
                              // RESPONSIVE:
                              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.silver
                                    : AppColors.cloud,
                              ),
                              color: isSelected ? AppColors.silver : null,
                            ),
                            child: Center(
                              child: Padding(
                                // RESPONSIVE:
                                padding: EdgeInsets.all(ScreenUtilHelper.width(4.0)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      recipient.name,
                                      style: TextStyle(
                                        // RESPONSIVE:
                                        fontSize: ScreenUtilHelper.fontSize(9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      recipient.number,
                                      style: TextStyle(
                                        // RESPONSIVE:
                                        fontSize: ScreenUtilHelper.fontSize(10),
                                        color: AppColors.slate,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // RESPONSIVE:
                      return SizedBox(width: ScreenUtilHelper.width(82));
                    }
                  }),
                );
              },
            ),
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
              Container(
                // RESPONSIVE:
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(8),
                  vertical: ScreenUtilHelper.height(4),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cloud),
                  // RESPONSIVE:
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Paragraph', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(12))), // RESPONSIVE
                    SizedBox(width: ScreenUtilHelper.width(4)), // RESPONSIVE
                    Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.scaleAll(16)), // RESPONSIVE
                  ],
                ),
              ),
              // RESPONSIVE:
              SizedBox(width: ScreenUtilHelper.width(10)),
              _buildToolbarIcon(Icons.format_align_left),
              _buildToolbarIcon(Icons.format_align_center),
              _buildToolbarIcon(Icons.format_align_right),
            ],
          ),
          Row(
            children: [
              _buildToolbarIcon(Icons.format_list_numbered),
              _buildToolbarIcon(Icons.format_list_bulleted),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormattingToolbarRow2() {
    return Padding(
      // RESPONSIVE:
      padding: EdgeInsets.fromLTRB(
        ScreenUtilHelper.width(8.0),
        0,
        ScreenUtilHelper.width(8.0),
        ScreenUtilHelper.height(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildToolbarIcon(Icons.format_color_text),
              _buildToolbarIcon(Icons.format_color_fill),
              _buildToolbarIcon(Icons.format_bold),
              _buildToolbarIcon(Icons.format_italic),
              _buildToolbarIcon(Icons.format_underline),
              _buildToolbarIcon(Icons.format_strikethrough),
            ],
          ),
          Row(
            children: [
              _buildToolbarIcon(Icons.link),
              _buildToolbarIcon(Icons.image_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon) {
    return IconButton(
      // RESPONSIVE:
      icon: Icon(icon, size: ScreenUtilHelper.scaleAll(20)),
      onPressed: () {},
      // RESPONSIVE:
      padding: EdgeInsets.all(ScreenUtilHelper.width(4)),
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
      // RESPONSIVE:
      splashRadius: ScreenUtilHelper.radius(18),
      color: AppColors.slate,
    );
  }
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // RESPONSIVE: Initialize helper here too for standalone widget usage
    ScreenUtilHelper.init(context);

    return Container(
      // RESPONSIVE:
      width: ScreenUtilHelper.width(378),
      height: ScreenUtilHelper.height(40),
      decoration: BoxDecoration(
        // RESPONSIVE:
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.accentLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: ()=>GoRouter.of(context).pop(),
          ),
          // RESPONSIVE:
          SizedBox(width: ScreenUtilHelper.width(5)),
          Text(
            'Notices',
            style: TextStyle(
              // RESPONSIVE:
              fontSize: ScreenUtilHelper.fontSize(19),
              fontWeight: FontWeight.w600,
              color: AppColors.graphite,
            ),
          ),
        ],
      ),
    );
  }
}