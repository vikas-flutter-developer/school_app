// Your updated library_details_screen.dart file

import 'package:edudibon_flutter_bloc/admin_module/hrsm/widgets/Custom_logo_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// ✅ STEP 1: Import the necessary helpers
import '../../core/utils/app_colors.dart';
import 'bloc/library_details_bloc/library_details_bloc.dart';
import 'models/library_book_item.dart';
import '../../core/utils/screen_util_helper.dart';

// --- Main Screens for each Tab ---
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

class TodayReceivedScreen extends StatelessWidget {
  const TodayReceivedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryDetailsBloc()..add(const LoadBooks(1)),
      child: const LibraryDetailsView(),
    );
  }
}

class DueBooksScreen extends StatelessWidget {
  const DueBooksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryDetailsBloc()..add(const LoadBooks(2)),
      child: const LibraryDetailsView(),
    );
  }
}
// -------------------------

class LibraryDetailsView extends StatefulWidget {
  const LibraryDetailsView({super.key});
  @override
  State<LibraryDetailsView> createState() => _LibraryDetailsViewState();
}

class _LibraryDetailsViewState extends State<LibraryDetailsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initialBlocIndex = context.read<LibraryDetailsBloc>().state.selectedTabIndex;
    _tabController = TabController(length: 3, vsync: this, initialIndex: initialBlocIndex);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && mounted) {
        if (context.read<LibraryDetailsBloc>().state.selectedTabIndex != _tabController.index) {
          context.read<LibraryDetailsBloc>().add(TabChanged(_tabController.index));
        }
      }
    });
    _searchController.text = context.read<LibraryDetailsBloc>().state.searchQuery;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showSendAlertDialog(BuildContext context, LibraryBookItem book) {
    final bloc = context.read<LibraryDetailsBloc>();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(16)),
          ),
          content: SingleChildScrollView( // ✅ Prevents overflow
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: -math.pi / 6,
                  child: Icon(Icons.send_outlined,
                      size: ScreenUtilHelper.scaleAll(36),
                      color: AppColors.errorAccent),
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                Text(
                  'Send alert message',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.obsidian),
                ),
                SizedBox(height: ScreenUtilHelper.height(8)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.openSans(
                        fontSize: ScreenUtilHelper.fontSize(14),
                        color: AppColors.slate,
                        height: 1.4),
                    children: [
                      const TextSpan(text: "to- "),
                      TextSpan(
                        text: book.issuedTo.replaceFirst("Issued to- ", ""),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: " student\nbook name- "),
                      TextSpan(
                        text: book.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDialogButton(
                        text: 'Delay fine ₹100',
                        onPressed: () {
                          GoRouter.of(dialogContext).pop();
                          bloc.add(SendAlert(book, 'delay'));
                        }),
                    SizedBox(width: 10),
                    _buildDialogButton(
                        text: 'Damage fine ₹300',
                        onPressed: () {
                          GoRouter.of(dialogContext).pop();
                          bloc.add(SendAlert(book, 'damage'));
                        }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildDialogButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      height: 40,
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ivory,
          foregroundColor: AppColors.primaryDark,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
        ),
        child: Text(text, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(10), fontWeight: FontWeight.w600)),
      ),
    );
  }

  void _showStatusMessage(BuildContext context, LibraryDetailsState state) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    String message;
    Color bgColor;
    IconData iconData;

    if (state.status == LibraryDataStatus.alertSentSuccess) {
      message = "Message delivered";
      bgColor = AppColors.success;
      iconData = Icons.check_circle_outline_rounded;
    } else if (state.status == LibraryDataStatus.alertSentFailure) {
      message = state.alertErrorMessage ?? "Failed to send alert";
      bgColor = AppColors.error.withOpacity(0.9);
      iconData = Icons.error_outline_rounded;
    } else {
      return;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData, color: AppColors.white, size: ScreenUtilHelper.scaleAll(20)),
          SizedBox(width: ScreenUtilHelper.width(10)),
          Expanded(child: Text(message, style: GoogleFonts.openSans(color: AppColors.white, fontWeight: FontWeight.w500))),
        ],
      ),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10))),
      margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20), vertical: ScreenUtilHelper.height(15)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      if (mounted && (state.status == LibraryDataStatus.alertSentSuccess || state.status == LibraryDataStatus.alertSentFailure)) {
        context.read<LibraryDetailsBloc>().add(DismissAlertStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery and manual responsive logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomLogoAppBar(),
      body: BlocListener<LibraryDetailsBloc, LibraryDetailsState>(
        listenWhen: (prev, current) =>
        prev.bookToShowAlertFor != current.bookToShowAlertFor ||
            (current.status == LibraryDataStatus.alertSentSuccess && prev.status != current.status) ||
            (current.status == LibraryDataStatus.alertSentFailure && prev.status != current.status) ||
            prev.selectedTabIndex != current.selectedTabIndex,
        listener: (context, state) {
          if (state.bookToShowAlertFor != null) _showSendAlertDialog(context, state.bookToShowAlertFor!);
          if (state.status == LibraryDataStatus.alertSentSuccess || state.status == LibraryDataStatus.alertSentFailure) _showStatusMessage(context, state);
          if (_tabController.index != state.selectedTabIndex && mounted && !_tabController.indexIsChanging) _tabController.animateTo(state.selectedTabIndex);
        },
        child: Column(
          children: [
            _buildTopSearchBar(context),
            _buildTabBar(context, _tabController),
            Expanded(
              child: BlocBuilder<LibraryDetailsBloc, LibraryDetailsState>(
                builder: (context, state) {
                  if (state.status == LibraryDataStatus.loading && state.displayedBooks.isEmpty) return const Center(child: CircularProgressIndicator(color: AppColors.primaryDark));
                  if (state.status == LibraryDataStatus.failure) return Center(child: Padding(padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), child: Text("Error: ${state.errorMessage ?? 'Could not load books'}", textAlign: TextAlign.center)));
                  if (state.displayedBooks.isEmpty && state.status == LibraryDataStatus.success) {
                    // ... [Your existing empty message logic] ...
                    String emptyMessage = "No issued books found.";
                    return Center(child: Text(emptyMessage, style: GoogleFonts.openSans(color: AppColors.stone)));
                  }

                  bool isSending = state.status == LibraryDataStatus.sendingAlert;

                  return Stack(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtilHelper.width(15),
                          ScreenUtilHelper.height(8),
                          ScreenUtilHelper.width(15),
                          ScreenUtilHelper.height(24),
                        ),
                        itemCount: state.displayedBooks.length,
                        itemBuilder: (context, index) {
                          final book = state.displayedBooks[index];
                          // ✅ No longer need to pass sizes, the card handles it internally
                          return _buildBookItemCard(context: context, book: book, selectedTabIndex: state.selectedTabIndex);
                        },
                      ),
                      if (isSending)
                        Positioned.fill(
                          child: Container(
                            color: AppColors.black.withOpacity(0.1),
                            child: const Center(child: CircularProgressIndicator(color: AppColors.primaryDark)),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
                decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle, border: Border.all(color: AppColors.white, width: 1.5)),
                constraints: BoxConstraints(minWidth: badgeSize, minHeight: badgeSize),
                child: Center(
                  child: Text(
                    '$count',
                    style: GoogleFonts.openSans(color: AppColors.white, fontSize: badgeSize * 0.65, fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(15), vertical: ScreenUtilHelper.height(12)),
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
      margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16), vertical: ScreenUtilHelper.height(12)),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(4)),
      decoration: BoxDecoration(color: AppColors.ivory, borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
      child: TabBar(
        controller: controller,
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
        tabs: const [Tab(text: 'Issued books'), Tab(text: 'Received books'), Tab(text: 'Due Books')],
      ),
    );
  }

  Widget _buildBookItemCard({required BuildContext context, required LibraryBookItem book, required int selectedTabIndex}) {
    // ✅ All sizes are now calculated internally using ScreenUtilHelper
    final double imageWidth = ScreenUtilHelper.width(82);
    final double imageHeight = imageWidth * 1.4;
    final bool showActionIcon = selectedTabIndex == 2; // 2 is the index for Due Books

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
      shadowColor: AppColors.shadowDefault,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8))),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: showActionIcon ? () => context.read<LibraryDetailsBloc>().add(ShowAlertRequest(book)) : null,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(14), horizontal: ScreenUtilHelper.width(14)),
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
                    child: Image.asset(book.imageUrl, width: imageWidth, height: imageHeight, fit: BoxFit.cover, errorBuilder: (ctx, err, st) => Container(width: imageWidth, height: imageHeight, color: AppColors.parchment, child:  Icon(Icons.book_outlined, color: AppColors.silver))),
                  ),
                ],
              ),
            ),
            if (showActionIcon)
              Positioned(
                top: ScreenUtilHelper.height(8),
                right: ScreenUtilHelper.width(8),
                child: IgnorePointer(
                  child: Transform.rotate(
                    angle: -math.pi / 6,
                    child: Icon(Icons.send_outlined, size: ScreenUtilHelper.scaleAll(20), color: AppColors.errorAccent),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label1, String label2) {
    return Row(
      children: [
        Expanded(child: Text(label1, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11.5), color: AppColors.stone), maxLines: 1, overflow: TextOverflow.ellipsis)),
        SizedBox(width: ScreenUtilHelper.width(10)),
        Expanded(child: Text(label2, style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(11.5), color: AppColors.stone), maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}