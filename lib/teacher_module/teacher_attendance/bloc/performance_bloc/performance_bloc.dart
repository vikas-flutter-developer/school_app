import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/models/performance_model.dart' show PerformanceData;
import 'package:equatable/equatable.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  PerformanceBloc() : super(PerformanceInitial()) {
    on<LoadPerformanceData>(_onLoadPerformanceData);
    on<ChangeClass>(_onChangeClass);
    on<ChangeYear>(_onChangeYear);
  }

  Future<void> _onLoadPerformanceData(
    LoadPerformanceData event,
    Emitter<PerformanceState> emit,
  ) async {
    emit(PerformanceLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      final performanceData = PerformanceData(
        selectedClass: 'Class X',
        selectedYear: '2025',
        classes: const [
          'Class X',
          'Class IX',
          'Class VIII',
          'Class VII',
          'Class VI',
        ],
        years: const ['2025', '2024', '2023', '2022'],
      );
      emit(PerformanceLoaded(performanceData));
    } catch (e) {
      emit(PerformanceError(e.toString()));
    }
  }

  Future<void> _onChangeClass(
    ChangeClass event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state is PerformanceLoaded) {
      final currentState = state as PerformanceLoaded;
      emit(
        PerformanceLoaded(
          currentState.performanceData.copyWith(
            selectedClass: event.selectedClass,
          ),
        ),
      );
    }
  }

  Future<void> _onChangeYear(
    ChangeYear event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state is PerformanceLoaded) {
      final currentState = state as PerformanceLoaded;
      emit(
        PerformanceLoaded(
          currentState.performanceData.copyWith(
            selectedYear: event.selectedYear,
          ),
        ),
      );
    }
  }
}
