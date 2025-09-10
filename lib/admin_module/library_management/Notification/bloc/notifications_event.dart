// bloc/notifications/notifications_event.dart
part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationsEvent {}

class BottomNavTapped extends NotificationsEvent {
  final int index;

  const BottomNavTapped(this.index);

  @override
  List<Object?> get props => [index];
}
