
import 'package:equatable/equatable.dart';

import '../../data/driver_detail_model.dart';

abstract class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final List<Driver> drivers;
  const DriverLoaded(this.drivers);
  @override
  List<Object> get props => [drivers];
}

class DriverError extends DriverState {
  final String message;
  const DriverError(this.message);
  @override
  List<Object> get props => [message];
}