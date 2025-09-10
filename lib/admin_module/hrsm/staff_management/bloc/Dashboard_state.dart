import 'package:equatable/equatable.dart';

import '../model/Dasboard_model.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final DashboardStats stats;

  DashboardLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}
