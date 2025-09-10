import 'package:equatable/equatable.dart';

class Students extends Equatable {
  final String id;
  final String name;
  final String profileImagePath;
  final String status;
  final String details;

  const Students({
    required this.id,
    required this.name,
    required this.profileImagePath,
    required this.status,
    required this.details,
  });

  Students copyWith({
    String? id,
    String? name,
    String? profileImagePath,
    String? status,
    String? details,
  }) {
    return Students(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [id, name, profileImagePath, status, details];
}
