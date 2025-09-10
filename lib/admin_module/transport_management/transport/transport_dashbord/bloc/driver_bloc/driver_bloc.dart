import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/driver_detail_model.dart';
import 'driver_event.dart';
import 'driver_state.dart';



class DriverBloc extends Bloc<DriverEvent, DriverState> {
  List<Driver> _masterDriverList = [];
  // -------------------------------------------------------------

  DriverBloc() : super(DriverInitial()) {
    on<FetchDrivers>(_onFetchDrivers);
    on<SearchDriver>(_onSearchDriver);
    // ------------------------------------------
  }

  Future<void> _onFetchDrivers(FetchDrivers event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<Driver> drivers = [
        Driver(id: '12345', name: 'Ethan Carter', vehicle: 'Bus 101', avatarUrl: 'assets/images/ethan_carter.png', contact: '(555) 123-4567', licenseNo: 'DL123456789', licenseExpiry: DateTime(2025, 12, 31)),
        Driver(id: '67890', name: 'Olivia Bennett', vehicle: 'Bus 102', avatarUrl: 'assets/images/olivia_bennett.png', contact: '(555) 987-6543', licenseNo: 'DL987654321', licenseExpiry: DateTime(2026, 10, 20)),
        Driver(id: '24680', name: 'Noah Thompson', vehicle: 'Bus 103', avatarUrl: 'assets/images/noah.png', contact: '(555) 111-2222', licenseNo: 'DL111222333', licenseExpiry: DateTime(2024, 11, 15)),
        Driver(id: '13579', name: 'Ava Martinez', vehicle: 'Bus 104', avatarUrl: 'assets/images/ava.png', contact: '(555) 333-4444', licenseNo: 'DL444555666', licenseExpiry: DateTime(2027, 5, 5)),
        Driver(id: '97531', name: 'Liam Harris', vehicle: 'Bus 105', avatarUrl: 'assets/images/liam_harris.png', contact: '(555) 555-6666', licenseNo: 'DL777888999', licenseExpiry: DateTime(2025, 8, 19)),
      ];
      _masterDriverList = drivers;
      emit(DriverLoaded(drivers));
    } catch (e) {
      emit(DriverError('Failed to fetch drivers: ${e.toString()}'));
    }
  }

  void _onSearchDriver(SearchDriver event, Emitter<DriverState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(DriverLoaded(_masterDriverList));
      return;
    }

    final filteredList = _masterDriverList.where((driver) {
      final nameMatches = driver.name.toLowerCase().contains(query);
      final idMatches = driver.id.toLowerCase().contains(query);
      return nameMatches || idMatches;
    }).toList();

    emit(DriverLoaded(filteredList));
  }
}