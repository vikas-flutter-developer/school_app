
import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String id;
  final String name;
  final String vehicle;
  final String avatarUrl; // This will hold the local asset path
  final String contact;
  final String licenseNo;
  final DateTime licenseExpiry;

  const Driver({
    required this.id,
    required this.name,
    required this.vehicle,
    required this.avatarUrl,
    required this.contact,
    required this.licenseNo,
    required this.licenseExpiry,
  });

  @override
  List<Object?> get props => [id, name, vehicle, avatarUrl, contact, licenseNo, licenseExpiry];
}