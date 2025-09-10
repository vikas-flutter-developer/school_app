part of 'timetable_bloc.dart';

enum TimetableStatus { initial, loading, success, failure }

class TimetableState extends Equatable {
  const TimetableState({
    this.status = TimetableStatus.initial,
    this.timetableData, // Can be Map<String, dynamic> or a specific model
    this.selectedDay,   // Example: 1 for Monday, 2 for Tuesday etc.
    this.errorMessage = '',
  });

  final TimetableStatus status;
  final dynamic timetableData; // Consider creating a specific Timetable Model
  final int? selectedDay;
  final String errorMessage;

  TimetableState copyWith({
    TimetableStatus? status,
    dynamic timetableData, // Use dynamic or specific model type
    int? selectedDay,
    String? errorMessage,
  }) {
    return TimetableState(
      status: status ?? this.status,
      // If new timetableData is explicitly null, allow it to be set to null
      timetableData: timetableData, // Simple assignment handles null correctly here if needed
      selectedDay: selectedDay ?? this.selectedDay,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, timetableData, selectedDay, errorMessage];
}