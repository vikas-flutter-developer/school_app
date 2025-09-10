import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String imagePath;
  final String title;
  final String venue;
  final String date;
  final String registrationLink;
  final int interestedCount;
  final int notInterestedCount;
  final int volunteerCount;

  const EventModel({
    required this.imagePath,
    required this.title,
    required this.venue,
    required this.date,
    required this.registrationLink,
    required this.interestedCount,
    required this.notInterestedCount,
    required this.volunteerCount,
  });

  @override
  List<Object?> get props => [
    imagePath,
    title,
    venue,
    date,
    registrationLink,
    interestedCount,
    notInterestedCount,
    volunteerCount,
  ];
}
