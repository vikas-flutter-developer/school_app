import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/transport_summary_modeil.dart';

part 'transport_dashboard_event.dart';
part 'transport_dashboard_state.dart';

class TransportDashboardBloc extends Bloc<TransportDashboardEvent, TransportDashboardState> {
  TransportDashboardBloc() : super(TransportDashboardInitial()) {
    on<FetchTransportSummary>(_onFetchTransportSummary);
  }

  Future<void> _onFetchTransportSummary(
      FetchTransportSummary event,
      Emitter<TransportDashboardState> emit,
      ) async {
    emit(TransportDashboardLoading());
    try {
      // API कॉल की जगह डमी डेटा
      await Future.delayed(const Duration(seconds: 1));
      const summaryData = TransportSummary(
        totalBuses: 50,
        activeBuses: 45,
        inactiveBuses: 5,
      );
      emit(TransportDashboardLoaded(summaryData));
    } catch (e) {
      emit(TransportDashboardError("Failed to load summary data."));
    }
  }
}