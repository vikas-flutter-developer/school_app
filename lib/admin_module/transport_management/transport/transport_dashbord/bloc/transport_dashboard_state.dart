part of 'transport_dashboard_bloc.dart';

abstract class TransportDashboardState extends Equatable {
  const TransportDashboardState();

  @override
  List<Object> get props => [];
}

class TransportDashboardInitial extends TransportDashboardState {}

class TransportDashboardLoading extends TransportDashboardState {}

class TransportDashboardLoaded extends TransportDashboardState {
  final TransportSummary summary;

  const TransportDashboardLoaded(this.summary);

  @override
  List<Object> get props => [summary];
}

class TransportDashboardError extends TransportDashboardState {
  final String message;

  const TransportDashboardError(this.message);

  @override
  List<Object> get props => [message];
}