import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/service_request/view/raise_service_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//import '../../../../utils/app_colors.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../bloc/service_request_list_cubit.dart';
import '../widgets/service_request_card.dart';

class ServiceRequestListScreen extends StatefulWidget {
  const ServiceRequestListScreen({super.key});

  @override
  State<ServiceRequestListScreen> createState() =>
      _ServiceRequestListScreenState();
}

class _ServiceRequestListScreenState extends State<ServiceRequestListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ServiceRequestListCubit _listCubit; // To access cubit easily

  @override
  void initState() {
    super.initState();
    _listCubit = ServiceRequestListCubit()..fetchRequests(); // Create and fetch
    // Listen to search text changes
    _searchController.addListener(() {
      _listCubit.searchRequests(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listCubit.close(); // Close the cubit when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    // Use BlocProvider.value if passing the cubit down, otherwise create it here
    return BlocProvider.value(
      value: _listCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.blackHighEmphasis,size: 24,),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/edudibon_logo.png',
                  height: ScreenUtilHelper.height(30),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>context.push(AppRoutes.notifications),
                  child: Image.asset(
                    'assets/images/notification.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          // elevation: 1.0,
        ),
        body: Column(
          children: [
            // Search Bar Area
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16.0)), // ScreenUtilHelper

              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name, room...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.stone,
                  ),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: AppColors.stone,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              // Trigger search with empty string via listener
                            },
                          )
                          : Icon(
                            Icons.mic_none,
                            color: AppColors.stone,
                          ), // Mic icon
                  filled: true,
                  fillColor: AppColors.linen.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // ScreenUtilHelper

                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtilHelper.height(0), // ScreenUtilHelper
                    horizontal: ScreenUtilHelper.width(15), // ScreenUtilHelper
                  ),

                ),
                onChanged: (value) {
                  // Listener already handles the cubit call
                  // Optional: debounce the search call if needed
                },
              ),
            ),
            // "Service Request" Title/Button (Optional - Adjust UI as needed)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0), // ScreenUtilHelper
                vertical: ScreenUtilHelper.height(0), // ScreenUtilHelper
              ),

              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    /* Maybe acts as a refresh or just a title */
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryLightest,
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(15), // ScreenUtilHelper
                      vertical: ScreenUtilHelper.height(10),  // ScreenUtilHelper
                    ),

                  ),
                  child: Center(
                    child: Text(
                      'Service Request',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(AppStyles.size.heading), // ScreenUtilHelper

                        fontWeight: AppStyles.weight.regular,
                        color: Color(0xff4A44B6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(10)), // ScreenUtilHelper


            // List Area
            Expanded(
              child: BlocBuilder<
                ServiceRequestListCubit,
                ServiceRequestListState
              >(
                builder: (context, state) {
                  if (state is ServiceRequestListLoading) {
                    // Show loading only on initial load
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ServiceRequestListLoaded) {
                    if (state.requests.isEmpty) {
                      return Center(
                        child: Text(
                          state.searchTerm == null || state.searchTerm!.isEmpty
                              ? 'No service requests found.'
                              : 'No results found for "${state.searchTerm}".',
                        ),
                      );
                    }
                    return RefreshIndicator(
                      // Add pull-to-refresh
                      onRefresh: () async {
                        await _listCubit.fetchRequests();
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: ScreenUtilHelper.height(80), // ScreenUtilHelper
                        ),
                        // Space for FAB
                        itemCount: state.requests.length,
                        itemBuilder: (context, index) {
                          return ServiceRequestCard(
                            request: state.requests[index],
                          );
                        },
                      ),
                    );
                  } else if (state is ServiceRequestListError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(
                      child: Text('Loading requests...'),
                    ); // Initial or unexpected state
                  }
                },
              ),
            ),
          ],
        ),
        // Create Button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=>context.push(AppRoutes.serviceRequest),
          backgroundColor: AppColors.primaryDarkest,
          icon: const Icon(Icons.add, color: AppColors.white),
          label: Text(
            'Create',
            style: TextStyle(color: AppColors.white, fontWeight:AppStyles.weight.heading),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // ScreenUtilHelper

          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Standard position
      ),
    );
  }

  // Placeholder for filter dialog - implement similar to ticket list filter
  // void _showFilterDialog(BuildContext context, ServiceRequestListCubit cubit) {
  //    showModalBottomSheet(...)
  // }
}
