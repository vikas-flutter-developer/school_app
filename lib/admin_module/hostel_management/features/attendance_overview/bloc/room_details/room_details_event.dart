part of 'room_details_bloc.dart';

@immutable
abstract class RoomDetailsEvent {}

class AttendanceLoadRoomDetails extends RoomDetailsEvent {
  final String roomId; // Or any identifier for the room
  AttendanceLoadRoomDetails(this.roomId);
}
