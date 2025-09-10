part of 'performance_bloc.dart';

abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();

  @override
  List<Object> get props => [];
}

class LoadPerformanceData extends PerformanceEvent {
  const LoadPerformanceData();
}

class ChangeClass extends PerformanceEvent {
  final String selectedClass;
  const ChangeClass(this.selectedClass);

  @override
  List<Object> get props => [selectedClass];
}

class ChangeYear extends PerformanceEvent {
  final String selectedYear;
  const ChangeYear(this.selectedYear);

  @override
  List<Object> get props => [selectedYear];
}
