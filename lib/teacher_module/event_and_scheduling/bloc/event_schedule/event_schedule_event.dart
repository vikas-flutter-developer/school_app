part of 'event_schedule_bloc.dart'; // Links this file to the bloc

// Base abstract event class using Equatable for value comparison
abstract class EventScheduleEvent extends Equatable {
  const EventScheduleEvent();

  // Override props for Equatable comparison if the event has properties
  @override
  List<Object?> get props => [];
}

// --- Specific Event Definitions ---

// Event to trigger loading initial data (events, schedules)
class LoadInitialData extends EventScheduleEvent {} // No properties needed

// Event dispatched when the user selects a different tab
class TabChanged extends EventScheduleEvent {
  final int newIndex; // The index of the newly selected tab

  const TabChanged(this.newIndex);

  // Include newIndex in props for Equatable comparison
  @override
  List<Object?> get props => [newIndex];
}

// Event dispatched when the user navigates to the previous/next month in the planner
class PlannerMonthChanged extends EventScheduleEvent {
  final bool isNext; // true for next month, false for previous month

  const PlannerMonthChanged({required this.isNext});

  // Include isNext in props for Equatable comparison
  @override
  List<Object?> get props => [isNext];
}

// Event dispatched when the user taps the calendar icon to show/hide the full calendar view
class PlannerToggleCalendarVisibility
    extends EventScheduleEvent {} // No properties needed

// Event dispatched when the user selects a specific date from the planner's calendar grid
class PlannerDateSelected extends EventScheduleEvent {
  // The date selected by the user.
  final DateTime selectedDate;

  const PlannerDateSelected(this.selectedDate);

  // Include selectedDate in props for Equatable comparison
  @override
  List<Object?> get props => [selectedDate];
}

// Add events for Search and Filter later if needed
// class SearchQueryChanged extends EventScheduleEvent { ... }
// class FilterApplied extends EventScheduleEvent { ... }
