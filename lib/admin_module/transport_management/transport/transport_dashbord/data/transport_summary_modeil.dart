import 'package:equatable/equatable.dart';

class TransportSummary extends Equatable {
  final int totalBuses;
  final int activeBuses;
  final int inactiveBuses;

  const TransportSummary({
    required this.totalBuses,
    required this.activeBuses,
    required this.inactiveBuses,
  });

  @override
  List<Object?> get props => [totalBuses, activeBuses, inactiveBuses];
}