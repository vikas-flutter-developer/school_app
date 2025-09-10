import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Today_issued/today_issued_screen.dart';
import '../bloc/library_details_bloc/library_details_bloc.dart';
class TodayReceivedScreen extends StatelessWidget {
  const TodayReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
      LibraryDetailsBloc()..add(const LoadBooks(1)), // Load tab 1
      child: const LibraryDetailsView(),
    );
  }
}
