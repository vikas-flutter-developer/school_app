part of 'mail_bloc.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => [];
}

class RecipientTypeChanged extends MailEvent {
  final String? recipientType;
  const RecipientTypeChanged(this.recipientType);
}

class ClassChanged extends MailEvent {
  final String? selectedClass;
  const ClassChanged(this.selectedClass);
}

class SectionChanged extends MailEvent {
  final String? selectedSection;
  const SectionChanged(this.selectedSection);
}

class DepartmentChanged extends MailEvent {
  final String? selectedDepartment;
  const DepartmentChanged(this.selectedDepartment);
}

class SendViaChanged extends MailEvent {
  final String sendVia;
  const SendViaChanged(this.sendVia);
}

class SelectAllChanged extends MailEvent {
  final bool selectAll;
  const SelectAllChanged(this.selectAll);
}

class DateChanged extends MailEvent {
  final DateTime selectedDate;
  const DateChanged(this.selectedDate);
}

class TimeChanged extends MailEvent {
  final TimeOfDay selectedTime;
  const TimeChanged(this.selectedTime);
}

class TitleChanged extends MailEvent {
  final String title;
  const TitleChanged(this.title);
}

class MessageChanged extends MailEvent {
  final String message;
  const MessageChanged(this.message);
}

class SendMessage extends MailEvent {
  const SendMessage();
}

class ScheduleMessage extends MailEvent {
  const ScheduleMessage();
}
