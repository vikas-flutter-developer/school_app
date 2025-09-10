part of 'performance_bloc.dart';

abstract class PerformanceState extends Equatable {
  const PerformanceState();

  @override
  List<Object> get props => [];
}

class PerformanceInitial extends PerformanceState {}

class PerformanceLoading extends PerformanceState {}

class PerformanceLoaded extends PerformanceState {
  final PerformanceData performanceData;
  const PerformanceLoaded(this.performanceData);

  @override
  List<Object> get props => [performanceData];
}

class PerformanceError extends PerformanceState {
  final String message;
  const PerformanceError(this.message);

  @override
  List<Object> get props => [message];
}
