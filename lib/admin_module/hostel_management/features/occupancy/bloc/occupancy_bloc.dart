import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'occupancy_event.dart';
part 'occupancy_state.dart';

class OccupancyBloc extends Bloc<OccupancyEvent, OccupancyState> {
  OccupancyBloc() : super(OccupancyInitial()) {
    on<LoadOccupancyDashboard>(_onLoadOccupancyDashboard);
    on<LoadRoomList>(_onLoadRoomList);
    on<FilterRooms>(_onFilterRooms);
    on<LoadRoomDetails>(_onLoadRoomDetails);
    on<SubmitInquiry>(_onSubmitInquiry);
    on<ConfirmBooking>(_onConfirmBooking);
  }

  // Mock data for now
  final List<Room> _allRooms = [
    const Room(id: '101A', roomNumber: '101', totalBeds: 3, beds: [BedStatus.occupied, BedStatus.occupied, BedStatus.vacant], floor: "First Floor"),
    const Room(id: '102A', roomNumber: '102', totalBeds: 3, beds: [BedStatus.occupied, BedStatus.pending, BedStatus.vacant], floor: "First Floor"),
    const Room(id: '103A', roomNumber: '103', totalBeds: 3, beds: [BedStatus.pending, BedStatus.pending, BedStatus.vacant], floor: "First Floor"),
    const Room(id: '104A', roomNumber: '104', totalBeds: 3, beds: [BedStatus.pending, BedStatus.pending, BedStatus.vacant], floor: "First Floor"),
    const Room(id: '205A', roomNumber: '205', totalBeds: 2, beds: [BedStatus.occupied, BedStatus.vacant], floor: "First Floor"),
    // ... more rooms for first floor
    const Room(id: '101B', roomNumber: '101', totalBeds: 3, beds: [BedStatus.occupied, BedStatus.occupied, BedStatus.vacant], floor: "Second Floor"),
    const Room(id: '102B', roomNumber: '102', totalBeds: 3, beds: [BedStatus.occupied, BedStatus.pending, BedStatus.vacant], floor: "Second Floor"),
    // ... more rooms
  ];

  final Map<String, List<HostelStudent>> _roomInquiries = {
    '307C': [
      const HostelStudent(id: 's1', name: 'Aditi Sehgal', email: 'aditisehgal@gmail.com', phone: '+91 78869 56775', department: 'Civil Engineering', year: '1st Year', photoUrl: 'https://via.placeholder.com/150/FFC107/000000?Text=AS'),
    ]
  };
  final Map<String, List<HostelStudent>> _roomBookings = {
    '307C': [ // Example if someone was booked
      // const Student(id: 's2', name: 'Booked Person', email: 'booked@example.com', phone: '+91 99999 88888', department: 'CSE', year: '2nd Year'),
    ]
  };


  Future<void> _onLoadOccupancyDashboard(
      LoadOccupancyDashboard event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(OccupancyLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate network call
    emit(const OccupancyDashboardLoadSuccess(
      totalBeds: 120,
      occupied: 80,
      vacant: 40,
      inquiry: 25,
      pending: 05,
      totalStudents: 150,
      present: 120,
      onLeave: 30,
      checkIn: 80,
      checkOut: 40,
    ));
  }

  Future<void> _onLoadRoomList(
      LoadRoomList event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(OccupancyLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(RoomListLoadSuccess(_allRooms, "All Rooms"));
  }

  Future<void> _onFilterRooms(
      FilterRooms event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(OccupancyLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    List<Room> filteredRooms;
    if (event.filterCriteria == "Available") {
      filteredRooms = _allRooms.where((room) => room.beds.any((b) => b == BedStatus.vacant)).toList();
    } else if (event.filterCriteria == "Occupied") {
      // This logic might need refinement based on how "occupied" is defined (fully occupied or at least one bed occupied)
      filteredRooms = _allRooms.where((room) => room.beds.any((b) => b == BedStatus.occupied)).toList();
    }
    else {
      filteredRooms = List.from(_allRooms);
    }
    emit(RoomListLoadSuccess(filteredRooms, event.filterCriteria));
  }

  Future<void> _onLoadRoomDetails(
      LoadRoomDetails event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(OccupancyLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    // Find the room. In a real app, this would be an API call.
    final room = _allRooms.firstWhere(
            (r) => r.id == event.roomId || r.roomNumber == event.roomId, // Allow lookup by number for simplicity
        orElse: () => Room(id: event.roomId, roomNumber: event.roomId, totalBeds: 3, beds: [BedStatus.pending, BedStatus.vacant, BedStatus.vacant], floor: "Third Floor") // Mock room 307 for example
    );

    // For Room 307 (Third Floor example from screenshot)
    if (event.roomId == "307") { // This is a hack for the specific screenshot
      final room307 = Room(id: '307C', roomNumber: '307', totalBeds: 3, beds: [BedStatus.pending, BedStatus.vacant, BedStatus.vacant], floor: "Third Floor");
      emit(RoomDetailLoadSuccess(
        room: room307,
        inquiries: _roomInquiries['307C'] ?? [],
        bookedStudents: _roomBookings['307C'] ?? [],
        currentTab: RoomDetailTab.inquiry,
        selectedBed: BedStatus.pending, // First bed is selected by default
      ));
      return;
    }


    emit(RoomDetailLoadSuccess(
      room: room,
      inquiries: _roomInquiries[room.id] ?? [],
      bookedStudents: _roomBookings[room.id] ?? [],
      currentTab: RoomDetailTab.inquiry, // Default to inquiry tab
    ));
  }

  Future<void> _onSubmitInquiry(
      SubmitInquiry event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(OccupancyLoading()); // Or a specific InquirySubmitting state
    await Future.delayed(const Duration(seconds: 1));
    // Add logic to save inquiry, update bed status to pending etc.
    print("Inquiry Submitted: ${event.studentName} for room ${event.roomId}, bed ${event.bedId}");
    // Potentially update the _roomInquiries and _allRooms list
    emit(const InquirySubmissionSuccess("Inquiry created successfully!"));
    // Optionally, reload room details or navigate
    add(LoadRoomDetails(event.roomId));
  }

  Future<void> _onConfirmBooking(
      ConfirmBooking event,
      Emitter<OccupancyState> emit,
      ) async {
    emit(BookingConfirmationInProgress()); // Show "Are you sure?" dialog from UI
    // In a real app, the "Are you sure?" would be a UI dialog.
    // If user confirms from UI:
    // emit(OccupancyLoading());
    // await Future.delayed(const Duration(seconds: 1));
    // // Logic to confirm booking, update bed status to occupied.
    // print("Booking Confirmed for student ${event.studentId} in room ${event.roomId}");
    // emit(const BookingConfirmedSuccess("Seat is confirmed!"));
    // // Then navigate to confirmation screen
  }
}