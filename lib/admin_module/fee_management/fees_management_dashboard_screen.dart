// screens/fees_management_dashboard_screen.dart
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/utils/app_colors.dart';
import 'bloc/fees_management_dashboard_bloc.dart';
import 'fees_dues_screen.dart';
import 'fees_structure_screen.dart';


const _gradient1 = [Color(0xFFB2FF59), Color(0xFFE6EE9C)]; // Light Greenish
const _gradient2 = [Color(0xFFFFD180), Color(0xFFFFE0B2)]; // Light Orange
const _gradient3 = [Color(0xFFE1BEE7), Color(0xFFF3E5F5)]; // Light Purple/Pinkish


class FeesManagementDashboardScreen extends StatelessWidget {
  const FeesManagementDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the BLoC provider uses the correct path
    return BlocProvider(
      create: (context) => FeesManagementDashboardBloc(), // Make sure BLoC exists at this path
      child: const FeesManagementDashboardView(),
    );
  }
}

class FeesManagementDashboardView extends StatelessWidget {
  const FeesManagementDashboardView({super.key});

  // Helper function for navigation
  void _navigateTo(BuildContext context, String routeName) {
    String route;
    switch (routeName) {
      case 'fees_dues':
        context.push(AppRoutes.feeDues);
        break;
      case 'fees_structure':
        context.push(AppRoutes.feeStructure);
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    // Responsive values (Keep these as they were)
    final double hPadding = screenSize.width * 0.04;
    final double vPadding = screenSize.height * 0.015;
    final double titleFontSize = isSmallScreen ? 18 : 21;
    final double sectionTitleFontSize = isSmallScreen ? 15 : 17;
    final double cardValueFontSize = isSmallScreen ? 22 : 26;
    final double cardLabelFontSize = isSmallScreen ? 11 : 12;
    final double chartHeight = screenSize.height * 0.22;
    final double chartLabelSize = isSmallScreen ? 9 : 10;


    return BlocListener<FeesManagementDashboardBloc, FeesManagementDashboardState>(
      listener: (context, state) {
        if (state.navigationTarget != null) {
          _navigateTo(context, state.navigationTarget!);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context, titleFontSize),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<FeesManagementDashboardBloc>().add(LoadDashboardData());
            await context.read<FeesManagementDashboardBloc>().stream.firstWhere((state) => state.status != DashboardStatus.loading);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: vPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(context, hPadding, vPadding, 50, 14),
                _buildHeaderRow(context, hPadding, vPadding, sectionTitleFontSize),
                SizedBox(height: vPadding),
                _buildTodaysUpdates(context, hPadding, vPadding, cardValueFontSize, cardLabelFontSize),
                SizedBox(height: vPadding * 1.5),
                _buildChartSection(context, 'Last 15 days collection', hPadding, sectionTitleFontSize, chartHeight, chartLabelSize, _gradient1, (state) => state.dashboardData.last15DaysData, 15),
                _buildChartSection(context, 'Month wise Fee collection', hPadding, sectionTitleFontSize, chartHeight, chartLabelSize, _gradient2, (state) => state.dashboardData.monthWiseData, 15),
                _buildChartSection(context, 'Year wise collection', hPadding, sectionTitleFontSize, chartHeight, chartLabelSize, _gradient3, (state) => state.dashboardData.yearWiseData, 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Keep all the _build... helper methods exactly as they were in the previous answer ---
  // _buildAppBar, _buildSearchBar, _buildHeaderRow, _buildTodaysUpdates,
  // _buildDashboardCard, _buildChartSection, _buildAreaChart
  // (Paste them here from the previous response if needed)

  AppBar _buildAppBar(BuildContext context, double titleFontSize) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.blackHighEmphasis),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        'Fees Management',
        style: GoogleFonts.openSans(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: titleFontSize,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppColors.blackHighEmphasis),
          onPressed: ()=>context.push(AppRoutes.notifications),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, double hPadding, double vPadding, double height, double fontSize) {
    // Re-usable search bar
    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, vPadding * 0.5, hPadding, vPadding * 0.5),
      child: SizedBox(
        height: height,
        child: TextField(
          // Add controller and onChanged if search needs to function
          style: GoogleFonts.openSans(fontSize: fontSize, color: AppColors.blackHighEmphasis),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.8), fontSize: fontSize),
            prefixIcon: const Icon(Icons.search, color: AppColors.ash),
            suffixIcon: const Icon(Icons.mic, color: AppColors.ash),
            filled: true,
            fillColor: AppColors.parchment,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none, // No focus border in image
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context, double hPadding, double vPadding, double fontSize) {
    // fontSize here refers to the section title font size
    final double dropdownFontSize = fontSize * 0.85; // Slightly smaller for dropdown
    final double dropdownHeight = 38; // Consistent height for the dropdown

    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, vPadding, hPadding, vPadding * 0.5), // Adjust vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Keep main axis alignment
        crossAxisAlignment: CrossAxisAlignment.end, // Align items to the bottom of the row
        children: [
          // Left side: Title and Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Take minimum vertical space
            children: [
              Text(
                'Fee Dashboard',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize, // Use the passed section title size
                  color: AppColors.blackHighEmphasis,
                ),
              ),
              SizedBox(height: vPadding * 0.3), // Space between title and dropdown
              // Dropdown for Academic Year
              BlocBuilder<FeesManagementDashboardBloc, FeesManagementDashboardState>(
                builder: (context, state) {
                  return Container(
                    height: dropdownHeight,
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4), // Constrain width
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.silver, width: 1.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.selectedAcademicYear,
                        icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.ash),
                        elevation: 2,
                        style: GoogleFonts.openSans(color: AppColors.blackHighEmphasis, fontSize: dropdownFontSize),
                        dropdownColor: AppColors.white,
                        onChanged: (String? newValue) {
                          context.read<FeesManagementDashboardBloc>().add(AcademicYearSelected(newValue));
                        },
                        items: state.academicYearOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, overflow: TextOverflow.ellipsis), // Handle potential overflow
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // Right side: Popup Menu Button
          // Adding Padding to align it better vertically if needed, or rely on CrossAxisAlignment.end
          Padding(
            padding: EdgeInsets.only(bottom: (dropdownHeight - 24)/2), // Adjust padding to center icon relative to dropdown roughly
            child: PopupMenuButton<String>(
              onSelected: (String result) {
                // context.read<FeesManagementDashboardBloc>().add(NavigateRequested(result));
                if(result=='fees_dues') context.push(AppRoutes.feeDues);
                if(result=='fees_structure') context.push(AppRoutes.feeStructure);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'fees_dues',
                  height: 35,
                  child: Text('Fee Dues', style: GoogleFonts.openSans(fontSize: dropdownFontSize)),
                ),
                PopupMenuItem<String>(
                  value: 'fees_structure',
                  height: 35,
                  child: Text('Fees Structure', style: GoogleFonts.openSans(fontSize: dropdownFontSize)),
                ),
              ],
              icon: const Icon(Icons.more_vert, color: AppColors.blackHighEmphasis),
              tooltip: "Options",
              offset: const Offset(0, 35), // Adjust offset slightly
              padding: EdgeInsets.zero,
              splashRadius: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Style menu itself
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysUpdates(BuildContext context, double hPadding, double vPadding, double valueSize, double labelSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Updates",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: valueSize * 0.7,
              color: AppColors.blackHighEmphasis,
            ),
          ),
          SizedBox(height: vPadding * 0.8), // Slightly less space
          BlocBuilder<FeesManagementDashboardBloc, FeesManagementDashboardState>(
            builder: (context, state) {
              final data = state.dashboardData;
              return Row( // Use Row for the top 3 items
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space them out
                children: [
                  _buildDashboardCard('Receipt Created', data.receiptsCreated, valueSize, labelSize),
                  _buildDashboardCard('Receipt Cancelled', data.receiptsCancelled, valueSize, labelSize),
                  _buildDashboardCard('Discount Given', data.discountGiven, valueSize, labelSize),
                ],
              );
            },
          ),
          SizedBox(height: vPadding * 1.2), // Space before the next row
          BlocBuilder<FeesManagementDashboardBloc, FeesManagementDashboardState>(
            builder: (context, state) {
              final data = state.dashboardData;
              return Row( // Use another Row for the bottom 2 items
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align them similar to top row
                children: [
                  _buildDashboardCard('Fine collected', data.fineCollected, valueSize, labelSize),
                  _buildDashboardCard('Total Collection', data.totalCollection, valueSize, labelSize),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Updated Dashboard Card - Removed width calculation, relies on Row spacing
  Widget _buildDashboardCard(String label, String value, double valueSize, double labelSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, // Align text left
      children: [
        Text(
          value,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: valueSize,
            color:AppColors.primaryMedium,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10), // Reduced space
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 12,
            color: AppColors.blackHighEmphasis,
            fontWeight: FontWeight.w500
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Reusable Chart Section Builder - No changes needed here
  Widget _buildChartSection(BuildContext context, String title, double hPadding, double titleSize, double chartHeight, double labelSize, List<Color> gradientColors, List<FlSpot> Function(FeesManagementDashboardState) dataSelector, int maxX) {
    return Padding(
      padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: titleSize,
              color: AppColors.blackHighEmphasis,
            ),
          ),
          SizedBox(height: 8),
          BlocBuilder<FeesManagementDashboardBloc, FeesManagementDashboardState>(
            buildWhen: (prev, curr) => dataSelector(prev) != dataSelector(curr) || prev.status != curr.status,
            builder: (context, state) {
              if (state.status == DashboardStatus.loading) {
                return SizedBox(height: chartHeight, child: const Center(child: CircularProgressIndicator(strokeWidth: 2)));
              }
              final chartData = dataSelector(state);
              if (chartData.isEmpty) {
                return SizedBox(height: chartHeight, child: Center(child: Text('No data available', style: GoogleFonts.openSans(color: AppColors.ash))));
              }
              return SizedBox(
                height: chartHeight,
                child: _buildAreaChart(chartData, gradientColors, labelSize, maxX),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        ],
      ),
    );
  }

  // Reusable Area Chart Widget using fl_chart - No changes needed here
  Widget _buildAreaChart(List<FlSpot> data, List<Color> gradientColors, double labelSize, int maxX) {
    // ... (Keep the exact implementation from the previous answer) ...
    return LineChart(
      LineChartData(
        minY: 0, // Start Y axis at 0
        maxY: 10, // Max Y axis at 10 as per image
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false, // No vertical grid lines
          horizontalInterval: 2, // Interval for horizontal lines (0, 2, 4, 6, 8, 10)
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.cloud,
              strokeWidth: 1,
              dashArray: [3, 3], // Dashed lines
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          // Hide top titles
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Configure Right (Y-axis) Titles
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25, // Space for labels
              interval: 2, // Match grid interval
              getTitlesWidget: (double value, TitleMeta meta) {
                // Only show labels for the intervals
                if (value == meta.min || value == meta.max || value % 2 == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0), // Padding from chart edge
                    child: Text(
                      value.toInt().toString(),
                      style: GoogleFonts.openSans(
                        color: AppColors.blackHighEmphasis,
                        fontWeight: FontWeight.w500,
                        fontSize: labelSize,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  );
                }
                return Container(); // Don't show label otherwise
              },
            ),
          ),
          // Hide Left titles
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Configure Bottom (X-axis) Titles
          // Configure Bottom (X-axis) Titles
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25, // Space for labels
              interval: 1, // Show label for each integer X value
              getTitlesWidget: (double value, TitleMeta meta) {
                // Show only integer labels, adjust interval based on maxX
                int displayValue = value.toInt();
                // Control label density: only show every other label for larger ranges
                if (maxX > 10 && displayValue % 2 != 0 && displayValue != 1) {
                  return Container(); // Hide odd labels (except 1)
                }
                if (value == displayValue && value > 0) { // Avoid showing 0 if not needed
                  return SideTitleWidget(
                    meta: meta, // Corrected line: pass the entire meta object
                    space: 4.0,
                    child: Text(
                      displayValue.toString(),
                      style: GoogleFonts.openSans(
                        color: AppColors.blackHighEmphasis,
                        fontWeight: FontWeight.w500,
                        fontSize: labelSize,
                      ),
                    ),
                  );
                }
                return Container(); // Hide non-integer or 0 labels
              },
            ),
          ),
          // bottomTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     reservedSize: 25, // Space for labels
          //     interval: 1, // Show label for each integer X value
          //     getTitlesWidget: (double value, TitleMeta meta) {
          //       // Show only integer labels, adjust interval based on maxX
          //       int displayValue = value.toInt();
          //       // Control label density: only show every other label for larger ranges
          //       if (maxX > 10 && displayValue % 2 != 0 && displayValue != 1) {
          //         return Container(); // Hide odd labels (except 1)
          //       }
          //       if (value == displayValue && value > 0) { // Avoid showing 0 if not needed
          //         return SideTitleWidget(
          //           axisSide: meta.axisSide,
          //           space: 4.0,
          //           child: Text(
          //             displayValue.toString(),
          //             style: GoogleFonts.openSans(
          //               color: AppColors.blackHighEmphasis,
          //               fontWeight: FontWeight.w500,
          //               fontSize: labelSize,
          //             ),
          //           ),
          //         );
          //       }
          //       return Container(); // Hide non-integer or 0 labels
          //     },
          //   ),
          // ),
        ),
        borderData: FlBorderData(show: false), // Hide outer border
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true, // Smooth curve
            isStrokeCapRound: true,
            barWidth: 2.5, // Line thickness
            color: gradientColors.first.withOpacity(0.8), // Main line color
            dotData: const FlDotData(show: false), // Hide dots on the line
            belowBarData: BarAreaData( // Area fill
              show: true,
              gradient: LinearGradient(
                colors: gradientColors.map((color) => color.withOpacity(0.4)).toList(), // Apply opacity
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: const LineTouchData(enabled: false), // Disable touch interaction
      ),
    );
  }

}
