
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import 'bloc/student_exam_bloc.dart';

class StudentExamScreen extends StatelessWidget {
  const StudentExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper here (important!)
    //ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => StudentExamBloc(),
      child: const StudentExamView(),
    );
  }
}

class StudentExamView extends StatelessWidget {
  const StudentExamView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<StudentExamBloc, StudentExamState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildSearchBar(context, state),
              _buildFilterDropdowns(context, state),
              _buildTitleAndPrint(context, state),
              _buildExamListHeader(), // No longer need to pass sizes
              Expanded(
                child: _buildExamList(context, state), // No longer need to pass sizes
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20), color: AppColors.blackMediumEmphasis),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Student Exam',
        style: GoogleFonts.openSans(
          color: AppColors.blackHighEmphasis,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilHelper.fontSize(18),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis),
          onPressed: () {},
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, StudentExamState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilHelper.width(15),
        ScreenUtilHelper.height(12),
        ScreenUtilHelper.width(15),
        ScreenUtilHelper.height(6),
      ),
      child: SizedBox(
        height: ScreenUtilHelper.height(50),
        child: TextField(
          onChanged: (query) => context.read<StudentExamBloc>().add(SearchQueryChanged(query)),
          style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(14), color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.8), fontSize: ScreenUtilHelper.fontSize(14)),
            prefixIcon: const Icon(Icons.search, color: AppColors.ash),
            suffixIcon: const Icon(Icons.mic, color: AppColors.ash),
            filled: true,
            fillColor: AppColors.parchment,
            contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(15)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdowns(BuildContext context, StudentExamState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(15),
        vertical: ScreenUtilHelper.height(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDropdown(context: context, hint: 'Class', value: state.selectedClass, items: state.classOptions, onChanged: (v) => context.read<StudentExamBloc>().add(ClassSelected(v)))),
              SizedBox(width: ScreenUtilHelper.width(11)),
              Expanded(child: _buildDropdown(context: context, hint: 'Section', value: state.selectedSection, items: state.sectionOptions, onChanged: (v) => context.read<StudentExamBloc>().add(SectionSelected(v)))),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(9)),
          Row(
            children: [
              Expanded(child: _buildDropdown(context: context, hint: 'Semester', value: state.selectedSemester, items: state.semesterOptions, onChanged: (v) => context.read<StudentExamBloc>().add(SemesterSelected(v)))),
              SizedBox(width: ScreenUtilHelper.width(11)),
              Expanded(child: _buildDropdown(context: context, hint: 'Academic year', value: state.selectedAcademicYear, items: state.academicYearOptions, onChanged: (v) => context.read<StudentExamBloc>().add(AcademicYearSelected(v)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({required BuildContext context, required String hint, required String? value, required List<String> items, required ValueChanged<String?> onChanged}) {
    final double fontSize = ScreenUtilHelper.fontSize(14);
    return Container(
      height: ScreenUtilHelper.height(50),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
        border: Border.all(color: AppColors.silver, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: GoogleFonts.openSans(color: AppColors.blackMediumEmphasis, fontSize: fontSize)),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
          style: GoogleFonts.openSans(color: AppColors.blackHighEmphasis, fontSize: fontSize),
          dropdownColor: AppColors.white,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: GoogleFonts.openSans(fontSize: fontSize)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTitleAndPrint(BuildContext context, StudentExamState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          ScreenUtilHelper.width(15),
          ScreenUtilHelper.height(18),
          ScreenUtilHelper.width(15),
          ScreenUtilHelper.height(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              state.currentSelectionDisplay,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtilHelper.fontSize(14),
                color: AppColors.blackHighEmphasis,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
          IconButton(
            icon: Icon(Icons.print_outlined, color: AppColors.tertiaryPale, size: ScreenUtilHelper.scaleAll(24)),
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // Define column widths once using the helper
  static final double _srNoWidth = ScreenUtilHelper.width(45);
  static final double _dateWidth = ScreenUtilHelper.width(94);
  static final double _subjectWidth = ScreenUtilHelper.width(131);
  static final double _timingWidth = ScreenUtilHelper.width(94);
  static final double _invigilatorWidth = ScreenUtilHelper.width(131);
  static final double _roomWidth = ScreenUtilHelper.width(75);

  Widget _buildExamListHeader() {
    return Container(
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(15)),
        child: Row(
          children: [
            _buildHeaderCell('Sr.No.', width: _srNoWidth, alignment: TextAlign.center),
            _buildHeaderCell('Exam Date', width: _dateWidth),
            _buildHeaderCell('Subject', width: _subjectWidth),
            _buildHeaderCell('Timing', width: _timingWidth),
            _buildHeaderCell('Invigilator', width: _invigilatorWidth),
            _buildHeaderCell('Room no.', width: _roomWidth, alignment: TextAlign.end),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required double width, TextAlign alignment = TextAlign.start}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(6)),
      child: Text(
        text,
        textAlign: alignment,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtilHelper.fontSize(12.5),
          color: AppColors.blackHighEmphasis,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildExamList(BuildContext context, StudentExamState state) {
    if (state.status == DataStatus.loading && state.allExams.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == DataStatus.failure) {
      return Center(child: Text('Error: ${state.errorMessage ?? 'Could not load exams'}'));
    }
    if (state.filteredExams.isEmpty && state.status == DataStatus.success) {
      return Center(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(20)),
            child: Text(
              // ... empty state message logic ...
              'Select filters to view exam schedule.',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(15), color: AppColors.stone),
            ),
          ));
    }

    final examsToShow = state.filteredExams;

    return ListView.builder(
      itemCount: examsToShow.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final exam = examsToShow[index];
        return Container(
          decoration:  BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: AppColors.cloud, width: 1.0)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(15),
              vertical: ScreenUtilHelper.height(14),
            ),
            child: Row(
              children: [
                _buildDataCell(exam.srNo, width: _srNoWidth, alignment: TextAlign.center),
                _buildDataCell(exam.examDate, width: _dateWidth),
                _buildDataCell(exam.subject, width: _subjectWidth),
                _buildDataCell(exam.timing, width: _timingWidth),
                _buildDataCell(exam.invigilator, width: _invigilatorWidth),
                _buildDataCell(exam.roomNo, width: _roomWidth, alignment: TextAlign.end),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataCell(String text, {required double width, TextAlign alignment = TextAlign.start}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(6)),
      child: Text(
        text,
        textAlign: alignment,
        style: GoogleFonts.openSans(
          fontSize: ScreenUtilHelper.fontSize(12),
          color: AppColors.blackHighEmphasis,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}