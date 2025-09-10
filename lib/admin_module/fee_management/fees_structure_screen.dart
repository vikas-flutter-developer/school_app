import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';


class FeesStructureBloc extends Bloc<FeesStructureEvent, FeesStructureState> {
  FeesStructureBloc() : super(FeesStructureState.initial()) {
    on<DropdownValueChanged>((event, emit) {
      emit(state.copyWith(
          selectedAcademicYear: event.type == 'year' ? event.value : state.selectedAcademicYear,
          selectedFeeType: event.type == 'type' ? event.value : state.selectedFeeType,
          selectedFeeCategory: event.type == 'category' ? event.value : state.selectedFeeCategory,
          selectedHeadStatus: event.type == 'status' ? event.value : state.selectedHeadStatus
      ));
    });
    on<SaveButtonPressed>((event, emit) {});
    on<CancelButtonPressed>((event, emit) {});
  }
}
abstract class FeesStructureEvent extends Equatable { @override List<Object?> get props => []; }
class DropdownValueChanged extends FeesStructureEvent {
  final String type; final String? value;
  DropdownValueChanged(this.type, this.value);
  @override List<Object?> get props => [type, value];
}
class SaveButtonPressed extends FeesStructureEvent {}
class CancelButtonPressed extends FeesStructureEvent {}

class FeesStructureState extends Equatable {
  final String? selectedAcademicYear;
  final String? selectedFeeType;
  final String? selectedFeeCategory;
  final String? selectedHeadStatus;
  final List<String> academicYearOptions;
  final List<String> feeTypeOptions;
  final List<String> feeCategoryOptions;
  final List<String> headStatusOptions;

  const FeesStructureState({
    this.selectedAcademicYear, this.selectedFeeType, this.selectedFeeCategory, this.selectedHeadStatus,
    required this.academicYearOptions, required this.feeTypeOptions, required this.feeCategoryOptions, required this.headStatusOptions,
  });

  factory FeesStructureState.initial() {
    return const FeesStructureState(
        academicYearOptions: ['2024-25', '2023-24'],
        feeTypeOptions: ['Tuition', 'Transport', 'Activity'],
        feeCategoryOptions: ['General', 'Sibling Discount', 'Scholarship'],
        headStatusOptions: ['Active', 'Inactive']
    );
  }

  FeesStructureState copyWith({
    String? selectedAcademicYear, String? selectedFeeType, String? selectedFeeCategory, String? selectedHeadStatus,
    List<String>? academicYearOptions, List<String>? feeTypeOptions, List<String>? feeCategoryOptions, List<String>? headStatusOptions,
    bool clearAcademicYear = false, bool clearFeeType = false, bool clearFeeCategory = false, bool clearHeadStatus = false,
  }) {
    return FeesStructureState(
      selectedAcademicYear: clearAcademicYear ? null : selectedAcademicYear ?? this.selectedAcademicYear,
      selectedFeeType: clearFeeType ? null : selectedFeeType ?? this.selectedFeeType,
      selectedFeeCategory: clearFeeCategory ? null : selectedFeeCategory ?? this.selectedFeeCategory,
      selectedHeadStatus: clearHeadStatus ? null : selectedHeadStatus ?? this.selectedHeadStatus,
      academicYearOptions: academicYearOptions ?? this.academicYearOptions,
      feeTypeOptions: feeTypeOptions ?? this.feeTypeOptions,
      feeCategoryOptions: feeCategoryOptions ?? this.feeCategoryOptions,
      headStatusOptions: headStatusOptions ?? this.headStatusOptions,
    );
  }

  @override List<Object?> get props => [selectedAcademicYear, selectedFeeType, selectedFeeCategory, selectedHeadStatus, academicYearOptions, feeTypeOptions, feeCategoryOptions, headStatusOptions];
}


class FeesStructureScreen extends StatelessWidget {
  const FeesStructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeesStructureBloc(),
      child: const FeesStructureView(),
    );
  }
}

class FeesStructureView extends StatelessWidget {
  const FeesStructureView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(20),
          vertical: ScreenUtilHelper.height(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fees Structure',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(18),
                color: AppColors.blackHighEmphasis,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(24)),
            BlocBuilder<FeesStructureBloc, FeesStructureState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildStructureDropdown(context, 'Select Academic Year', state.selectedAcademicYear, state.academicYearOptions, (val) => context.read<FeesStructureBloc>().add(DropdownValueChanged('year', val))),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      _buildStructureDropdown(context, 'Fee Type', state.selectedFeeType, state.feeTypeOptions, (val) => context.read<FeesStructureBloc>().add(DropdownValueChanged('type', val))),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      _buildStructureDropdown(context, 'Fee Category', state.selectedFeeCategory, state.feeCategoryOptions, (val) => context.read<FeesStructureBloc>().add(DropdownValueChanged('category', val))),
                      SizedBox(height: ScreenUtilHelper.height(16)),
                      _buildStructureDropdown(context, 'Head Status', state.selectedHeadStatus, state.headStatusOptions, (val) => context.read<FeesStructureBloc>().add(DropdownValueChanged('status', val))),
                    ],
                  );
                }
            ),
            const Spacer(),
            _buildActionButtons(context),
            SizedBox(height: ScreenUtilHelper.height(16)),
          ],
        ),
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
        'Fees',
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

  Widget _buildStructureDropdown(BuildContext context, String hint, String? value, List<String> items, ValueChanged<String?> onChanged) {
    final double fontSize = ScreenUtilHelper.fontSize(15);
    return Container(
      height: ScreenUtilHelper.height(55),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(15.0),
        vertical: ScreenUtilHelper.height(5.0),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        border: Border.all(color: AppColors.secondaryMedium, width: ScreenUtilHelper.width(1.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: GoogleFonts.openSans(color: AppColors.blackMediumEmphasis, fontSize: fontSize)),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ash),
          elevation: 2,
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

  Widget _buildActionButtons(BuildContext context) {
    final double fontSize = ScreenUtilHelper.fontSize(16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<FeesStructureBloc>().add(CancelButtonPressed());
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.secondaryMedium,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(40),
              vertical: ScreenUtilHelper.height(12),
            ),
            side: BorderSide(color: AppColors.secondaryMedium, width: ScreenUtilHelper.width(1.5)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
          ),
          child: Text('Cancel', style: GoogleFonts.openSans(fontSize: fontSize, fontWeight: FontWeight.w600)),
        ),
        SizedBox(width: ScreenUtilHelper.width(20)),
        ElevatedButton(
          onPressed: () {
            context.read<FeesStructureBloc>().add(SaveButtonPressed());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryMedium,
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(50),
              vertical: ScreenUtilHelper.height(12),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
            elevation: 2,
          ),
          child: Text('Save', style: GoogleFonts.openSans(fontSize: fontSize, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}