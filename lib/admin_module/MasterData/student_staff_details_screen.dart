import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import 'StudentStaffDetailsBloc/student_staff_details_bloc.dart';
import 'models/student_staff_detail.dart';

class StudentStaffDetailsScreen extends StatelessWidget {
  const StudentStaffDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentStaffDetailsBloc(),
      child: const StudentStaffDetailsView(),
    );
  }
}

class StudentStaffDetailsView extends StatefulWidget {
  const StudentStaffDetailsView({super.key});

  @override
  State<StudentStaffDetailsView> createState() =>
      _StudentStaffDetailsViewState();
}

class _StudentStaffDetailsViewState extends State<StudentStaffDetailsView>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _studentSubTabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _mainTabController =
        TabController(length: DetailTab.values.length, vsync: this);
    _studentSubTabController = TabController(length: 2, vsync: this);

    _mainTabController.addListener(() {
      if (!_mainTabController.indexIsChanging) {
        if (_horizontalScrollController.hasClients) {
          _horizontalScrollController.jumpTo(0);
        }
        context.read<StudentStaffDetailsBloc>().add(
          TabSelected(_mainTabController.index),
        );
        _searchController.clear();
      }
    });

    _studentSubTabController.addListener(() {
      if (!_studentSubTabController.indexIsChanging) {
        if (_horizontalScrollController.hasClients) {
          _horizontalScrollController.jumpTo(0);
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _studentSubTabController.dispose();
    _searchController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    // Student column widths
    final double s_srNoWidth = ScreenUtilHelper.width(55);
    final double s_admNoWidth = ScreenUtilHelper.width(110);
    final double s_nameWidth = ScreenUtilHelper.width(150);
    final double s_statusWidth = ScreenUtilHelper.width(95);
    final double s_contactWidth = ScreenUtilHelper.width(130);
    final double s_sectionWidth = ScreenUtilHelper.width(95);

    // Staff column widths (note: department should match header usage — keep large)
    final double st_srNoWidth = ScreenUtilHelper.width(55);
    final double st_empIdWidth = ScreenUtilHelper.width(110);
    final double st_nameWidth = ScreenUtilHelper.width(130);
    final double st_emailWidth = ScreenUtilHelper.width(170);
    final double st_contactWidth = ScreenUtilHelper.width(130);
    final double st_deptWidth = ScreenUtilHelper.width(300); // keep 300 to match header

    final double studentTableWidth = s_srNoWidth +
        s_admNoWidth +
        s_nameWidth +
        s_statusWidth +
        s_contactWidth +
        s_sectionWidth;
    final double staffTableWidth = st_srNoWidth +
        st_empIdWidth +
        st_nameWidth +
        st_emailWidth +
        st_contactWidth +
        st_deptWidth;

    // Extra horizontal padding used inside header & rows (left + right)
    final double horizontalPaddingTotal = ScreenUtilHelper.width(16) * 2;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocListener<StudentStaffDetailsBloc, StudentStaffDetailsState>(
        listener: (context, state) {
          if (_mainTabController.index != state.selectedTab.index) {
            _mainTabController.animateTo(state.selectedTab.index);
          }
        },
        child: Column(
          children: [
            _buildTopSearchBar(context),
            _buildMainTabBar(context, _mainTabController),
            _buildFiltersSection(
                context, _searchController, _studentSubTabController),
            // Table area: horizontal scroll + vertically scrollable body
            Expanded(
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child:
                BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
                  builder: (context, state) {
                    final double currentTableWidth = state.selectedTab ==
                        DetailTab.student
                        ? studentTableWidth
                        : staffTableWidth;

                    // Add horizontal padding to width so header/rows' internal padding doesn't overflow
                    final double tableTotalWidth =
                        currentTableWidth + horizontalPaddingTotal;

                    // Ensure width is at least screen width so layout stretches
                    final double constrainedWidth = tableTotalWidth <
                        ScreenUtilHelper.screenWidth
                        ? ScreenUtilHelper.screenWidth
                        : tableTotalWidth;

                    return SizedBox(
                      width: constrainedWidth,
                      child: Column(
                        children: [
                          // Header: uses the same horizontal padding, so it aligns
                          _buildTableHeader(context),
                          // Body: ListView will take remaining vertical space
                          Expanded(
                            child: _buildDataTable(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            _buildPaginationControls(context),
          ],
        ),
      ),
      bottomNavigationBar:
      BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.bottomNavIndex,
            onTap: (index) => context.read<StudentStaffDetailsBloc>().add(
              BottomNavTapped(index),
            ),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryMedium,
            unselectedItemColor: AppColors.ash,
            selectedLabelStyle: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtilHelper.fontSize(11),
            ),
            unselectedLabelStyle:
            GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11)),
            backgroundColor: AppColors.white,
            elevation: 5.0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), label: 'Feed'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'My Account'),
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
        icon: Icon(
          Icons.arrow_back_ios,
          size: ScreenUtilHelper.scaleAll(20),
          color: AppColors.blackMediumEmphasis,
        ),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Student/Staff Details',
        style: GoogleFonts.openSans(
          color: AppColors.blackHighEmphasis,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtilHelper.fontSize(18),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.blackMediumEmphasis,
          ),
          onPressed: () {},
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  Widget _buildTopSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilHelper.width(16),
        ScreenUtilHelper.height(8),
        ScreenUtilHelper.width(16),
        ScreenUtilHelper.height(16),
      ),
      child: SizedBox(
        height: ScreenUtilHelper.height(50),
        child: TextField(
          style: GoogleFonts.openSans(
            fontSize: ScreenUtilHelper.fontSize(14),
            color: AppColors.blackHighEmphasis,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.openSans(
              color: AppColors.ash.withOpacity(0.8),
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
            prefixIcon: const Icon(Icons.search, color: AppColors.ash),
            suffixIcon: const Icon(Icons.mic_none, color: AppColors.ash),
            filled: true,
            fillColor: AppColors.parchment,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10.0)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainTabBar(BuildContext context, TabController controller) {
    return Container(
      height: ScreenUtilHelper.height(45),
      margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16.0)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
          color: AppColors.white,
          border: Border.all(color: AppColors.cloud),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              blurRadius: ScreenUtilHelper.radius(4),
              offset: Offset(0, ScreenUtilHelper.height(1)),
            ),
          ],
        ),
        labelColor: AppColors.primaryMedium,
        unselectedLabelColor: AppColors.blackMediumEmphasis,
        labelStyle: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtilHelper.fontSize(14),
        ),
        unselectedLabelStyle: GoogleFonts.openSans(
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtilHelper.fontSize(14),
        ),
        dividerColor: AppColors.transparent,
        tabs: const [Tab(text: 'Student Details'), Tab(text: 'Staff Details')],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context,
      TextEditingController searchController, TabController studentSubTabController) {
    return BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
      builder: (context, state) {
        if (state.selectedTab == DetailTab.student) {
          return Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
            child: Column(
              children: [
                Container(
                  height: ScreenUtilHelper.height(40),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: AppColors.cloud,
                          width: ScreenUtilHelper.width(1.5)),
                    ),
                  ),
                  child: TabBar(
                    controller: studentSubTabController,
                    indicatorColor: AppColors.primaryMedium,
                    indicatorWeight: ScreenUtilHelper.height(3.0),
                    labelColor: AppColors.primaryMedium,
                    unselectedLabelColor: AppColors.blackMediumEmphasis,
                    labelStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtilHelper.fontSize(13.5),
                    ),
                    unselectedLabelStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtilHelper.fontSize(13.5),
                    ),
                    tabs: const [Tab(text: 'Class'), Tab(text: 'Student')],
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _buildStudentFiltersContent(context, state, searchController,
                      studentSubTabController.index),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildFilterDropdown(
                    context,
                    'Select by',
                    state.staffFilterValue,
                    state.staffFilterOptions,
                        (v) => context
                        .read<StudentStaffDetailsBloc>()
                        .add(StaffFilterSelected(v)),
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(12)),
                Expanded(
                  flex: 3,
                  child: _buildSpecificSearchBar(
                    context,
                    searchController,
                    'Search by name, id, email...',
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildStudentFiltersContent(BuildContext context, StudentStaffDetailsState state,
      TextEditingController searchController, int subTabIndex) {
    if (subTabIndex == 0) {
      return Column(
        key: const ValueKey('student_v1_filters'),
        children: [
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  context,
                  'Academic year',
                  state.studentAcademicYear,
                  state.academicYearOptions,
                      (v) => context
                      .read<StudentStaffDetailsBloc>()
                      .add(StudentAcademicYearSelected(v)),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)),
              Expanded(
                child: _buildFilterDropdown(
                  context,
                  'Select type/status',
                  state.studentTypeStatus,
                  state.typeStatusOptions,
                      (v) => context
                      .read<StudentStaffDetailsBloc>()
                      .add(StudentTypeStatusSelected(v)),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          _buildFilterDropdown(
            context,
            'Select class',
            state.studentClass,
            state.classOptions,
                (v) =>
                context.read<StudentStaffDetailsBloc>().add(StudentClassSelected(v)),
          ),
        ],
      );
    } else {
      return Row(
        key: const ValueKey('student_v2_filters'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildFilterDropdown(
              context,
              'Select by',
              state.studentFilterOption,
              state.studentFilterOptions,
                  (v) => context
                  .read<StudentStaffDetailsBloc>()
                  .add(StudentFilterOptionSelected(v)),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(12)),
          Expanded(
            flex: 3,
            child: _buildSpecificSearchBar(
              context,
              searchController,
              'Search by name, number,...',
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFilterDropdown(BuildContext context, String hint, String? value,
      List<String> items, ValueChanged<String?> onChanged) {
    final double fontSize = ScreenUtilHelper.fontSize(14);
    return Container(
      height: ScreenUtilHelper.height(50),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12.0)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        border: Border.all(color: AppColors.silver, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.ash.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: GoogleFonts.openSans(
                  color: AppColors.blackMediumEmphasis, fontSize: fontSize)),
          icon: Icon(Icons.keyboard_arrow_down,
              color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
          style: GoogleFonts.openSans(
              color: AppColors.blackHighEmphasis, fontSize: fontSize),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSpecificSearchBar(
      BuildContext context, TextEditingController controller, String hint) {
    final double fontSize = ScreenUtilHelper.fontSize(13);
    return SizedBox(
      height: ScreenUtilHelper.height(50),
      child: TextField(
        controller: controller,
        onChanged: (query) {
          context.read<StudentStaffDetailsBloc>().add(SearchQueryChanged(query));
        },
        style: GoogleFonts.openSans(
            fontSize: fontSize, color: AppColors.blackHighEmphasis),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.openSans(color: AppColors.ash, fontSize: fontSize),
          suffixIcon: IconButton(
            icon: Icon(Icons.search,
                color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
            padding: EdgeInsets.zero,
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(
              vertical: 0, horizontal: ScreenUtilHelper.width(15)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            borderSide:
            BorderSide(color: AppColors.silver, width: ScreenUtilHelper.width(1.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
            borderSide:
            BorderSide(color: AppColors.silver, width: ScreenUtilHelper.width(1.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    final double fontSize = ScreenUtilHelper.fontSize(12.5);
    final double hPadding = ScreenUtilHelper.width(16);
    return BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
      builder: (context, state) {
        final Map<String, double> columns = state.selectedTab == DetailTab.student
            ? {
          'Sr. No.': ScreenUtilHelper.width(55),
          'Admission No.': ScreenUtilHelper.width(110),
          'Student Name': ScreenUtilHelper.width(150),
          'Status': ScreenUtilHelper.width(95),
          'Contact No.': ScreenUtilHelper.width(130),
          'Section': ScreenUtilHelper.width(95),
        }
            : {
          'Sr. No.': ScreenUtilHelper.width(55),
          'Employee Id': ScreenUtilHelper.width(110),
          'Staff Name': ScreenUtilHelper.width(130),
          'Email': ScreenUtilHelper.width(170),
          'Contact No.': ScreenUtilHelper.width(130),
          'Department': ScreenUtilHelper.width(300),
        };

        return Container(
          color: AppColors.ivory,
          padding: EdgeInsets.symmetric(
              horizontal: hPadding, vertical: ScreenUtilHelper.height(12.0)),
          child: Row(
            children: columns.entries.map((entry) {
              return _buildHeaderCell(entry.key,
                  width: entry.value, fontSize: fontSize);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(String text,
      {required double width, required double fontSize}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(6.0)),
      child: Text(text,
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
              color: AppColors.blackHighEmphasis),
          overflow: TextOverflow.ellipsis,
          maxLines: 1),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    final double fontSize = ScreenUtilHelper.fontSize(12);
    return BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == DataStatus.failure) {
          return Center(
              child:
              Text('Error: ${state.errorMessage ?? 'Could not load data'}'));
        }

        dynamic dataList = (state.selectedTab == DetailTab.student)
            ? state.studentList
            : state.staffList;
        if (dataList.isEmpty) {
          return Center(
              child: Text('No ${state.selectedTab.name} details found.',
                  style: GoogleFonts.openSans(color: AppColors.ash)));
        }

        return ListView.builder(
          itemCount: dataList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final item = dataList[index];
            final Map<String, double> columns =
            state.selectedTab == DetailTab.student
                ? {
              'srNo': ScreenUtilHelper.width(55),
              'id': ScreenUtilHelper.width(110),
              'name': ScreenUtilHelper.width(150),
              'status': ScreenUtilHelper.width(95),
              'contact': ScreenUtilHelper.width(130),
              'section': ScreenUtilHelper.width(95),
            }
                : {
              'srNo': ScreenUtilHelper.width(55),
              'id': ScreenUtilHelper.width(110),
              'name': ScreenUtilHelper.width(130),
              'email': ScreenUtilHelper.width(170),
              'contact': ScreenUtilHelper.width(130),
              'department': ScreenUtilHelper.width(300),
            };

            final List<Widget> dataCells = state.selectedTab == DetailTab.student
                ? [
              _buildDataCell(item.srNo, width: columns['srNo']!),
              _buildDataCell(item.admissionNo, width: columns['id']!),
              _buildDataCell(item.studentName, width: columns['name']!),
              _buildDataCell(item.status, width: columns['status']!),
              _buildDataCell(item.contactNo, width: columns['contact']!),
              _buildDataCell(item.section, width: columns['section']!),
            ]
                : [
              _buildDataCell(item.srNo, width: columns['srNo']!),
              _buildDataCell(item.employeeId, width: columns['id']!),
              _buildDataCell(item.staffName, width: columns['name']!),
              _buildDataCell(item.email, width: columns['email']!),
              _buildDataCell(item.contactNo, width: columns['contact']!),
              _buildDataCell(item.department, width: columns['department']!),
            ];

            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.cloud,
                        width: ScreenUtilHelper.width(1.0))),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(16),
                  vertical: ScreenUtilHelper.height(14.0)),
              child: Row(children: dataCells),
            );
          },
        );
      },
    );
  }

  Widget _buildDataCell(String text, {required double width}) {
    final double fontSize = ScreenUtilHelper.fontSize(12);
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(6.0)),
      child: Text(text,
          style: GoogleFonts.openSans(
              fontSize: fontSize,
              color: AppColors.blackHighEmphasis,
              fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          maxLines: 1),
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    return BlocBuilder<StudentStaffDetailsBloc, StudentStaffDetailsState>(
      builder: (context, state) {
        int currentPage = (state.selectedTab == DetailTab.student)
            ? state.studentCurrentPage
            : state.staffCurrentPage;
        int totalPages = (state.selectedTab == DetailTab.student)
            ? state.studentTotalPages
            : state.staffTotalPages;
        if (totalPages <= 1) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtilHelper.height(8.0),
              horizontal: ScreenUtilHelper.width(16.0)),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.parchment)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPaginationButton(
                context: context,
                icon: Icons.arrow_back_ios,
                isEnabled: currentPage > 1,
                onTap: () =>
                    context.read<StudentStaffDetailsBloc>().add(const PageChanged(-1)),
              ),
              SizedBox(width: ScreenUtilHelper.width(10)),
              Container(
                width: ScreenUtilHelper.scaleAll(36),
                height: ScreenUtilHelper.scaleAll(36),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryMedium,
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.radius(4.0)),
                ),
                child: Text(
                  '$currentPage',
                  style: GoogleFonts.openSans(
                    fontSize: ScreenUtilHelper.fontSize(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(10)),
              _buildPaginationButton(
                context: context,
                icon: Icons.arrow_forward_ios,
                isEnabled: currentPage < totalPages,
                onTap: () =>
                    context.read<StudentStaffDetailsBloc>().add(const PageChanged(1)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaginationButton({
    required BuildContext context,
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
      ),
      child: Container(
        width: ScreenUtilHelper.scaleAll(36),
        height: ScreenUtilHelper.scaleAll(36),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4.0)),
          border: Border.all(
            color: isEnabled
                ? AppColors.primaryMedium
                : AppColors.ash.withOpacity(0.5),
            width: ScreenUtilHelper.width(1.5),
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: ScreenUtilHelper.scaleAll(16),
          color: isEnabled
              ? AppColors.primaryMedium
              : AppColors.ash.withOpacity(0.5),
        ),
      ),
    );
  }
}
