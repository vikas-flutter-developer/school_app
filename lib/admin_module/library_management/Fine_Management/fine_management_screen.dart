import 'package:edudibon_flutter_bloc/admin_module/hrsm/widgets/Custom_logo_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import 'bloc/fine_bloc.dart';
import 'models/fine_item.dart';
import '../../../core/utils/screen_util_helper.dart';

class FineManagementScreen extends StatefulWidget {
  const FineManagementScreen({super.key});

  @override
  State<FineManagementScreen> createState() => _FineManagementScreenState();
}

class _FineManagementScreenState extends State<FineManagementScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery and manual responsive logic.
    // The ScreenUtilHelper now handles all sizing.

    return BlocProvider(
      create: (context) => FineBloc()..add(LoadFineData()),
      child: Scaffold(
        backgroundColor: AppColors.linen,
        appBar: CustomLogoAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(15),
                  vertical: ScreenUtilHelper.height(12)),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.parchment,
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:  TextStyle(color: AppColors.stone),
                    prefixIcon:  Icon(Icons.search, color: AppColors.stone),
                    suffixIcon:  Icon(Icons.mic, color: AppColors.stone),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.height(15),
                        horizontal: ScreenUtilHelper.width(10)),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtilHelper.width(15),
                  bottom: ScreenUtilHelper.height(12)),
              child: Text(
                'Fine Management',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackHighEmphasis,
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<FineBloc, FineState>(
                builder: (context, state) {
                  if (state is FineLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FineLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
                      itemCount: state.fineItems.length,
                      itemBuilder: (context, index) {
                        final item = state.fineItems[index];
                        // ✅ No longer need to pass sizes, the card handles it internally
                        return _buildFineItemCard(context, item);
                      },
                    );
                  } else if (state is FineError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No fine data available.'));
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.feed_outlined), activeIcon: Icon(Icons.feed), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'My Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: AppColors.stone,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtilHelper.fontSize(12)),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: ScreenUtilHelper.fontSize(12)),
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  Widget _buildFineItemCard(BuildContext context, FineItem item) {
    // ✅ All sizes are now calculated internally using ScreenUtilHelper
    final double titleFontSize = ScreenUtilHelper.fontSize(16);
    final double bodyFontSize = ScreenUtilHelper.fontSize(12);
    final double fineFontSize = ScreenUtilHelper.fontSize(13);
    final double imageWidth = ScreenUtilHelper.width(94);
    final double imageHeight = ScreenUtilHelper.height(122);

    return Card(
      margin: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8), horizontal: ScreenUtilHelper.width(8)),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10))),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.bookTitle, style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold)),
                  SizedBox(height: ScreenUtilHelper.height(4)),
                  Text(item.subTitle ?? '', style: TextStyle(fontSize: bodyFontSize, color: AppColors.slate)),
                  Text("Authors Name : ${item.authorsName}", style: TextStyle(fontSize: bodyFontSize, color: AppColors.slate)),
                  Text("Publisher Name : ${item.publisherName}", style: TextStyle(fontSize: bodyFontSize, color: AppColors.slate)),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  _buildDetailText("Issued to - ${item.issuedTo}", bodyFontSize),
                  _buildDetailText("Library ID - ${item.libraryId}", bodyFontSize),
                  _buildDetailText("Issued Date - ${item.issuedDate}", bodyFontSize),
                  _buildDetailText("Return Date - ${item.returnDate}", bodyFontSize),
                  SizedBox(height: ScreenUtilHelper.height(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delay Fine : ${item.delayFine}", style: TextStyle(fontSize: fineFontSize, fontWeight: FontWeight.w500, color: AppColors.blackHighEmphasis)),
                      Padding(
                        padding: EdgeInsets.only(right: ScreenUtilHelper.width(8)),
                        child: Text("Damage Fine : ${item.damageFine}", style: TextStyle(fontSize: fineFontSize, fontWeight: FontWeight.w500, color: AppColors.blackHighEmphasis)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: ScreenUtilHelper.width(12)),
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
              child: Image.asset(
                item.imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: AppColors.cloud,
                  child: const Icon(Icons.book, color: AppColors.ash),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String text, double fontSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(3)),
      child: Text(text, style: TextStyle(fontSize: fontSize, color: AppColors.stone)),
    );
  }
}