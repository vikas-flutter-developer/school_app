class RouteModel {
  final String name;
  final int stops;
  final double distance; // in km
  final int duration; // in minutes
  final String image;

  RouteModel({
    required this.name,
    required this.stops,
    required this.distance,
    required this.duration,
    required this.image,
  });
}