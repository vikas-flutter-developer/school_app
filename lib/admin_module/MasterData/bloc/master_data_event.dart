// bloc/master_data/master_data_event.dart (Create folder and file)
part of 'master_data_bloc.dart';

abstract class MasterDataEvent extends Equatable {
  const MasterDataEvent();
  @override List<Object?> get props => [];
}

// Event for bottom navigation tap
class BottomNavTapped extends MasterDataEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}

// Optional: Event if button taps should be handled via BLoC state
// class NavigateToRequested extends MasterDataEvent {
//   final String destination;
//   const NavigateToRequested(this.destination);
//   @override List<Object?> get props => [destination];
// }