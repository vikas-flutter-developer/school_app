import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import '../Student_Details/student_details_screen.dart';
import 'bloc/student_academics_bloc.dart';

class StudentAcademicsScreen extends StatelessWidget {
  const StudentAcademicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (context) => StudentAcademicsBloc()..add(LoadStudentData()),
      child: const StudentAcademicsView(),
    );
  }
}

class StudentAcademicsView extends StatelessWidget {
  const StudentAcademicsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double hPadding = ScreenUtilHelper.width(16);
    final double vPadding = ScreenUtilHelper.height(12);
    final double titleFontSize = ScreenUtilHelper.fontSize(20);
    final double headerFontSize = ScreenUtilHelper.fontSize(14);
    final double bodyFontSize = ScreenUtilHelper.fontSize(13);
    final double hintFontSize = ScreenUtilHelper.fontSize(14);
    final double labelFontSize = ScreenUtilHelper.fontSize(15);
    final double searchBarHeight = ScreenUtilHelper.height(50);
    final double dropdownHeight = ScreenUtilHelper.height(50);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20), color: AppColors.blackMediumEmphasis),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'Student Academics',
          style: GoogleFonts.roboto(
            color: AppColors.blackHighEmphasis,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis, size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications Tapped!')),
              );
            },
          ),
          SizedBox(width: hPadding * 0.5),
        ],
      ),
      body: BlocBuilder<StudentAcademicsBloc, StudentAcademicsState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildSearchBar(context, state, hPadding, vPadding, searchBarHeight, hintFontSize),
              _buildFilterDropdowns(context, state, hPadding, vPadding, dropdownHeight, hintFontSize),
              _buildTitleAndPrint(context, state, hPadding, vPadding, labelFontSize),
              _buildStudentListHeader(hPadding, headerFontSize),
              Expanded(
                child: _buildStudentList(context, state, hPadding, bodyFontSize),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, StudentAcademicsState state, double hPadding, double vPadding, double height, double fontSize) {
    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, vPadding, hPadding, vPadding * 0.5),
      child: SizedBox(
        height: height,
        child: TextField(
          onChanged: (query) => context.read<StudentAcademicsBloc>().add(SearchQueryChanged(query)),
          style: TextStyle(fontSize: fontSize, color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: AppColors.ash.withOpacity(0.8), fontSize: fontSize),
            prefixIcon: Icon(Icons.search, color: AppColors.ash),
            suffixIcon: Icon(Icons.mic, color: AppColors.ash),
            filled: true,
            fillColor: AppColors.parchment,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdowns(BuildContext context, StudentAcademicsState state, double hPadding, double vPadding, double height, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding * 0.5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown(context, 'Class', state.selectedClass, state.classOptions, (val) => context.read<StudentAcademicsBloc>().add(ClassSelected(val)), height, fontSize),
              ),
              SizedBox(width: hPadding * 0.75),
              Expanded(
                child: _buildDropdown(context, 'Section', state.selectedSection, state.sectionOptions, (val) => context.read<StudentAcademicsBloc>().add(SectionSelected(val)), height, fontSize),
              ),
            ],
          ),
          SizedBox(height: vPadding * 0.75),
          _buildDropdown(context, 'Academic year', state.selectedAcademicYear, state.academicYearOptions, (val) => context.read<StudentAcademicsBloc>().add(AcademicYearSelected(val)), height, fontSize, isExpanded: true),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String hint, String? value, List<String> items, ValueChanged<String?> onChanged, double height, double fontSize, {bool isExpanded = false}) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.silver, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: isExpanded,
          hint: Text(hint, style: TextStyle(color: AppColors.blackMediumEmphasis, fontSize: fontSize)),
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
          style: TextStyle(color: AppColors.blackHighEmphasis, fontSize: fontSize),
          dropdownColor: AppColors.white,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: TextStyle(fontSize: fontSize)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTitleAndPrint(BuildContext context, StudentAcademicsState state, double hPadding, double vPadding, double fontSize) {
    final displayTitle = state.status == DataStatus.loading ? 'Loading...' : state.currentSelectionDisplay;
    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, vPadding * 1.5, hPadding, vPadding * 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(displayTitle, style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize, color: AppColors.blackHighEmphasis)),
          IconButton(
            icon: Icon(Icons.print_outlined, color: AppColors.tertiaryPale, size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Print Tapped!')));
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          )
        ],
      ),
    );
  }

  Widget _buildStudentListHeader(double hPadding, double fontSize) {
    return Container(
      color: AppColors.tertiaryLightest,
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: ScreenUtilHelper.height(12)),
      child: Row(
        children: [
          _buildHeaderCell('Sr. No.', 10, fontSize, TextAlign.center),
          _buildHeaderCell('Admission no.', 25, fontSize),
          _buildHeaderCell('Student Name', 35, fontSize),
          _buildHeaderCell('Contact no.', 30, fontSize, TextAlign.end),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, int flex, double fontSize, [TextAlign align = TextAlign.start]) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(text, textAlign: align, style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize, color: AppColors.blackHighEmphasis), maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildStudentList(BuildContext context, StudentAcademicsState state, double hPadding, double fontSize) {
    if (state.status == DataStatus.loading && state.students.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == DataStatus.failure) {
      return Center(child: Text('Failed to load data: ${state.errorMessage ?? 'Unknown error'}'));
    }
    if (state.filteredStudents.isEmpty && state.status == DataStatus.success) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(20)),
          child: Text(
            state.searchQuery.isNotEmpty
                ? 'No students match your search.'
                : (state.selectedClass != null || state.selectedSection != null || state.selectedAcademicYear != null)
                ? 'No students found for the selected criteria.'
                : 'Select filters to view students or search.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize + 1, color: AppColors.stone),
          ),
        ),
      );
    }

    final students = state.filteredStudents;

    return ListView.builder(
      itemCount: students.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final student = students[index];
        return InkWell(
          onTap: ()=>context.push(AppRoutes.studentAcademicDetails,extra: {"student":student,"selection":state.currentSelectionDisplay}),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: ScreenUtilHelper.height(14)),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(color: AppColors.cloud, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _buildDataCell(student.srNo, 10, fontSize, TextAlign.center),
                _buildDataCell(student.admissionNo, 25, fontSize),
                _buildDataCell(student.name, 35, fontSize),
                _buildDataCell(student.contactNo, 30, fontSize, TextAlign.end),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataCell(String text, int flex, double fontSize, [TextAlign align = TextAlign.start]) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(fontSize: fontSize, color: AppColors.blackHighEmphasis),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
