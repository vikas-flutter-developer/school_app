import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Models are needed here because they are used in the state and hardcoded data
// Make sure this path is correct for your project structure
import '../../models/event_model.dart';
import '../../models/schedule_model.dart';

// Use part directives to link event and state files
part 'event_schedule_event.dart';
part 'event_schedule_state.dart';

class EventScheduleBloc extends Bloc<EventScheduleEvent, EventScheduleState> {
  // Constructor: Set initial state and register all event handlers.
  // Dispatch the initial data loading event right after setting up handlers.
  EventScheduleBloc() : super(EventScheduleState.initial()) {
    // --- Register Event Handlers FIRST ---
    // It's crucial that handlers are registered before any event might be added.

    // Handler for loading initial data
    on<LoadInitialData>(_onLoadInitialData);

    // Handler for changing tabs
    on<TabChanged>(_onTabChanged);

    // Handler for changing planner month
    on<PlannerMonthChanged>(_onPlannerMonthChanged);

    // Handler for toggling planner calendar visibility
    on<PlannerToggleCalendarVisibility>(_onPlannerToggleCalendarVisibility);

    // Handler for selecting a date in the planner
    on<PlannerDateSelected>(_onPlannerDateSelected);

    // --- Dispatch Initial Event AFTER Registering Handlers ---
    // Now that the handler for LoadInitialData is registered, we can safely add the event.
    add(LoadInitialData());
  }

  // --- Event Handler Definitions ---

  // Handles the LoadInitialData event to fetch initial events and schedules
  Future<void> _onLoadInitialData(
    LoadInitialData event,
    Emitter<EventScheduleState> emit,
  ) async {
    // Emit loading state immediately
    emit(state.copyWith(status: DataStatus.loading));
    try {
      // Simulate fetching data (replace with actual network/db calls)
      await Future.delayed(
        const Duration(milliseconds: 100),
      ); // Slightly longer simulation

      // Get hardcoded data (replace with actual fetched data)
      final events = _getHardcodedEvents();
      final schedules = _getHardcodedSchedules();

      // Emit success state with the fetched data
      emit(
        state.copyWith(
          status: DataStatus.success,
          events: events,
          schedules: schedules,
          clearErrorMessage:
              true, // Clear any previous error message on success
        ),
      );
    } catch (e) {
      // Emit failure state if an error occurs during fetching
      emit(
        state.copyWith(status: DataStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // Handles the TabChanged event to update the selected tab index
  void _onTabChanged(TabChanged event, Emitter<EventScheduleState> emit) {
    emit(state.copyWith(selectedIndex: event.newIndex));
  }

  // Handles the PlannerMonthChanged event to update the focused month in the planner
  void _onPlannerMonthChanged(
    PlannerMonthChanged event,
    Emitter<EventScheduleState> emit,
  ) {
    final currentMonth = state.plannerFocusedDay;
    // Calculate the first day of the next or previous month
    final newMonth = DateTime(
      currentMonth.year,
      event.isNext ? currentMonth.month + 1 : currentMonth.month - 1,
      1, // Always go to the first day
    );
    // Update the focused day and clear any selected day from the previous month view
    emit(state.copyWith(plannerFocusedDay: newMonth, clearSelectedDay: true));
  }

  // Handles the PlannerToggleCalendarVisibility event to show/hide the calendar overlay
  void _onPlannerToggleCalendarVisibility(
    PlannerToggleCalendarVisibility event,
    Emitter<EventScheduleState> emit,
  ) {
    emit(
      state.copyWith(isPlannerCalendarVisible: !state.isPlannerCalendarVisible),
    );
  }

  // Handles the PlannerDateSelected event when a user picks a date from the calendar
  void _onPlannerDateSelected(
    PlannerDateSelected event,
    Emitter<EventScheduleState> emit,
  ) {
    // Update both focused and selected day to the chosen date
    // Hide the calendar overlay after selection
    emit(
      state.copyWith(
        plannerFocusedDay: event.selectedDate,
        plannerSelectedDay: event.selectedDate,
        isPlannerCalendarVisible: false,
      ),
    );
  }

  // --- Helper Methods for Hardcoded Data (Replace with real data source later) ---

  List<EventModel> _getHardcodedEvents() {
    return [
      const EventModel(
        imagePath:
            'assets/images/event2.png', // Ensure this path is correct & declared in pubspec.yaml
        title: "Interschool Painting Competition",
        venue: "Mariyam school",
        date: "14/03/25",
        registrationLink: "https://formsgoogle.com/",
        interestedCount: 67,
        notInterestedCount: 12,
        volunteerCount: 12,
      ),
      const EventModel(
        imagePath:
            'assets/images/event1.png', // Ensure this path is correct & declared in pubspec.yaml
        title: "Interschool Science Fair",
        venue: "Mariyam school",
        date: "15/03/25",
        registrationLink: "https://formsgoogle.com/science",
        interestedCount: 89,
        notInterestedCount: 5,
        volunteerCount: 15,
      ),
    ];
  }

  List<ScheduleModel> _getHardcodedSchedules() {
    return [
      const ScheduleModel(
        time: "09:00 AM",
        day: "AM",
        date: "15/03/2025",
        title: "Teachers meeting",
        venue: "Venue : Meeting Hall",
      ),
      const ScheduleModel(
        time: "10:30 AM",
        day: "AM",
        date: "16/03/2025",
        title: "Student Council Meet",
        venue: "Venue : Auditorium",
      ),
    ];
  }
}
