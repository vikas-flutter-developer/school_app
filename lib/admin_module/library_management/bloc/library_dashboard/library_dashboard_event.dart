// bloc/library_dashboard/library_dashboard_event.dart
part of 'library_dashboard_bloc.dart';

abstract class LibraryDashboardEvent extends Equatable {
  const LibraryDashboardEvent();
  @override List<Object?> get props => [];
}

class LoadDashboard extends LibraryDashboardEvent {}
class BottomNavTapped extends LibraryDashboardEvent { final int index; const BottomNavTapped(this.index); @override List<Object?> get props => [index];}
class CardTapped extends LibraryDashboardEvent { final String route; const CardTapped(this.route); @override List<Object?> get props => [route];} // Event for card taps