import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_decorations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  String selectedRoute = "Route no";
  static const String orsApiKey = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjhkMTJhYzkxOTQ1YTRmZDM5YmRmNWExMjc1MTZlNWRiIiwiaCI6Im11cm11cjY0In0=';
  static const String maptilerApiKey = 'HwAPwGydl79NxI8mZd2r';

  final OpenRouteService client = OpenRouteService(apiKey: orsApiKey);
  final MapController _mapController = MapController();

  // Define only one route as per the request
  final Map<String, List<ORSCoordinate>> _routePoints = {
    "Route A": [
      const ORSCoordinate(latitude: 12.916709, longitude: 77.609858),
      const ORSCoordinate(latitude: 12.923691, longitude: 77.595967),
      const ORSCoordinate(latitude: 12.935004, longitude: 77.616699),
    ],
  };

  // State variables for the selected route's data
  List<LatLng> _routeCoordinates = [];
  LatLng? _busLocation;
  bool _isLoadingRoute = false;

  // This list holds the locations of all buses for the default view
  final List<LatLng> _allBusLocations = [
    const LatLng(12.920, 77.605),
    const LatLng(12.935, 77.595),
    const LatLng(12.950, 77.610),
  ];

  // Flag to determine which markers and layers to display
  bool _showAllBuses = true;

  // Function to handle map zoom-in
  void _zoomIn() {
    _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 0.5);
  }

  // Function to handle map zoom-out
  void _zoomOut() {
    _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 0.5);
  }

  // Function to re-center the map on the bus's location
  void _recenterBus() {
    if (_busLocation != null) {
      _mapController.move(_busLocation!, 18.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    // Calculate the initial map center.
    final LatLng initialCenter = const LatLng(12.93, 77.6);

    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.height(30.0)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            "Live Tracking",
            style: AppStyles.heading.copyWith(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(18),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: AppColors.black,
                size: ScreenUtilHelper.scaleAll(30),
              ),
              onPressed: () => context.push(AppRoutes.notifications),
            )
          ],
        ),
        body: Column(
          children: [
            // Dropdown
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: ScreenUtilHelper.width(140),
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.silver),
                    borderRadius: AppDecorations.normalRadius,
                  ),
                  child: DropdownButton<String>(
                    value: selectedRoute,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: AppStyles.body.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(16),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Route no",
                        child: Text("Route no"),
                      ),
                      DropdownMenuItem(
                        value: "Route A",
                        child: Text("Route A"),
                      ),
                    ],
                    onChanged: (value) async {
                      setState(() {
                        selectedRoute = value!;
                        _isLoadingRoute = true;
                        _routeCoordinates = [];
                        _busLocation = null;
                        _showAllBuses = (value == "Route no");
                      });

                      if (!_showAllBuses && _routePoints.containsKey(value)) {
                        await _fetchRouteForSelectedPoints(_routePoints[value]!);
                      } else {
                        setState(() {
                          _isLoadingRoute = false;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),

            // Map with buses
            Expanded(
              child: _isLoadingRoute
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: initialCenter,
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}@2x.png?key={key}',
                    additionalOptions: const {
                      'key': maptilerApiKey,
                    },
                    userAgentPackageName: 'com.example.app',
                  ),
                  PolylineLayer(
                    polylines: [
                      if (_routeCoordinates.isNotEmpty)
                        Polyline(
                          points: _routeCoordinates,
                          strokeWidth: 4.0,
                          color: Color(0xff4A44B6),
                        ),
                    ],
                  ),
                  MarkerLayer(
                    markers: _showAllBuses
                        ? _allBusLocations.map((location) {
                      return Marker(
                        width: ScreenUtilHelper.width(40),
                        height: ScreenUtilHelper.height(40),
                        point: location,
                        child: Image.asset("assets/images/bus_icon.png"),
                      );
                    }).toList()
                        : [
                      // Display stops if a route is selected
                      if (_routePoints.containsKey(selectedRoute))
                        ..._routePoints[selectedRoute]!.map((point) {
                          return Marker(
                            width: ScreenUtilHelper.width(20),
                            height: ScreenUtilHelper.height(20),
                            point: LatLng(point.latitude, point.longitude),
                            child: Image.asset("assets/images/circle.png"),
                          );
                        }).toList(),

                      // Display the single bus on the selected route
                      if (_busLocation != null)
                        Marker(
                          width: ScreenUtilHelper.width(40),
                          height: ScreenUtilHelper.height(40),
                          point: _busLocation!,
                          child: Image.asset("assets/images/bus_icon.png"),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'zoomIn',
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: _zoomIn,
              child: Icon(Icons.zoom_in, color: AppColors.ash),
            ),
            SizedBox(height: ScreenUtilHelper.height(8)),
            FloatingActionButton(
              heroTag: 'zoomOut',
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: _zoomOut,
              child: Icon(Icons.zoom_out, color: AppColors.ash),
            ),
            if (_busLocation != null)
              SizedBox(height: ScreenUtilHelper.height(8)),
            if (_busLocation != null)
              FloatingActionButton(
                heroTag: 'recenter',
                mini: true,
                backgroundColor: AppColors.white,
                onPressed: _recenterBus,
                child: Icon(Icons.my_location, color: AppColors.primaryMedium),
              ),
          ],
        ),
      ),
    );
  }

  // Function to fetch route for a given list of coordinates
  Future<void> _fetchRouteForSelectedPoints(List<ORSCoordinate> points) async {
    List<LatLng> allRoutePoints = [];
    try {
      if (points.length >= 2) {
        final route1 = await client.directionsRouteCoordsGet(
          startCoordinate: points[0],
          endCoordinate: points[1],
        );
        allRoutePoints.addAll(route1.map((coord) => LatLng(coord.latitude, coord.longitude)));

        if (points.length > 2) {
          final route2 = await client.directionsRouteCoordsGet(
            startCoordinate: points[1],
            endCoordinate: points[2],
          );
          allRoutePoints.addAll(route2.map((coord) => LatLng(coord.latitude, coord.longitude)));
        }
      }

      setState(() {
        _routeCoordinates = allRoutePoints;
        if (allRoutePoints.isNotEmpty) {
          _busLocation = allRoutePoints.first;
          _mapController.move(_busLocation!, 20.0);
        }
        _isLoadingRoute = false;
      });
    } catch (e) {
      debugPrint('Error fetching route: $e');
      setState(() {
        _isLoadingRoute = false;
      });
    }
  }
}