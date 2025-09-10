import 'package:equatable/equatable.dart';

abstract class BusTracking1Event extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleBusNumberSelection extends BusTracking1Event {}

class SelectBusNumber extends BusTracking1Event {
  final String busNumber;
  SelectBusNumber(this.busNumber);

  @override
  List<Object?> get props => [busNumber];
}
