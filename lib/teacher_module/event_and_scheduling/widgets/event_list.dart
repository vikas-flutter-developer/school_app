import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../models/event_model.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  final List<EventModel> events;

  const EventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(20)),
          child: const Text("No events found.", style: TextStyle(color: AppColors.ash)),
        ),
      );
    }

    // Use ListView.builder for potentially long lists
    return ListView.separated(
      padding:  EdgeInsets.symmetric(vertical: ScreenUtilHelper.scaleHeight(10)),
      // Remove shrinkWrap and physics if this is the primary scrollable body
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Padding(
          // Add padding around each card
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ), // Use screen padding instead
          child: EventCard(event: events[index]),
        );
      },
      separatorBuilder: (context, index) =>  SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
    );
  }
}
