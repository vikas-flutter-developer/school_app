part of 'mail_bloc.dart';

class MailState extends Equatable {
  final String? recipientType;
  final String? selectedClass;
  final String? selectedSection;
  final String? selectedDepartment;
  final String sendVia;
  final bool selectAll;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String title;
  final String message;
  final FormStatus status;

  MailState({
    this.recipientType = 'Parents',
    this.selectedClass,
    this.selectedSection,
    this.selectedDepartment,
    this.sendVia = 'Text',
    this.selectAll = false,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    this.title = '',
    this.message = '',
    this.status = FormStatus.initial,
  }) : selectedDate = selectedDate ?? DateTime.now(),
       selectedTime = selectedTime ?? TimeOfDay.now();

  MailState copyWith({
    String? recipientType,
    String? selectedClass,
    String? selectedSection,
    String? selectedDepartment,
    String? sendVia,
    bool? selectAll,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? title,
    String? message,
    FormStatus? status,
  }) {
    return MailState(
      recipientType: recipientType ?? this.recipientType,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSection: selectedSection ?? this.selectedSection,
      selectedDepartment: selectedDepartment ?? this.selectedDepartment,
      sendVia: sendVia ?? this.sendVia,
      selectAll: selectAll ?? this.selectAll,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    recipientType,
    selectedClass,
    selectedSection,
    selectedDepartment,
    sendVia,
    selectAll,
    selectedDate,
    selectedTime,
    title,
    message,
    status,
  ];
}

enum FormStatus { initial, submitting, success, failure }
