/*
// lib/admin_dashboard_bloc/dashboard_event.dart

import 'package:edudibon_flutter_bloc/Admin_Module_Classroom/data/dashboard_item.dart';
import 'package:equatable/equatable.dart'; // Use equatable for easy comparison (add dependency)
 // Import DashboardItem

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class CardTapped extends DashboardEvent {
  final DashboardItem item;
  const CardTapped({required this.item});

  @override
  List<Object> get props => [item];
}

// Add other potential events like LoadDashboardData if needed*/


import 'package:equatable/equatable.dart';

import '../../data/dashboard_data.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

// Event dispatched when a card is tapped
class CardTapped extends DashboardEvent {
  final DashboardItem item;

  const CardTapped({required this.item});

  @override
  List<Object> get props => [item];
}