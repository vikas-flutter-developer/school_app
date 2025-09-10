import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import 'models/fee_due.dart';


class FeesDuesBloc extends Bloc<FeesDuesEvent, FeesDuesState> {
  FeesDuesBloc() : super(FeesDuesState.initial()) {
    on<LoadDues>((event, emit) {});
    on<FilterToggled>((event, emit) {
      final isYear = event.filterType == 'year';
      emit(state.copyWith(
        isYearExpanded: isYear ? !state.isYearExpanded : false,
        isClassExpanded: !isYear ? !state.isClassExpanded : false,
      ));
    });
    on<FilterSelected>((event, emit) {
      emit(state.copyWith(
        selectedYear: event.filterType == 'year' ? event.value : state.selectedYear,
        selectedClass: event.filterType == 'class' ? event.value : state.selectedClass,
        isYearExpanded: false,
        isClassExpanded: false,
      ));
      add(LoadDues());
    });
  }
}
abstract class FeesDuesEvent extends Equatable { @override List<Object?> get props => []; }
class LoadDues extends FeesDuesEvent {}
class FilterToggled extends FeesDuesEvent { final String filterType; FilterToggled(this.filterType); @override List<Object?> get props => [filterType];}
class FilterSelected extends FeesDuesEvent { final String filterType; final String value; FilterSelected(this.filterType, this.value); @override List<Object?> get props => [filterType, value];}

class FeesDuesState extends Equatable {
  final bool isYearExpanded;
  final bool isClassExpanded;
  final String? selectedYear;
  final String? selectedClass;
  final List<String> yearOptions;
  final List<String> classOptions;
  final List<FeeDue> duesList;

  const FeesDuesState({
    required this.isYearExpanded, required this.isClassExpanded,
    this.selectedYear, this.selectedClass,
    required this.yearOptions, required this.classOptions, required this.duesList,
  });

  factory FeesDuesState.initial() {
    return const FeesDuesState(
      yearOptions: ['2025-26', '2024-25', '2023-24'],
      classOptions: ['X', 'VIII', 'VII'],
      selectedYear: '2024-25',
      selectedClass: 'X',
      duesList: dummyFeeDues,
      isYearExpanded: false,
      isClassExpanded: false,
    );
  }

  FeesDuesState copyWith({
    bool? isYearExpanded, bool? isClassExpanded, String? selectedYear, String? selectedClass,
    List<String>? yearOptions, List<String>? classOptions, List<FeeDue>? duesList,
  }) {
    return FeesDuesState(
      isYearExpanded: isYearExpanded ?? this.isYearExpanded,
      isClassExpanded: isClassExpanded ?? this.isClassExpanded,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedClass: selectedClass ?? this.selectedClass,
      yearOptions: yearOptions ?? this.yearOptions,
      classOptions: classOptions ?? this.classOptions,
      duesList: duesList ?? this.duesList,
    );
  }

  @override List<Object?> get props => [isYearExpanded, isClassExpanded, selectedYear, selectedClass, yearOptions, classOptions, duesList];
}


class FeesDuesScreen extends StatelessWidget {
  const FeesDuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeesDuesBloc(),
      child: const FeesDuesView(),
    );
  }
}

class FeesDuesView extends StatelessWidget {
  const FeesDuesView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocBuilder<FeesDuesBloc, FeesDuesState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildFilterSection(context, state),
              SizedBox(height: ScreenUtilHelper.height(24)),
              _buildDuesTableHeader(),
              Expanded(
                child: _buildDuesList(state),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.secondaryMedium,
        unselectedItemColor: AppColors.ash,
        selectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w500, fontSize: ScreenUtilHelper.fontSize(12)),
        unselectedLabelStyle: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(12)),
        backgroundColor: AppColors.white,
        elevation: 4.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), activeIcon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'My Account'),
        ],
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
        'Fees Dues',
        style: GoogleFonts.openSans(
          color: AppColors.blackHighEmphasis,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilHelper.fontSize(19),
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

  Widget _buildFilterSection(BuildContext context, FeesDuesState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(20),
        vertical: ScreenUtilHelper.height(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildFilterCard(
              context: context,
              title: 'Academic Year',
              isExpanded: state.isYearExpanded,
              options: state.yearOptions,
              selectedOption: state.selectedYear,
              onHeaderTap: () => context.read<FeesDuesBloc>().add(FilterToggled('year')),
              onOptionTap: (value) => context.read<FeesDuesBloc>().add(FilterSelected('year', value)),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(15)),
          Expanded(
            child: _buildFilterCard(
              context: context,
              title: 'Select Class',
              isExpanded: state.isClassExpanded,
              options: state.classOptions,
              selectedOption: state.selectedClass,
              onHeaderTap: () => context.read<FeesDuesBloc>().add(FilterToggled('class')),
              onOptionTap: (value) => context.read<FeesDuesBloc>().add(FilterSelected('class', value)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard({
    required BuildContext context, required String title, required bool isExpanded,
    required List<String> options, String? selectedOption, required VoidCallback onHeaderTap,
    required ValueChanged<String> onOptionTap,
  }) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.zero,
      color: AppColors.primaryLightest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0))),
      child: InkWell(
        onTap: onHeaderTap,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12.0),
            vertical: ScreenUtilHelper.height(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isExpanded ? title : selectedOption ?? title,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtilHelper.fontSize(16),
                      color: AppColors.blackHighEmphasis,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.blackMediumEmphasis,
                    size: ScreenUtilHelper.scaleAll(20),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: isExpanded,
                  child: Padding(
                    padding: EdgeInsets.only(top: ScreenUtilHelper.height(8.0)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options.where((o) => o != selectedOption).map((option) =>
                          InkWell(
                            onTap: () => onOptionTap(option),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(6.0)),
                              child: Text(
                                option,
                                style: GoogleFonts.openSans(
                                    fontSize: ScreenUtilHelper.fontSize(15),
                                    color: AppColors.blackMediumEmphasis,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          )
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuesTableHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          ScreenUtilHelper.width(20), 0, ScreenUtilHelper.width(20), ScreenUtilHelper.height(8.0)
      ),
      child: Row(
        children: [
          _buildHeaderCell('Student Name', flex: 4),
          _buildHeaderCell('Pending Fees', flex: 3, alignment: TextAlign.center),
          _buildHeaderCell('Due Date', flex: 3, alignment: TextAlign.end),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required int flex, TextAlign alignment = TextAlign.start}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignment,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtilHelper.fontSize(14),
          color: AppColors.blackMediumEmphasis,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildDuesList(FeesDuesState state) {
    if (state.duesList.isEmpty) {
      return Center(child: Text('No pending dues found.', style: GoogleFonts.openSans(color: AppColors.ash)));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
      itemCount: state.duesList.length,
      itemBuilder: (context, index) {
        final due = state.duesList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(10.0)),
          child: Row(
            children: [
              _buildDataCell(due.studentName, flex: 4, color: AppColors.blackHighEmphasis),
              _buildDataCell(due.pendingFees, flex: 3, color: AppColors.blackHighEmphasis, alignment: TextAlign.center),
              _buildDataCell(due.dueDate, flex: 3, color: AppColors.blackMediumEmphasis, alignment: TextAlign.end),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataCell(String text, {required int flex, required Color color, TextAlign alignment = TextAlign.start}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignment,
        style: GoogleFonts.openSans(
          fontSize: ScreenUtilHelper.fontSize(15),
          color: color,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}