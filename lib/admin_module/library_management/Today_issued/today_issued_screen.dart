// Your updated library_details_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../bloc/library_details_bloc/library_details_bloc.dart';
import '../models/library_book_item.dart';
import '../../../core/utils/screen_util_helper.dart';


class TodayIssuedScreen extends StatelessWidget {
  const TodayIssuedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryDetailsBloc()..add(const LoadBooks(0)),
      child: const LibraryDetailsView(),
    );
  }
}

class LibraryDetailsView extends StatefulWidget {
  const LibraryDetailsView({super.key});

  @override
  State<LibraryDetailsView> createState() => _LibraryDetailsViewState();
}

class _LibraryDetailsViewState extends State<LibraryDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && mounted) {
        if (context.read<LibraryDetailsBloc>().state.selectedTabIndex != _tabController.index) {
          context.read<LibraryDetailsBloc>().add(TabChanged(_tabController.index));
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery and manual responsive logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: BlocListener<LibraryDetailsBloc, LibraryDetailsState>(
        listener: (context, state) {
          if (_tabController.index != state.selectedTabIndex && mounted) {
            _tabController.animateTo(state.selectedTabIndex);
          }
        },
        child: Column(
          children: [
            _buildTopSearchBar(context),
            _buildTabBar(context, _tabController),
            Expanded(
              child: BlocBuilder<LibraryDetailsBloc, LibraryDetailsState>(
                builder: (context, state) {
                  if (state.status == LibraryDataStatus.loading && state.displayedBooks.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryDark));
                  }
                  if (state.status == LibraryDataStatus.failure) {
                    return Center(child: Padding(padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), child: Text("Error: ${state.errorMessage ?? 'Could not load books'}", textAlign: TextAlign.center)));
                  }
                  if (state.displayedBooks.isEmpty && state.status == LibraryDataStatus.success) {
                    String emptyMessage = "No books found"; // Default message
                    // ... [Your existing empty message logic] ...
                    return Center(child: Text(emptyMessage, style: GoogleFonts.openSans(color: AppColors.stone)));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      ScreenUtilHelper.width(15),
                      ScreenUtilHelper.height(8),
                      ScreenUtilHelper.width(15),
                      ScreenUtilHelper.height(12),
                    ),
                    itemCount: state.displayedBooks.length,
                    itemBuilder: (context, index) {
                      final book = state.displayedBooks[index];
                      // ✅ No longer need to pass sizes, the card handles it internally
                      return _buildBookItemCard(context: context, book: book);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: ScreenUtilHelper.width(50),
      leading: Center(
        child: InkWell(
          onTap: () => GoRouter.of(context).pop(),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)),
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenUtilHelper.width(12),
              top: ScreenUtilHelper.height(8),
              bottom: ScreenUtilHelper.height(8),
              right: ScreenUtilHelper.width(4),
            ),
            child: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleAll(20), color: AppColors.charcoal),
          ),
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/images/edudibon.png',
          height: ScreenUtilHelper.height(24),
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        BlocBuilder<LibraryDetailsBloc, LibraryDetailsState>(
          buildWhen: (p, c) => p.notificationCount != c.notificationCount,
          builder: (context, state) => _buildNotificationIcon(context, state.notificationCount),
        ),
        SizedBox(width: ScreenUtilHelper.width(12)),
      ],
    );
  }

  Widget _buildNotificationIcon(BuildContext context, int count) {
    final double badgeSize = ScreenUtilHelper.scaleAll(16);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.slate, size: ScreenUtilHelper.scaleAll(26)),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: ScreenUtilHelper.scaleAll(22),
          ),
          if (count > 0)
            Positioned(
              top: -ScreenUtilHelper.scaleAll(3),
              right: -ScreenUtilHelper.scaleAll(3),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(2)),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
                constraints: BoxConstraints(minWidth: badgeSize, minHeight: badgeSize),
                child: Center(
                  child: Text(
                    '$count',
                    style: GoogleFonts.openSans(color: AppColors.white, fontSize: badgeSize * 0.65, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(15),
          vertical: ScreenUtilHelper.height(12)),
      child: SizedBox(
        height: ScreenUtilHelper.height(48),
        child: TextField(
          controller: _searchController,
          onChanged: (query) => context.read<LibraryDetailsBloc>().add(SearchChanged(query)),
          style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(14.5), color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.8), fontSize: ScreenUtilHelper.fontSize(14.5)),
            prefixIcon: Icon(Icons.search, color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
            suffixIcon: Icon(Icons.mic_none, color: AppColors.ash, size: ScreenUtilHelper.scaleAll(22)),
            filled: true,
            fillColor: AppColors.parchment,
            contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(15)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, TabController controller) {
    return Container(
      height: ScreenUtilHelper.height(45),
      margin: EdgeInsets.only(
          left: ScreenUtilHelper.width(16),
          right: ScreenUtilHelper.width(16),
          bottom: ScreenUtilHelper.height(12)),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(4)),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 0,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
          color: AppColors.white,
          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1))],
        ),
        labelColor: AppColors.primaryDark,
        unselectedLabelColor: AppColors.slate,
        labelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: ScreenUtilHelper.fontSize(14)),
        unselectedLabelStyle: GoogleFonts.openSans(fontWeight: FontWeight.w500, fontSize: ScreenUtilHelper.fontSize(14)),
        dividerColor: AppColors.transparent,
        tabs: const [
          Tab(text: 'Issued books'),
          Tab(text: 'Received books'),
          Tab(text: 'Due Books'),
        ],
      ),
    );
  }

  Widget _buildBookItemCard({required BuildContext context, required LibraryBookItem book}) {
    // ✅ All sizes are now calculated internally using ScreenUtilHelper
    final double imageWidth = ScreenUtilHelper.width(82);
    final double imageHeight = imageWidth * 1.4;

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
      shadowColor: AppColors.shadowDefault,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtilHelper.height(14),
                horizontal: ScreenUtilHelper.width(14)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.title, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(16), fontWeight: FontWeight.w600, color: AppColors.blackMediumEmphasis)),
                      SizedBox(height: ScreenUtilHelper.height(3)),
                      Text(book.subtitle, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(12.5), color: AppColors.slate)),
                      SizedBox(height: ScreenUtilHelper.height(5)),
                      Text(book.author, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(12.5), color: AppColors.graphite, fontWeight: FontWeight.w500)),
                      SizedBox(height: ScreenUtilHelper.height(14)),
                      _buildDetailRow(book.issuedTo, book.libraryId),
                      SizedBox(height: ScreenUtilHelper.height(7)),
                      _buildDetailRow(book.issuedDate, book.returnDate),
                    ],
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(7)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
                  child: Image.asset(
                    book.imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => Container(width: imageWidth, height: imageHeight, color: AppColors.parchment, child:  Icon(Icons.book_outlined, color: AppColors.silver)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtilHelper.height(8),
            right: ScreenUtilHelper.width(8),
            child: Transform.rotate(
              angle: -math.pi / 3.5,
              child: Icon(Icons.send_outlined, size: ScreenUtilHelper.scaleAll(20), color: AppColors.errorAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label1, String label2) {
    return Row(
      children: [
        Expanded(
          child: Text(label1, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11.5), color: AppColors.stone), maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        SizedBox(width: ScreenUtilHelper.width(10)),
        Expanded(
          child: Text(label2, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11.5), color: AppColors.stone), maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}