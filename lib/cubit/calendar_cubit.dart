import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/api/api_services.dart' show CalendarApiService;
import 'calendar_state.dart';


class CalendarCubit extends Cubit<CalendarState> {
  final CalendarApiService apiService;

  CalendarCubit(this.apiService) : super(CalendarInitial());

  Future<void> fetchCalendarData() async {
    emit(CalendarLoading());

    try {
      final calendarData = await apiService.fetchCalendar();
      final upcomingEvents = await apiService.fetchUpcomingEvents();

      Map<DateTime, List<String>> eventsByMonth = {};

      for (var item in calendarData) {
        DateTime date = DateTime.parse(item['cdate']);
        eventsByMonth.putIfAbsent(date, () => []);
      }

      for (var item in upcomingEvents) {
        DateTime date = DateTime.parse(item['cdate']);
        if (eventsByMonth.containsKey(date)) {
          eventsByMonth[date]!.add(item['name']);
        }
      }

      emit(CalendarLoaded(eventsByMonth));
    } catch (e) {
      emit(CalendarError("Failed to load calendar"));
    }
  }
}
