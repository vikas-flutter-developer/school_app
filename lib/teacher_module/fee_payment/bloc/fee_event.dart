import 'package:equatable/equatable.dart';

abstract class FeesEvent extends Equatable {
  const FeesEvent();

  @override
  List<Object?> get props => [];
}

// Event to load initial data
class FeesLoadInitialData extends FeesEvent {}

// Events for Overview Tab filters
class FeesOverviewFilterChanged extends FeesEvent {
  final String? selectedClass;
  final String? selectedTerm;
  final DateTime? selectedDate;

  const FeesOverviewFilterChanged({
    this.selectedClass,
    this.selectedTerm,
    this.selectedDate,
  });

  @override
  List<Object?> get props => [selectedClass, selectedTerm, selectedDate];
}

// Events for Student Fee Tab filters
class FeesStudentFilterChanged extends FeesEvent {
  final String? selectedType;
  final String? selectedClass;
  final String? selectedTerm;

  const FeesStudentFilterChanged({
    this.selectedType,
    this.selectedClass,
    this.selectedTerm,
  });

  @override
  List<Object?> get props => [selectedType, selectedClass, selectedTerm];
}

// Event for student search
class FeesStudentSearchChanged extends FeesEvent {
  final String query;
  const FeesStudentSearchChanged(this.query);

  @override
  List<Object> get props => [query];
}

// Event for download action (can be expanded later)
class FeesDownloadRequested extends FeesEvent {}
