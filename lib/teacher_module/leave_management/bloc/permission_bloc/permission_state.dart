// 3. permission_state.dart
part of 'permission_bloc.dart';

enum PermissionTab { leaves, permission }

class PermissionState extends Equatable {
  final List<Permission> permissions;
  final PermissionTab currentTab;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const PermissionState({
    this.permissions = const [],
    this.currentTab = PermissionTab.leaves,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  PermissionState copyWith({
    List<Permission>? permissions,
    PermissionTab? currentTab,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PermissionState(
      permissions: permissions ?? this.permissions,
      currentTab: currentTab ?? this.currentTab,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
    permissions,
    currentTab,
    isLoading,
    isSuccess,
    errorMessage,
  ];
}
