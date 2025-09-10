part of 'room_details_bloc.dart';

@immutable
abstract class RoomDetailsState {}

class RoomDetailsInitial extends RoomDetailsState {}

class RoomDetailsLoading extends RoomDetailsState {}

class RoomDetailsLoaded extends RoomDetailsState {
  final List<StudentCardModel> students;
  final String roomTitle; // e.g., "Room 101 Details"
  RoomDetailsLoaded(this.students, this.roomTitle);
}

class RoomDetailsError extends RoomDetailsState {
  final String message;
  RoomDetailsError(this.message);
}
