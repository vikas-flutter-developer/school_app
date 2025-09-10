// 2. permission_event.dart
part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class LoadPermissions extends PermissionEvent {}

class ApplyPermission extends PermissionEvent {
  final Permission permission;

  const ApplyPermission(this.permission);

  @override
  List<Object> get props => [permission];
}

class ChangePermissionTab extends PermissionEvent {
  final int tabIndex;

  const ChangePermissionTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
