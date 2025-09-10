import 'student_short_info_model.dart';

class RoomModel {
  final String roomNumber;
  final List<StudentShortInfoModel> students;

  RoomModel({required this.roomNumber, required this.students});
}
