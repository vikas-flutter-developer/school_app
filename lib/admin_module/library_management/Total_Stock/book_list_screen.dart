import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import 'bloc/book_bloc.dart';
import 'models/book_item.dart';


class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  int _selectedIndex = 0; // For BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    // Responsive calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    double appBarLogoHeight = screenHeight * 0.04;
    double horizontalPadding = screenWidth * 0.04;
    double verticalPadding = screenHeight * 0.015;
    // double titleFontSize = isSmallScreen ? 18 : 22; // Not needed for this screen title
    double cardTitleFontSize =
        isSmallScreen ? 15 : 17; // Slightly smaller title
    double cardBodyFontSize = isSmallScreen ? 12 : 14;
    double cardStatusFontSize = isSmallScreen ? 12 : 14;
    double cardImageWidth = screenWidth * 0.22; // Slightly smaller image width
    double cardImageHeight = screenHeight * 0.13;
    double fabFontSize = isSmallScreen ? 14 : 16;
    double fabIconSize = isSmallScreen ? 20 : 22;
    double fabPaddingVertical = isSmallScreen ? 10 : 12;
    double fabPaddingHorizontal = isSmallScreen ? 16 : 20;

    return BlocProvider(
      create: (context) => BookBloc()..add(LoadBookData()),
      child: Scaffold(
        backgroundColor: AppColors.linen,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 1.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackMediumEmphasis,
              size: 20,
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Center(
            // Ensure logo is truly centered by adjusting padding or using flexible space if needed
            child: Padding(
              // Adjust padding if logo isn't perfectly centered due to leading/actions width
              padding: EdgeInsets.only(right: screenWidth * 0.1),
              // Example adjustment
              child: Image.asset(
                'assets/images/edudibon.png',
                height: appBarLogoHeight,
                fit: BoxFit.contain,
              ),
            ),
          ),
          centerTitle: true,
          // Helps in centering but consider action button width
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: AppColors.blackMediumEmphasis,
                    size: 28,
                  ),
                  onPressed: () {
                    /* Handle notification tap */
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: horizontalPadding / 2),
          ],
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white, // White background for search
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: AppColors.cloud,
                    width: 1.0,
                  ), // Subtle border
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: AppColors.ash),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.ash,
                      size: 22,
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      color: AppColors.ash,
                      size: 22,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 10.0,
                    ), // Adjust vertical padding
                  ),
                ),
              ),
            ),

            // Book List
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    // Add padding at the bottom to avoid FAB overlap with last item's content
                    return ListView.builder(
                      padding: EdgeInsets.only(
                        left: horizontalPadding / 2,
                        right: horizontalPadding / 2,
                        bottom: screenHeight * 0.1,
                      ), // Padding for FAB
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final item = state.books[index];
                        return _buildBookItemCard(
                          context,
                          item,
                          cardTitleFontSize,
                          cardBodyFontSize,
                          cardStatusFontSize,
                          cardImageWidth,
                          cardImageHeight,
                          // Add slight dimming for the out-of-stock card background
                          cardBackgroundColor:
                              item.availability == BookAvailability.outOfStock
                                  ? Colors
                                      .grey
                                      .shade200 // Dimmed background
                                  : AppColors.white, // Normal white
                        );
                      },
                    );
                  } else if (state is BookError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No books found.'));
                  }
                },
              ),
            ),
          ],
        ),
        // Floating Action Button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=>context.push(AppRoutes.libraryAddBook),
          backgroundColor: Colors.deepPurple,
          // Matching purple color
          icon: Icon(Icons.add, color: AppColors.white, size: fabIconSize),
          label: Text(
            'Add Book',
            style: TextStyle(
              color: AppColors.white,
              fontSize: fabFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 4.0,
          // Standard FAB elevation
          shape: RoundedRectangleBorder(
            // More rounded corners like the image
            borderRadius: BorderRadius.circular(12),
          ),
          extendedPadding: EdgeInsets.symmetric(
            vertical: fabPaddingVertical,
            horizontal: fabPaddingHorizontal,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // Default bottom right

        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined), // Using feed icon
              activeIcon: Icon(Icons.feed),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'My Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: AppColors.stone,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            color: Colors.deepPurple,
            size: 26,
          ),
          // Slightly larger selected icon
          unselectedIconTheme: IconThemeData(color: AppColors.stone, size: 24),
          // Simulate indicator line via Theme (affects selected item)
          // For a precise line, a custom painter or package is best.
          // This setup relies on strong selection color.
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  // Helper Widget to build each book item card
  Widget _buildBookItemCard(
    BuildContext context,
    BookItem item,
    double titleFontSize,
    double bodyFontSize,
    double statusFontSize,
    double imageWidth,
    double imageHeight, {
    Color cardBackgroundColor =
        AppColors.white, // Added background color parameter
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      // Slightly less vertical margin
      elevation: 1.5,
      // Subtle elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: AppColors.cloud,
          width: 0.5,
        ), // Thin border
      ),
      color: cardBackgroundColor,
      // Use passed background color
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.bookTitle,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackHighEmphasis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildDetailText(
                    item.subTitle,
                    bodyFontSize,
                    color: AppColors.slate,
                  ),
                  _buildDetailText(
                    "Authors Name: ${item.authorsName}",
                    bodyFontSize,
                  ),
                  const SizedBox(height: 8), // More space before rack info
                  _buildDetailText(
                    "Rack Name/No: ${item.rackNameNo}",
                    bodyFontSize,
                  ),
                  _buildDetailText("ISBN: ${item.isbn}", bodyFontSize),
                  _buildDetailText("Acc No: ${item.accNo}", bodyFontSize),
                ],
              ),
            ),
            const SizedBox(width: 12), // Spacing
            // Right Column: Image and Status
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Space between image and status
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center status text
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item.imageUrl,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          width: imageWidth,
                          height: imageHeight,
                          color: AppColors.cloud,
                          child: Icon(Icons.book, color: AppColors.ash),
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                // Space between image and status text
                // Availability Status
                Text(
                  item.availability == BookAvailability.available
                      ? 'Available'
                      : 'Out of stock',
                  style: TextStyle(
                    fontSize: statusFontSize,
                    fontWeight: FontWeight.w600, // Bold status
                    color:
                        item.availability == BookAvailability.available
                            ? AppColors.successDark // Green for available
                            : AppColors.errorDark, // Red for out of stock
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for consistent detail text styling
  Widget _buildDetailText(String text, double fontSize, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: color ?? AppColors.stone),
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // Prevent long text overflow
      ),
    );
  }
}
