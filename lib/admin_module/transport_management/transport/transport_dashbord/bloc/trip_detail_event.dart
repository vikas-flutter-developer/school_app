
import 'package:equatable/equatable.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();
  @override
  List<Object> get props => [];
}

class FetchTripHistory extends TripDetailsEvent {
  final String driverId;
  const FetchTripHistory(this.driverId);
  @override
  List<Object> get props => [driverId];
}