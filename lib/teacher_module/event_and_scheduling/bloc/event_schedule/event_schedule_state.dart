part of 'event_schedule_bloc.dart'; // Links this file to the bloc

// Defines the status of data fetching/processing
enum DataStatus { initial, loading, success, failure }

class EventScheduleState extends Equatable {
  final DataStatus status;
  final int selectedIndex;
  final List<EventModel> events;
  final List<ScheduleModel> schedules;
  final int notificationCount;
  final DateTime plannerFocusedDay;
  final DateTime? plannerSelectedDay; // Allow null for no selection
  final bool isPlannerCalendarVisible;
  final String? errorMessage; // Optional error message

  const EventScheduleState({
    this.status = DataStatus.initial,
    this.selectedIndex = 1, // Default to Schedules
    this.events = const [],
    this.schedules = const [],
    this.notificationCount = 0,
    required this.plannerFocusedDay,
    this.plannerSelectedDay,
    this.isPlannerCalendarVisible = false,
    this.errorMessage,
  });

  // Initial factory constructor
  factory EventScheduleState.initial() {
    return EventScheduleState(
      plannerFocusedDay: DateTime.now(), // Start with current date focused
      notificationCount: 3, // Example initial notification count
    );
  }

  // CopyWith method for immutability
  EventScheduleState copyWith({
    DataStatus? status,
    int? selectedIndex,
    List<EventModel>? events,
    List<ScheduleModel>? schedules,
    int? notificationCount,
    DateTime? plannerFocusedDay,
    DateTime? plannerSelectedDay,
    bool? isPlannerCalendarVisible,
    String? errorMessage,
    bool clearSelectedDay = false, // Helper to explicitly clear selection
    bool clearErrorMessage = false, // Helper to clear errors
  }) {
    return EventScheduleState(
      status: status ?? this.status,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      events: events ?? this.events,
      schedules: schedules ?? this.schedules,
      notificationCount: notificationCount ?? this.notificationCount,
      plannerFocusedDay: plannerFocusedDay ?? this.plannerFocusedDay,
      // Handle clearing selected day explicitly
      plannerSelectedDay:
          clearSelectedDay
              ? null
              : (plannerSelectedDay ?? this.plannerSelectedDay),
      isPlannerCalendarVisible:
          isPlannerCalendarVisible ?? this.isPlannerCalendarVisible,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedIndex,
    events,
    schedules,
    notificationCount,
    plannerFocusedDay,
    plannerSelectedDay,
    isPlannerCalendarVisible,
    errorMessage,
  ];
}
