import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  MailBloc() : super(MailState()) {
    on<RecipientTypeChanged>(_onRecipientTypeChanged);
    on<ClassChanged>(_onClassChanged);
    on<SectionChanged>(_onSectionChanged);
    on<DepartmentChanged>(_onDepartmentChanged);
    on<SendViaChanged>(_onSendViaChanged);
    on<SelectAllChanged>(_onSelectAllChanged);
    on<DateChanged>(_onDateChanged);
    on<TimeChanged>(_onTimeChanged);
    on<TitleChanged>(_onTitleChanged);
    on<MessageChanged>(_onMessageChanged);
    on<SendMessage>(_onSendMessage);
    on<ScheduleMessage>(_onScheduleMessage);

    add(const RecipientTypeChanged('All'));
  }

  void _onRecipientTypeChanged(
    RecipientTypeChanged event,
    Emitter<MailState> emit,
  ) {
    String? newRecipientType = event.recipientType;
    String? newClass;
    String? newSection;
    String? newDepartment;
    String newSendVia = state.sendVia; // Start with current sendVia

    if (newRecipientType == 'Teachers') {
      newClass = null;
      newSection = null;
      newDepartment = 'Science'; // Default department
      newSendVia = 'Email'; // Teachers default to Email
    } else if (newRecipientType == 'Parents') {
      newDepartment = null;
      newClass = 'Class VI'; // Default class/section
      newSection = 'A';
      newSendVia = 'Text'; // Parents default to Text
    } else if (newRecipientType == 'All') {
      newDepartment = null;
      newClass = null;
      newSection = null;
      newSendVia = 'Email'; // 'All' defaults to Email
    }
    // If newRecipientType is null or not one of the above, fields retain current/previous values or become null
    // and newSendVia retains state.sendVia unless explicitly changed.
    // However, for safety, if newRecipientType is explicitly null, you might want defined behavior.
    // For this use case, RecipientTypeChanged event always sends a non-null string.

    emit(
      state.copyWith(
        recipientType: newRecipientType,
        selectedClass:
            newClass, // will be null if not Parents or Teachers (based on above)
        selectedSection: newSection, // will be null if not Parents or Teachers
        selectedDepartment: newDepartment, // will be null if not Teachers
        sendVia: newSendVia,
      ),
    );
  }

  void _onClassChanged(ClassChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectedClass: event.selectedClass));
  }

  void _onSectionChanged(SectionChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectedSection: event.selectedSection));
  }

  void _onDepartmentChanged(DepartmentChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectedDepartment: event.selectedDepartment));
  }

  void _onSendViaChanged(SendViaChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(sendVia: event.sendVia));
  }

  void _onSelectAllChanged(SelectAllChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectAll: event.selectAll));
  }

  void _onDateChanged(DateChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  void _onTimeChanged(TimeChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(selectedTime: event.selectedTime));
  }

  void _onTitleChanged(TitleChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onMessageChanged(MessageChanged event, Emitter<MailState> emit) {
    emit(state.copyWith(message: event.message));
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<MailState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting));
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }

  Future<void> _onScheduleMessage(
    ScheduleMessage event,
    Emitter<MailState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting));
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
