import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:edudibon_flutter_bloc/admin_module/hrsm/widgets/Custom_logo_appbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ✅ your ScreenUtilHelper

import '../blocs/book_issue_bloc.dart';
import '../blocs/book_issue_event.dart';
import '../blocs/book_issue_state.dart';

class BookIssueScreen extends StatelessWidget {
  const BookIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookIssueBloc(),
      child: const BookIssueForm(),
    );
  }
}

class BookIssueForm extends StatelessWidget {
  const BookIssueForm({super.key});

  void _showBookAddedOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: ScreenUtilHelper.height(600),
        left: ScreenUtilHelper.width(75),
        right: ScreenUtilHelper.width(75),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16),
              vertical: ScreenUtilHelper.height(10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.deepPurple, size: ScreenUtilHelper.scaleAll(20)),
                SizedBox(width: ScreenUtilHelper.width(8)),
                Text(
                  'Book Added',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtilHelper.fontSize(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<BookIssueBloc>();
    const dummyBooks = [
      'Bengali class I',
      'Bengali class II',
      'Bengali class III',
      'Bengali class IV',
      'Bengali class V',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomLogoAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)),
        child: BlocBuilder<BookIssueBloc, BookIssueState>(
          builder: (context, state) {
            final filteredBooks = dummyBooks
                .where((book) =>
                book.toLowerCase().contains(state.bookSearch.toLowerCase()))
                .toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtilHelper.height(60)),
                  _buildDropdown(
                    label: "Select category",
                    value: state.category,
                    items: ['Science', 'Math', 'History'],
                    onChanged: (val) => bloc.add(UpdateCategory(val)),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  _buildTextInput(
                    hint: 'Library ID',
                    onChanged: (val) =>
                        bloc.add(UpdateField(field: 'libraryId', value: val)),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  _buildTextInput(
                    hint: 'Name',
                    onChanged: (val) =>
                        bloc.add(UpdateField(field: 'name', value: val)),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Search book',
                      suffixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (val) =>
                        bloc.add(UpdateField(field: 'bookSearch', value: val)),
                  ),
                  if (state.bookSearch.isNotEmpty) ...[
                    SizedBox(height: ScreenUtilHelper.height(8)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];
                        final selected = state.selectedBooks.contains(book);
                        return CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(book),
                          value: selected,
                          onChanged: (_) =>
                              bloc.add(ToggleBookSelection(book)),
                        );
                      },
                    ),
                  ],
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  _buildDateField(
                    label: 'Issued date',
                    onTap: () => bloc.add(
                        UpdateField(field: 'issuedDate', value: '2025-08-07')),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  _buildDateField(
                    label: 'Return date',
                    onTap: () => bloc.add(
                        UpdateField(field: 'returnDate', value: '2025-08-17')),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(16)),
                  _buildDropdown(
                    label: "No of copies",
                    value: state.copies,
                    items: ['1', '2', '3', '4', '5'],
                    onChanged: (val) =>
                        bloc.add(UpdateField(field: 'copies', value: val)),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(150)),
                  ElevatedButton(
                    onPressed: () {
                      _showBookAddedOverlay(context);
                      bloc.add(SubmitIssue());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        ScreenUtilHelper.width(126),
                        ScreenUtilHelper.height(46),
                      ),
                      backgroundColor: AppColors.primaryMedium,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(10)),
                      ),
                    ),
                    child: Text(
                      'Issue Book',
                      style: AppStyles.bodyBold.copyWith(
                          color: AppColors.white,
                          fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(12),
          vertical: ScreenUtilHelper.height(14),
        ),
      ),
      value: value.isEmpty ? null : value,
      hint: Text(label),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
    );
  }

  Widget _buildTextInput({
    required String hint,
    required void Function(String) onChanged,
  }) {
    return SizedBox(
      height: ScreenUtilHelper.height(40),
      width: ScreenUtilHelper.width(400),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          hintText: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: ScreenUtilHelper.height(40),
      width: ScreenUtilHelper.width(400),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          hintText: label,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: onTap,
      ),
    );
  }
}
