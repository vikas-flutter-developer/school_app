part of 'complains_bloc.dart';

abstract class ComplainsEvent extends Equatable {
  const ComplainsEvent();

  @override
  List<Object> get props => [];
}

class LoadComplains extends ComplainsEvent {}

class TabChanged extends ComplainsEvent {
  final int tabIndex;

  const TabChanged(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
