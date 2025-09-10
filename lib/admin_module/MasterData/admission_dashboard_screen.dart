// screens/admission_dashboard_screen.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import 'models/admission_dashboard_stat.dart';

class AdmissionDashboardBloc extends Bloc<AdmissionDashboardEvent, AdmissionDashboardState> {
  AdmissionDashboardBloc() : super(AdmissionDashboardState.initial()) {
    on<LoadAdmissionData>((event, emit) async {
      emit(state.copyWith(status: DataStatus.loading));
      await Future.delayed(Duration(milliseconds: 300));
      emit(state.copyWith(status: DataStatus.success, stats: dummyAdmissionStats));
    });
    on<BottomNavTapped>((event, emit) => emit(state.copyWith(bottomNavIndex: event.index)));
  }
}

enum DataStatus { initial, loading, success, failure }

abstract class AdmissionDashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAdmissionData extends AdmissionDashboardEvent {}

class BottomNavTapped extends AdmissionDashboardEvent {
  final int index;
  BottomNavTapped(this.index);
  @override
  List<Object?> get props => [index];
}

class AdmissionDashboardState extends Equatable {
  final DataStatus status;
  final List<AdmissionDashboardStat> stats;
  final int bottomNavIndex;
  final String? errorMessage;

  const AdmissionDashboardState({
    this.status = DataStatus.initial,
    this.stats = const [],
    this.bottomNavIndex = 0,
    this.errorMessage,
  });

  factory AdmissionDashboardState.initial() => const AdmissionDashboardState(stats: dummyAdmissionStats);

  AdmissionDashboardState copyWith({
    DataStatus? status,
    List<AdmissionDashboardStat>? stats,
    int? bottomNavIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AdmissionDashboardState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, stats, bottomNavIndex, errorMessage];
}

class AdmissionDashboardScreen extends StatelessWidget {
  const AdmissionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdmissionDashboardBloc()..add(LoadAdmissionData()),
      child: const AdmissionDashboardView(),
    );
  }
}

class AdmissionDashboardView extends StatelessWidget {
  const AdmissionDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AdmissionDashboardBloc>().add(LoadAdmissionData());
          await context.read<AdmissionDashboardBloc>().stream.firstWhere((state) => state.status != DataStatus.loading);
        },
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
            vertical: ScreenUtilHelper.height(12),
          ),
          children: [
            _buildSearchBar(),
            SizedBox(height: ScreenUtilHelper.height(8)),
            Text(
              'Admission Dashboard',
              style: GoogleFonts.openSans(
                color: AppColors.blackHighEmphasis,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilHelper.fontSize(20),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            _buildNoteText(),
            SizedBox(height: ScreenUtilHelper.height(20)),
            _buildSectionTitle("Today's Updates"),
            SizedBox(height: ScreenUtilHelper.height(12)),
            _buildStatsList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.width(20), color: AppColors.blackMediumEmphasis),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Master Data',
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

  Widget _buildSearchBar() {
    return SizedBox(
      height: ScreenUtilHelper.height(50),
      child: TextField(
        style: GoogleFonts.openSans(
          fontSize: ScreenUtilHelper.fontSize(15),
          color: AppColors.blackHighEmphasis,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.openSans(
            color: AppColors.ash.withOpacity(0.8),
            fontSize: ScreenUtilHelper.fontSize(15),
          ),
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
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteText() {
    return Text(
      'Note: Data is calculated from 01 Jul 2024 date!',
      style: GoogleFonts.openSans(
        fontSize: ScreenUtilHelper.fontSize(13),
        color: AppColors.blackMediumEmphasis,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtilHelper.fontSize(17),
        color: AppColors.blackHighEmphasis,
      ),
    );
  }

  Widget _buildStatsList() {
    return BlocBuilder<AdmissionDashboardBloc, AdmissionDashboardState>(
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.height(32)),
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state.stats.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.height(32)),
              child: const Text('No stats available.'),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.stats.length,
          itemBuilder: (context, index) {
            final stat = state.stats[index];
            return _buildStatCard(stat.count, stat.label);
          },
          separatorBuilder: (context, index) => SizedBox(height: ScreenUtilHelper.height(12)),
        );
      },
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Material(
      elevation: 0.1,
      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.height(14),
            horizontal: ScreenUtilHelper.width(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                count,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtilHelper.fontSize(32),
                  color: AppColors.primaryMedium,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(12)),
              Text(
                label,
                style: GoogleFonts.openSans(
                  fontSize: ScreenUtilHelper.fontSize(16),
                  color: AppColors.blackHighEmphasis,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
