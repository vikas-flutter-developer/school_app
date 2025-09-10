/*import 'dart:async'; // Import async
import 'dart:convert';
import 'dart:io'; // For SocketException

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

// Import your LocalStorageService
import '../../../data/local_storage/local_storage_service.dart';// Adjust path if needed

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  // --- API Base URL (Consider making configurable) ---
  final String _baseUrl = 'https://stage-api-edudibon.trinodepointers.com';

  TimetableBloc({required String apiEndpoint}) : super(const TimetableState()) {
    on<FetchTimetable>(_onFetchTimetable);
    on<ChangeDay>(_onChangeDay);
  }

  Future<void> _onFetchTimetable(
      FetchTimetable event,
      Emitter<TimetableState> emit,
      ) async {
    // Emit loading state, preserving current day if already set
    emit(state.copyWith(status: TimetableStatus.loading));
    print("TimetableBloc: Fetching timetable...");

    try {
      // 1. Fetch the token dynamically
      final String? token = await LocalStorageService.getAuthToken();

      // 2. Check if token exists
      if (token == null || token.isEmpty) {
        print("TimetableBloc: Error - Auth token not found.");
        emit(state.copyWith(
          status: TimetableStatus.failure,
          errorMessage: 'Authentication token not found. Please log in again.',
        ));
        return; // Stop if no token
      }
      print("TimetableBloc: Using token from local storage.");

      // --- API Endpoint Construction ---
      // TODO: The class ID '78' is hardcoded. Make this dynamic if needed.
      // You might need to pass the classId via the FetchTimetable event or get it from user profile.
      final String classId = "78"; // Example: Replace with dynamic value later
      final String api = '$_baseUrl/timetable/class/$classId';
      // --- Hardcoded token removed ---
      // const token = "eyJhbGci...AgSjjA"; // REMOVED

      print("TimetableBloc: Calling API: $api");
      final response = await http.get(
        Uri.parse(api),
        headers: {
          // 3. Use the fetched token
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Keep content-type if required by API
        },
      ).timeout(const Duration(seconds: 20)); // Added timeout

      print("TimetableBloc: API response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("TimetableBloc: Timetable loaded successfully.");
        // Decode JSON safely
        final dynamic responseData = json.decode(response.body);

        // TODO: Validate the structure of responseData if necessary before emitting
        // For example, check if it's a Map or contains expected keys.

        emit(
          state.copyWith(
            status: TimetableStatus.success,
            // Assuming the API directly returns the structure needed by the state
            timetableData: responseData,
            // Keep selectedDay from event or maintain previous if event.dayId is null?
            // If FetchTimetable always includes a dayId:
            selectedDay: event.dayId,
            // If event.dayId might be null and you want to keep the old one:
            // selectedDay: event.dayId ?? state.selectedDay
            errorMessage: '', // Clear previous error on success
          ),
        );
      } else {
        // Handle non-200 status codes
        String errorMsg = 'Failed to load timetable';
        try {
          final errorBody = json.decode(response.body);
          errorMsg = errorBody['message'] ?? errorBody['detail'] ?? 'Failed to load timetable (Status: ${response.statusCode})';
        } catch (_) {}
        print("TimetableBloc: ERROR - Failed to load timetable. Status: ${response.statusCode}. Message: $errorMsg");
        emit(
          state.copyWith(
            status: TimetableStatus.failure,
            errorMessage: errorMsg,
          ),
        );
      }
    } on TimeoutException catch (_) {
      print("TimetableBloc: ERROR - Timeout fetching timetable.");
      emit(state.copyWith(
        status: TimetableStatus.failure,
        errorMessage: 'Request timed out. Check connection.',
      ));
    } on SocketException catch (_) {
      print("TimetableBloc: ERROR - Network error fetching timetable.");
      emit(state.copyWith(
        status: TimetableStatus.failure,
        errorMessage: 'Network error. Could not reach server.',
      ));
    } catch (e) {
      print("TimetableBloc: EXCEPTION - $e");
      emit(
        state.copyWith(
          status: TimetableStatus.failure,
          errorMessage: 'An unexpected error occurred: $e',
        ),
      );
    }
  }

  // Handles changing the selected day locally without refetching (if needed)
  void _onChangeDay(ChangeDay event, Emitter<TimetableState> emit) {
    print("TimetableBloc: Changing selected day to ${event.dayId}");
    // Only update the day if the status is success or initial maybe?
    // Or allow changing day even if loading/error occurred? Assuming allow for now.
    emit(state.copyWith(selectedDay: event.dayId));
  }
}*/
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc() : super(const TimetableState()) {
    on<FetchTimetable>(_onFetchTimetable);
    on<ChangeDay>(_onChangeDay);
  }

  // --- Static Timetable Data ---
  final Map<String, dynamic> _staticTimetableData = {
    "Monday": [
      {"subject": "Math", "time": "09:00 AM - 10:00 AM", "teacher": "Mr. Sharma"},
      {"subject": "Science", "time": "10:15 AM - 11:15 AM", "teacher": "Mrs. Verma"},
      {"subject": "English", "time": "11:30 AM - 12:30 PM", "teacher": "Ms. Kapoor"},
    ],
    "Tuesday": [
      {"subject": "Physics", "time": "09:00 AM - 10:00 AM", "teacher": "Mr. Rao"},
      {"subject": "Chemistry", "time": "10:15 AM - 11:15 AM", "teacher": "Mrs. Gupta"},
      {"subject": "Biology", "time": "11:30 AM - 12:30 PM", "teacher": "Ms. Das"},
    ],
    "Wednesday": [
      {"subject": "History", "time": "09:00 AM - 10:00 AM", "teacher": "Mr. Singh"},
      {"subject": "Geography", "time": "10:15 AM - 11:15 AM", "teacher": "Mrs. Roy"},
      {"subject": "Civics", "time": "11:30 AM - 12:30 PM", "teacher": "Ms. Jain"},
    ],
  };

  Future<void> _onFetchTimetable(
      FetchTimetable event,
      Emitter<TimetableState> emit,
      ) async {
    emit(state.copyWith(status: TimetableStatus.loading));

    await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay

    emit(state.copyWith(
      status: TimetableStatus.success,
      timetableData: _staticTimetableData,
      selectedDay: event.dayId,
      errorMessage: '',
    ));
  }

  void _onChangeDay(ChangeDay event, Emitter<TimetableState> emit) {
    emit(state.copyWith(selectedDay: event.dayId));
  }
}
