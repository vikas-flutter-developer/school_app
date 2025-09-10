import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12)),
            color: AppColors.secondaryAccentLight.withAlpha(200),
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(7)),
                  child: Image.asset(
                    event.imagePath,
                    width: double.infinity,
                    height: ScreenUtilHelper.scaleHeight(146),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: ScreenUtilHelper.scaleHeight(146),
                      color: AppColors.cloud,
                      child: const Center(
                        child: Icon(Icons.error_outline, color: AppColors.ash),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(16),
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.blackHighEmphasis,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: ScreenUtilHelper.scaleText(14),
                        color: AppColors.blackMediumEmphasis),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
                    Expanded(
                      child: Text(
                        "Venue: ${event.venue}",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                          color: AppColors.blackMediumEmphasis,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    Icon(Icons.calendar_today_outlined,
                        size: ScreenUtilHelper.scaleText(13),
                        color: AppColors.blackMediumEmphasis),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
                    Text(
                      "Date: ${event.date}",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                        color: AppColors.blackMediumEmphasis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // TODO: Handle registration link tap
                        },
                        child: Text(
                          "Registration: ${event.registrationLink}",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                            color: Theme.of(context).primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                    InkWell(
                      onTap: () {
                        print('More details tapped for ${event.title}');
                      },
                      child: Text(
                        "more",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackMediumEmphasis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionChip(Icons.thumb_up_outlined, "${event.interestedCount} Interested"),
              _buildActionChip(Icons.thumb_down_outlined, "${event.notInterestedCount} Not Interested"),
              _buildActionChip(Icons.volunteer_activism_outlined, "${event.volunteerCount} Volunteer"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionChip(IconData icon, String label) {
    return InkWell(
      onTap: () {
        // TODO: Handle interaction tap
      },
      child: Row(
        children: [
          Icon(icon, size: ScreenUtilHelper.scaleText(16), color: AppColors.slate),
          SizedBox(width: ScreenUtilHelper.scaleWidth(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny),
              color: AppColors.slate,
            ),
          ),
        ],
      ),
    );
  }
}