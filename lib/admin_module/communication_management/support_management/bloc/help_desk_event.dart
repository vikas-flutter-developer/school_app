part of 'help_desk_bloc.dart';

abstract class HelpDeskEvent {}

class TabChanged extends HelpDeskEvent {
  final int tabIndex;
  TabChanged(this.tabIndex);
}

class LoadTickets extends HelpDeskEvent {}

class LoadSurveys extends HelpDeskEvent {}

class ApproveTicket extends HelpDeskEvent {
  final String ticketId;
  ApproveTicket(this.ticketId);
}

class RejectTicket extends HelpDeskEvent {
  final String ticketId;
  RejectTicket(this.ticketId);
}

class CancelSurvey extends HelpDeskEvent {
  final String surveyId;
  CancelSurvey(this.surveyId);
}
