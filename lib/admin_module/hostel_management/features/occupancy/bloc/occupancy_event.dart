part of 'occupancy_bloc.dart';

abstract class OccupancyEvent extends Equatable {
  const OccupancyEvent();

  @override
  List<Object> get props => [];
}

class LoadOccupancyDashboard extends OccupancyEvent {}
class LoadRoomList extends OccupancyEvent {}
class FilterRooms extends OccupancyEvent {
  final String filterCriteria; // e.g., "All", "Occupied", "Available"
  const FilterRooms(this.filterCriteria);
  @override
  List<Object> get props => [filterCriteria];
}
class LoadRoomDetails extends OccupancyEvent {
  final String roomId;
  const LoadRoomDetails(this.roomId);
  @override
  List<Object> get props => [roomId];
}
class SubmitInquiry extends OccupancyEvent {
  // Add form fields here
  final String studentName;
  final String roomId;
  final String bedId;
  const SubmitInquiry({required this.studentName, required this.roomId, required this.bedId});
  @override
  List<Object> get props => [studentName, roomId, bedId];
}

class ConfirmBooking extends OccupancyEvent {
  final String roomId;
  final String studentId; // or inquiryId
  const ConfirmBooking({required this.roomId, required this.studentId});
  @override
  List<Object> get props => [roomId, studentId];
}