// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/service_request_bloc.dart';
// import '../widgets/service_request_card.dart';
// import '../../../data/repositories/service_request_repository.dart';
// import 'new_service_form_page.dart';
//
// class ServiceRequestListPage extends StatelessWidget {
//   const ServiceRequestListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // In a real app, provide repositories via main.dart or an inherited widget
//     // Providing here for simplicity
//     return BlocProvider(
//       create:
//           (context) => ServiceRequestBloc(
//             serviceRequestRepository:
//                 MockDataSource(), // Provide the repo instance
//             // ticketRepository: MockDataSource(), // if merging
//           )..add(LoadServiceRequests()), // Load data initially
//       child: Scaffold(
//         appBar: AppBar(
//           // Use title based on context if needed (e.g. 'Service Request' vs 'Services')
//           title: const Text('Services'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () => Navigator.maybePop(context),
//           ), // Example back
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.notifications_none),
//               onPressed: () {},
//             ), // Bell icon
//             IconButton(
//               icon: const Icon(Icons.filter_list),
//               onPressed: () {},
//             ), // Filter
//           ],
//           bottom: PreferredSize(
//             // Search bar
//             preferredSize: const Size.fromHeight(kToolbarHeight),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 8.0,
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search by name, room...',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.mic),
//                     onPressed: () {},
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   contentPadding: EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),
//           ),
//           elevation: 1, // Slight shadow
//         ),
//         body: BlocBuilder<ServiceRequestBloc, ServiceRequestState>(
//           builder: (context, state) {
//             if (state is ServiceRequestLoading ||
//                 state is ServiceRequestInitial) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ServiceRequestLoaded) {
//               // Combine or separate lists based on your needs
//               // final allItems = [...state.tickets, ...state.serviceRequests]; // Example combine
//               // Sort items by date if combined
//               // allItems.sort((a, b) => b.date.compareTo(a.date)); // Assuming Ticket also has 'date'
//
//               if (state.serviceRequests.isEmpty) {
//                 return const Center(child: Text('No service requests found.'));
//               }
//
//               return ListView.builder(
//                 itemCount: state.serviceRequests.length,
//                 itemBuilder: (context, index) {
//                   final item = state.serviceRequests[index];
//                   // Use instanceof to differentiate if merging lists
//                   // if (item is Ticket) {
//                   //   return TicketCard(ticket: item);
//                   // } else if (item is ServiceRequest) {
//                   return ServiceRequestCard(request: item);
//                   // }
//                   // return const SizedBox.shrink(); // Should not happen
//                 },
//               );
//             } else if (state is ServiceRequestError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return const Center(child: Text('Something went wrong.'));
//           },
//         ),
//         // Example FAB to navigate to the New Service Form
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const NewServiceFormPage()),
//             );
//           },
//           label: const Text('+ New Service'),
//           icon: const Icon(Icons.add),
//         ),
//         // Add BottomNavigationBar here if this is a main screen
//         // bottomNavigationBar: const BottomNavBar(),
//       ),
//     );
//   }
// }
