import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverSenderPage extends StatefulWidget {
  final String busId;
  const DriverSenderPage({super.key, required this.busId});

  @override
  State<DriverSenderPage> createState() => _DriverSenderPageState();
}

class _DriverSenderPageState extends State<DriverSenderPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSending();
  }

  Future<void> _startSending() async {
    // Location permission
    final perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) {
      return;
    }

    // Send location every 5 sec
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      await Supabase.instance.client.from('bus_locations').insert({
        'bus_id': widget.busId,
        'lat': pos.latitude,
        'lng': pos.longitude,
        'speed_kmh': pos.speed * 3.6,
        'heading_deg': pos.heading,
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Driver GPS tracking ON...')),
    );
  }
}
