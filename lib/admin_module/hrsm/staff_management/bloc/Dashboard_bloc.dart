

import 'package:bloc/bloc.dart';

import '../model/Dasboard_model.dart';
import 'Dashboard_event.dart';
import 'Dashboard_state.dart';
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<LoadDashboardData>((event, emit) {
      // Replace with real data source or repository fetch
      final stats = DashboardStats(
        totalEmployees: 480,
        present: 400,
        absent: 80,
        newJoins: 5,
        halfDay: 5,
      );
      emit(DashboardLoaded(stats));
    });
  }
}
