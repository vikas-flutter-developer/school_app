part of 'app_tab_bloc.dart';

abstract class AppTabEvent extends Equatable {
  const AppTabEvent();

  @override
  List<Object> get props => [];
}

class MainTabChanged extends AppTabEvent {
  final int index;

  const MainTabChanged(this.index);

  @override
  List<Object> get props => [index];
}

class ExamEventsTabChanged extends AppTabEvent {
  final int index;

  const ExamEventsTabChanged(this.index);

  @override
  List<Object> get props => [index];
}
