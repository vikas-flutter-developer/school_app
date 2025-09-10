part of 'occupancy_bloc.dart';

// --- Base State ---
abstract class OccupancyState extends Equatable {
  const OccupancyState();

  @override
  List<Object?> get props => [];
}

class OccupancyInitial extends OccupancyState {}
class OccupancyLoading extends OccupancyState {}
class OccupancyError extends OccupancyState {
  final String message;
  const OccupancyError(this.message);
  @override
  List<Object> get props => [message];
}

// --- Dashboard States ---
class OccupancyDashboardLoadSuccess extends OccupancyState {
  final int totalBeds;
  final int occupied;
  final int vacant;
  final int inquiry;
  final int pending;
  // Add attendance data too
  final int totalStudents;
  final int present;
  final int onLeave;
  final int checkIn;
  final int checkOut;


  const OccupancyDashboardLoadSuccess({
    required this.totalBeds,
    required this.occupied,
    required this.vacant,
    required this.inquiry,
    required this.pending,
    required this.totalStudents,
    required this.present,
    required this.onLeave,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  List<Object> get props => [totalBeds, occupied, vacant, inquiry, pending, totalStudents, present, onLeave, checkIn, checkOut];
}

// --- Room List States ---
// Mock Room Model
class Room {
  final String id;
  final String roomNumber;
  final int totalBeds;
  final List<BedStatus> beds; // BedStatus could be enum: Vacant, Occupied, Pending
  final String floor;

  const Room({required this.id, required this.roomNumber, required this.totalBeds, required this.beds, required this.floor});
}
enum BedStatus { vacant, occupied, pending }

class RoomListLoadSuccess extends OccupancyState {
  final List<Room> rooms;
  final String currentFilter;
  const RoomListLoadSuccess(this.rooms, this.currentFilter);

  @override
  List<Object> get props => [rooms, currentFilter];
}

// --- Room Detail States ---
// Mock Student Model
class HostelStudent {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String year;
  final String? photoUrl;

  const HostelStudent({required this.id, required this.name, required this.email, required this.phone, required this.department, required this.year, this.photoUrl});
}
enum RoomDetailTab { inquiry, booked, canceled }

class RoomDetailLoadSuccess extends OccupancyState {
  final Room room;
  final List<HostelStudent> inquiries; // Students who inquired
  final List<HostelStudent> bookedStudents; // Students who are booked
  final RoomDetailTab currentTab;
  final BedStatus? selectedBed; // For inquiry form

  const RoomDetailLoadSuccess({
    required this.room,
    this.inquiries = const [],
    this.bookedStudents = const [],
    this.currentTab = RoomDetailTab.inquiry,
    this.selectedBed,
  });

  @override
  List<Object?> get props => [room, inquiries, bookedStudents, currentTab, selectedBed];
}


// --- Form/Action States ---
class InquirySubmissionSuccess extends OccupancyState {
  final String message;
  const InquirySubmissionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class BookingConfirmationInProgress extends OccupancyState {} // For "Are you sure?"
class BookingConfirmedSuccess extends OccupancyState {
  final String message;
  const BookingConfirmedSuccess(this.message);
  @override
  List<Object> get props => [message];
}