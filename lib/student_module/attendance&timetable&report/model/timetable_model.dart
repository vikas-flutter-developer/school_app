class Timetable {
  final Map<String, dynamic> data;

  Timetable({required this.data});

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(data: json);
  }
}
