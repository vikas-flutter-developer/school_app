import 'package:flutter_bloc/flutter_bloc.dart';
import 'bus_tracking1_event.dart';
import 'bus_tracking1_state.dart';

class BusTracking1Bloc extends Bloc<BusTracking1Event, BusTracking1State> {
  BusTracking1Bloc() : super(BusTrackingInitial()) {
    on<ToggleBusNumberSelection>(_onToggleBusNumberSelection);
    on<SelectBusNumber>(_onSelectBusNumber);
  }

  void _onToggleBusNumberSelection(
      ToggleBusNumberSelection event, Emitter<BusTracking1State> emit) {
    if (state is BusNumberSelectionVisible) {
      emit(BusNumberSelectionHidden());
    } else {
      emit(BusNumberSelectionVisible());
    }
  }

  void _onSelectBusNumber(
      SelectBusNumber event, Emitter<BusTracking1State> emit) {
    emit(SelectedBusNumberChanged(event.busNumber));
    emit(BusNumberSelectionHidden()); // Close the dropdown after selection
    // No state change needed here for navigation, the screen will handle it.
  }
}