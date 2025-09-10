part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class RecipientTypeChanged extends MessageEvent {
  final String? recipientType;
  const RecipientTypeChanged(this.recipientType);
}

class ClassChanged extends MessageEvent {
  final String? selectedClass;
  const ClassChanged(this.selectedClass);
}

class SectionChanged extends MessageEvent {
  final String? selectedSection;
  const SectionChanged(this.selectedSection);
}

class DepartmentChanged extends MessageEvent {
  final String? selectedDepartment;
  const DepartmentChanged(this.selectedDepartment);
}

class SendViaChanged extends MessageEvent {
  final String sendVia;
  const SendViaChanged(this.sendVia);
}

class SelectAllChanged extends MessageEvent {
  final bool selectAll;
  const SelectAllChanged(this.selectAll);
}

class DateChanged extends MessageEvent {
  final DateTime selectedDate;
  const DateChanged(this.selectedDate);
}

class TimeChanged extends MessageEvent {
  final TimeOfDay selectedTime;
  const TimeChanged(this.selectedTime);
}

class TitleChanged extends MessageEvent {
  final String title;
  const TitleChanged(this.title);
}

class MessageChanged extends MessageEvent {
  final String message;
  const MessageChanged(this.message);
}

class SendMessage extends MessageEvent {
  const SendMessage();
}

class ScheduleMessage extends MessageEvent {
  const ScheduleMessage();
}
