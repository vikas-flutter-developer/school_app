part of 'staff_screen_bloc.dart';

@immutable
abstract class StaffScreenEvent {}

class LoadInitialStaffData extends StaffScreenEvent {}

class TabChanged extends StaffScreenEvent {
  final int tabIndex;
  TabChanged(this.tabIndex);
}

class SearchStaff extends StaffScreenEvent {
  final String query;
  SearchStaff(this.query);
}
