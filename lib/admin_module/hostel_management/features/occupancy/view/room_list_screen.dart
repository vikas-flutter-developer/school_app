import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/occupancy_bloc.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["All Rooms", "Occupied", "Available"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // No need to call filter here, it's handled by tapping the tab
      }
    });
    context.read<OccupancyBloc>().add(LoadRoomList());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/edudibon_logo.png',
          width: ScreenUtilHelper.width(100),
          height: ScreenUtilHelper.height(50),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: theme.primaryColor),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.primaryColor,
          unselectedLabelColor: AppColors.ash,
          indicatorColor: theme.primaryColor,
          tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
          onTap: (index) {
            context.read<OccupancyBloc>().add(FilterRooms(_tabs[index]));
          },
        ),
      ),
      body: BlocBuilder<OccupancyBloc, OccupancyState>(
        builder: (context, state) {
          if (state is OccupancyLoading && state is! RoomListLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoomListLoadSuccess) {
            if (state.rooms.isEmpty) {
              return Center(child: Text('No rooms found for "${state.currentFilter}".',
                  style: AppStyles.bodySmall));
            }
            Map<String, List<Room>> roomsByFloor = {};
            for (var room in state.rooms) {
              roomsByFloor.putIfAbsent(room.floor, () => []).add(room);
            }

            return ListView(
              padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
              children: [
                _buildLegend(context),
                SizedBox(height: ScreenUtilHelper.height(16)),
                ...roomsByFloor.entries.map((entry) {
                  String floor = entry.key;
                  List<Room> roomsOnFloor = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
                        child: Text(floor, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: ScreenUtilHelper.width(8),
                          mainAxisSpacing: ScreenUtilHelper.height(8),
                          childAspectRatio: 1.0,
                        ),
                        itemCount: roomsOnFloor.length,
                        itemBuilder: (context, index) {
                          final room = roomsOnFloor[index];
                          return _RoomCard(
                            room: room,
                            onTap: () => context.push(AppRoutes.hostelOccupancyRoomDetail,extra: room.roomNumber),
                          );
                        },
                      ),
                      SizedBox(height: ScreenUtilHelper.height(20)),
                    ],
                  );
                }).toList(),
              ],
            );
          }
          if (state is OccupancyError) {
            return Center(child: Text('Error: ${state.message}', style: AppStyles.bodySmall));
          }
          return Center(child: Text('Select a filter to view rooms.', style: AppStyles.bodySmall));
        },
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _LegendItem(color: AppColors.cloud, label: "Vacant"),
        SizedBox(width: ScreenUtilHelper.width(10)),
        _LegendItem(color: AppColors.success, label: "Occupied"),
        SizedBox(width: ScreenUtilHelper.width(10)),
        _LegendItem(color: AppColors.pendingAlt, label: "Pending"),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenUtilHelper.width(12),
          height: ScreenUtilHelper.height(12),
          color: color,
          margin: EdgeInsets.only(right: ScreenUtilHelper.width(4)),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: ScreenUtilHelper.fontSize(12))),
      ],
    );
  }
}

class _RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const _RoomCard({required this.room, required this.onTap});

  Color _getBedColor(BedStatus status) {
    switch (status) {
      case BedStatus.vacant:
        return AppColors.cloud;
      case BedStatus.occupied:
        return AppColors.success;
      case BedStatus.pending:
        return AppColors.pendingAlt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                room.roomNumber,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtilHelper.fontSize(14),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: room.beds.map((bedStatus) {
                  return Container(
                    width: ScreenUtilHelper.width(15),
                    height: ScreenUtilHelper.height(10),
                    decoration: BoxDecoration(
                      color: _getBedColor(bedStatus),
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(2)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}