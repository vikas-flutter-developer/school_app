part of 'transport_dashboard_bloc.dart';

abstract class TransportDashboardEvent extends Equatable {
  const TransportDashboardEvent();

  @override
  List<Object> get props => [];
}

// डैशबोर्ड का डेटा लाने के लिए इवेंट
class FetchTransportSummary extends TransportDashboardEvent {}