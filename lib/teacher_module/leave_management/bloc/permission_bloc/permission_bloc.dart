// 1. permission_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/permission.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionState()) {
    on<LoadPermissions>(_onLoadPermissions);
    on<ApplyPermission>(_onApplyPermission);
    on<ChangePermissionTab>(_onChangePermissionTab);
  }

  Future<void> _onLoadPermissions(
    LoadPermissions event,
    Emitter<PermissionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final permissions = [
        Permission(
          hours: '2 Hours',
          dateRange: 'Wed 19 Feb, 2:00PM-4:00PM',
          reason: 'Doctor appointment',
          status: 'Pending',
          statusColor:  AppColors.pendingLight, // Light yellow
          statusIcon: Icons.lock_clock,
          iconColor:  AppColors.pending, // Orange
        ),
        Permission(
          hours: '3 Hours',
          dateRange: 'Thu 20 Feb, 10:00AM-1:00PM',
          reason: 'Family emergency',
          status: 'Approved',
          statusColor: AppColors.successLight, // Light green
          statusIcon: Icons.check,
          iconColor: AppColors.success, // Green
        ),
        Permission(
          hours: '1 Hour',
          dateRange: 'Fri 21 Feb, 3:00PM-4:00PM',
          reason: 'Bank work',
          status: 'Rejected',
          statusColor: AppColors.errorLight, // Light red
          statusIcon: Icons.close,
          iconColor: AppColors.error, // Red
        ),
      ];
      emit(state.copyWith(permissions: permissions, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _onApplyPermission(
    ApplyPermission event,
    Emitter<PermissionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void _onChangePermissionTab(
    ChangePermissionTab event,
    Emitter<PermissionState> emit,
  ) {
    emit(
      state.copyWith(
        currentTab:
            event.tabIndex == 0
                ? PermissionTab.leaves
                : PermissionTab.permission,
      ),
    );
  }
}
