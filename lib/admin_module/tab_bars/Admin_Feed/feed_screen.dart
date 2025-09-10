// Your updated feed_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'bloc/feed_bloc.dart';
import 'models/feed_item.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(),
      child: const FeedView(),
    );
  }
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper (best practice is in MaterialApp's build method)
    //ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery and manual responsive logic.
    // The ScreenUtilHelper now handles all sizing.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FeedBloc>().add(LoadFeedItems());
          await context.read<FeedBloc>().stream.firstWhere((state) => state.status != FeedStatus.loading);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            _buildDateDisplay(context),
            Expanded(
              child: BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  if (state.status == FeedStatus.loading && state.allFeedItems.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == FeedStatus.failure) {
                    return Center(child: Text('Error: ${state.errorMessage ?? 'Could not load feed'}'));
                  }
                  if (state.filteredFeedItems.isEmpty && state.status == FeedStatus.success) {
                    return Center(
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(20)),
                          child: Text(
                            state.searchQuery.isNotEmpty
                                ? 'No items match your search.'
                                : 'Your feed is empty.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(fontSize: ScreenUtilHelper.fontSize(13), color: AppColors.stone),
                          ),
                        ));
                  }

                  // Display the list
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtilHelper.width(15),
                        ScreenUtilHelper.height(6),
                        ScreenUtilHelper.width(15),
                        ScreenUtilHelper.height(12)
                    ),
                    itemCount: state.filteredFeedItems.length,
                    itemBuilder: (context, index) {
                      final item = state.filteredFeedItems[index];
                      // ✅ No longer need to pass sizes, the card handles it internally
                      return _buildFeedItemCard(context, item: item);
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
      titleSpacing: ScreenUtilHelper.width(15),
      title: Image.asset(
        'assets/images/edudibon.png',
        height: ScreenUtilHelper.height(28),
        errorBuilder: (context, error, stackTrace) => Text('Logo', style: TextStyle(color: AppColors.error)),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis),
          onPressed: () {},
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final double fontSize = ScreenUtilHelper.fontSize(13);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(15),
        vertical: ScreenUtilHelper.height(6),
      ),
      child: SizedBox(
        height: ScreenUtilHelper.height(50),
        child: TextField(
          onChanged: (query) => context.read<FeedBloc>().add(SearchQueryChanged(query)),
          style: GoogleFonts.openSans(fontSize: fontSize, color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.8), fontSize: fontSize),
            prefixIcon: const Icon(Icons.search, color: AppColors.ash),
            suffixIcon: const Icon(Icons.mic, color: AppColors.ash),
            filled: true,
            fillColor: AppColors.linen,
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

  Widget _buildDateDisplay(BuildContext context) {
    final DateTime currentDate = context.select((FeedBloc bloc) => bloc.state.currentDate);
    final String formattedDate = DateFormat('MMMM d, yyyy').format(currentDate);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilHelper.width(15),
        ScreenUtilHelper.height(6),
        ScreenUtilHelper.width(15),
        ScreenUtilHelper.height(12),
      ),
      child: Text(
        "Today's date: $formattedDate",
        style: GoogleFonts.openSans(
          fontSize: ScreenUtilHelper.fontSize(12),
          color: AppColors.slate,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFeedItemCard(BuildContext context, {required FeedItem item}) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
      color: AppColors.ivory,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12))),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              width: ScreenUtilHelper.scaleAll(49),
              height: ScreenUtilHelper.scaleAll(49),
              decoration: BoxDecoration(
                color: item.iconBgColor,
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
              ),
              child: Center(
                child: Icon(
                  item.iconData,
                  color: AppColors.white,
                  size: ScreenUtilHelper.scaleAll(30),
                ),
              ),
            ),
            SizedBox(width: ScreenUtilHelper.width(12)),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtilHelper.fontSize(15),
                      color: AppColors.blackHighEmphasis,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(4)),
                  Text(
                    item.description,
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(13),
                      color: AppColors.charcoal,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}