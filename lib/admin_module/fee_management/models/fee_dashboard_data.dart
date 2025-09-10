// models/fee_dashboard_data.dart
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class FeeDashboardData extends Equatable {
  final String receiptsCreated;
  final String receiptsCancelled;
  final String discountGiven;
  final String fineCollected;
  final String totalCollection;
  final List<FlSpot> last15DaysData;
  final List<FlSpot> monthWiseData;
  final List<FlSpot> yearWiseData;

  const FeeDashboardData({
    this.receiptsCreated = '0',
    this.receiptsCancelled = '0',
    this.discountGiven = '0',
    this.fineCollected = '0',
    this.totalCollection = '0',
    this.last15DaysData = const [],
    this.monthWiseData = const [],
    this.yearWiseData = const [],
  });

  @override
  List<Object?> get props => [
    receiptsCreated, receiptsCancelled, discountGiven, fineCollected, totalCollection,
    last15DaysData, monthWiseData, yearWiseData,
  ];
}

// Dummy Data for Dashboard
const FeeDashboardData dummyDashboardData = FeeDashboardData(
  receiptsCreated: '20',
  receiptsCancelled: '45',
  discountGiven: '20',
  fineCollected: '2k', // Keep as string to match UI
  totalCollection: '20.5k', // Keep as string
  last15DaysData: [ // X: Day (1-15), Y: Value (0-10)
    FlSpot(1, 2), FlSpot(2, 2.5), FlSpot(3, 2.2), FlSpot(4, 3), FlSpot(5, 4),
    FlSpot(6, 4.5), FlSpot(7, 5), FlSpot(8, 5.2), FlSpot(9, 6), FlSpot(10, 6.5),
    FlSpot(11, 7), FlSpot(12, 7.8), FlSpot(13, 8), FlSpot(14, 8.5), FlSpot(15, 8.8),
  ],
  monthWiseData: [ // X: Day of Month (approx), Y: Value
    FlSpot(1, 1), FlSpot(2, 1.5), FlSpot(3, 1.8), FlSpot(4, 2.5), FlSpot(5, 3.5),
    FlSpot(6, 4), FlSpot(7, 4.8), FlSpot(8, 5.5), FlSpot(9, 6.2), FlSpot(10, 6),
    FlSpot(11, 5.8), FlSpot(12, 6.5), FlSpot(13, 7), FlSpot(14, 7.5), FlSpot(15, 7.2),
  ],
  yearWiseData: [ // X: Month (1-12), Y: Value
    FlSpot(1, 3), FlSpot(2, 3.5), FlSpot(3, 4), FlSpot(4, 5), FlSpot(5, 6),
    FlSpot(6, 7), FlSpot(7, 6.5), FlSpot(8, 6), FlSpot(9, 6.8), FlSpot(10, 7.5),
    FlSpot(11, 8), FlSpot(12, 7.8),
  ],
);