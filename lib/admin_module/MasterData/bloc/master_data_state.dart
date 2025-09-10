// bloc/master_data/master_data_state.dart
part of 'master_data_bloc.dart';

class MasterDataState extends Equatable {
  final int bottomNavIndex;
  // Optional: Add navigationTarget if handling via BLoC listener
  // final String? navigationTarget;

  const MasterDataState({
    this.bottomNavIndex = 0, // Default to Home selected
    // this.navigationTarget,
  });

  MasterDataState copyWith({
    int? bottomNavIndex,
    // String? navigationTarget,
    // bool clearNavigationTarget = false,
  }) {
    return MasterDataState(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      // navigationTarget: clearNavigationTarget ? null : navigationTarget ?? this.navigationTarget,
    );
  }

  @override
  List<Object?> get props => [
    bottomNavIndex,
    // navigationTarget
  ];
}