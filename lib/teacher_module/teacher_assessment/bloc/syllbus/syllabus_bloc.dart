import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/syllbus/syllabus_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/syllabus_model.dart';

part 'syllabus_event.dart';

class SyllabusBloc extends Bloc<SyllabusEvent, SyllabusState> {
  SyllabusBloc() : super(SyllabusInitial()) {
    on<LoadSyllabus>(_onLoadSyllabus);
    on<FilterSyllabus>(_onFilterSyllabus);
  }

  Future<void> _onLoadSyllabus(
    LoadSyllabus event,
    Emitter<SyllabusState> emit,
  ) async {
    emit(SyllabusLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      final syllabusItems = [
        SyllabusItems(
          id: '1', // Added an ID for navigation
          title: "Chemical Bonds",
          description:
              "Lorem Ipsum is simply dummy text\nof the printing and typesetting industry...",
          progress: 0.5,
          color: const Color.fromRGBO(183, 180, 226, 1),
        ),
        SyllabusItems(
          id: '2', // Added an ID for navigation
          title: "Science",
          description:
              "Lorem Ipsum is simply dummy text of the printing andtypesetting industry...",
          progress: 0.7,
          color: const Color.fromRGBO(241, 209, 134, 1),
        ),
        SyllabusItems(
          id: '3', // Added an ID for navigation
          title: "Mathematics",
          description:
              "Lorem Ipsum is simply dummy text of the printing and  typesetting industry...",
          progress: 0.2,
          color: const Color.fromRGBO(171, 222, 227, 1),
        ),
      ];
      emit(SyllabusLoaded(syllabusItems: syllabusItems));
    } catch (e) {
      emit(SyllabusError(message: e.toString()));
    }
  }

  Future<void> _onFilterSyllabus(
    FilterSyllabus event,
    Emitter<SyllabusState> emit,
  ) async {
    if (state is SyllabusLoaded) {
      final currentState = state as SyllabusLoaded;
      // Implement filtering logic here
      emit(currentState.copyWith(filter: event.filter));
    }
  }
}
