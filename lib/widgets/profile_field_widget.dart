import 'package:flutter/material.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String label;
  final String value;

  const ProfileFieldWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label :',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
          const Icon(Icons.edit, size: 18),
        ],
      ),
    );
  }
}
