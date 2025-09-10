// bloc/master_data/master_data_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'master_data_event.dart';
part 'master_data_state.dart';

class MasterDataBloc extends Bloc<MasterDataEvent, MasterDataState> {
  MasterDataBloc() : super(const MasterDataState()) {
    on<BottomNavTapped>(_onBottomNavTapped);
    // Optional: Handle navigation event
    // on<NavigateToRequested>(_onNavigateToRequested);
  }

  void _onBottomNavTapped(BottomNavTapped event, Emitter<MasterDataState> emit) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

// Optional: Handler if using BLoC for navigation trigger
// void _onNavigateToRequested(NavigateToRequested event, Emitter<MasterDataState> emit) {
//   emit(state.copyWith(navigationTarget: event.destination));
//   emit(state.copyWith(clearNavigationTarget: true)); // Reset immediately
// }
}