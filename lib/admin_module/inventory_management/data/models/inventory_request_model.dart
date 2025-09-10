import 'package:equatable/equatable.dart';

enum RequestStatus { pending, approved, rejected }

class InventoryRequestModel extends Equatable {
  final String id;
  final String className;
  final String teacherName;
  final DateTime requestDate;
  final String roomNo;
  final RequestStatus status;

  const InventoryRequestModel({
    required this.id,
    required this.className,
    required this.teacherName,
    required this.requestDate,
    required this.roomNo,
    this.status = RequestStatus.pending,
  });

  @override
  List<Object?> get props => [
    id,
    className,
    teacherName,
    requestDate,
    roomNo,
    status,
  ];

  InventoryRequestModel copyWith({
    String? id,
    String? className,
    String? teacherName,
    DateTime? requestDate,
    String? roomNo,
    RequestStatus? status,
  }) {
    return InventoryRequestModel(
      id: id ?? this.id,
      className: className ?? this.className,
      teacherName: teacherName ?? this.teacherName,
      requestDate: requestDate ?? this.requestDate,
      roomNo: roomNo ?? this.roomNo,
      status: status ?? this.status,
    );
  }
}
