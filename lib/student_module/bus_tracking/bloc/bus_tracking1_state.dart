import 'package:equatable/equatable.dart';

abstract class BusTracking1State extends Equatable {
  @override
  List<Object?> get props => [];
}

class BusTrackingInitial extends BusTracking1State {}

class BusNumberSelectionVisible extends BusTracking1State {}

class BusNumberSelectionHidden extends BusTracking1State {}

class SelectedBusNumberChanged extends BusTracking1State {
  final String selectedBusNumber;
  SelectedBusNumberChanged(this.selectedBusNumber);

  @override
  List<Object?> get props => [selectedBusNumber];
}
