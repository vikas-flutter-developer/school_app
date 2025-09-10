import 'dart:async'; // Import async
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// Import your LocalStorageService
import '../../../data/local_storage/local_storage_service.dart';
import 'fees_event.dart';
import 'fees_state.dart';
// Import your Fee model if it's defined elsewhere (assuming it's part of FeeState for now)
// import '../../../data/models/fee_model.dart'; // Example path

// Assuming Fee model is implicitly defined or part of FeeState for simplicity
// If not, define it:
class Fee {
  final String term;
  final String amount;
  final String date;
  final String paymentStatus; // Changed to String based on _getPaymentStatus return type

  Fee({
    required this.term,
    required this.amount,
    required this.date,
    required this.paymentStatus,
  });
}


class FeeBloc extends Bloc<FeeEvent, FeeState> {
  // Constructor no longer needs apiEndpoint if it's hardcoded below
  // If endpoint needs to be dynamic, pass it here and use the parameter.
  FeeBloc({required String apiEndpoint}) : super(FeeInitial()) {
    on<FetchFees>(_onFetchFees);
  }

  Future<void> _onFetchFees(FetchFees event, Emitter<FeeState> emit) async {
    emit(FeeLoading());
    try {
      // 1. Fetch the token dynamically
      final String? token = await LocalStorageService.getAuthToken();

      // 2. Check if token exists
      if (token == null || token.isEmpty) {
        print("FeeBloc: Error - Auth token not found in local storage.");
        emit(FeeError(error: 'Authentication token not found. Please log in again.'));
        return; // Stop execution if no token
      }

      print("FeeBloc: Using token from local storage.");

      // --- API Endpoint (Consider making this configurable if needed) ---
      const String apiEndpoint =
          'https://stage-api-edudibon.trinodepointers.com/fee/student/feeslips';
      // --- Hardcoded token removed ---
      // const String token = "eyJhbGciOi...AgSjjA"; // REMOVED

      print("FeeBloc: Fetching fees from $apiEndpoint");
      final response = await http.get(
        Uri.parse(apiEndpoint),
        // 3. Use the fetched token in the Authorization header
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 20)); // Added timeout

      print("FeeBloc: Fees API response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Safely access the 'data' key
        final dynamic dataValue = jsonResponse['data']; // Get value first

        if (dataValue != null && dataValue is List) { // Check type is List
          final List<dynamic> data = dataValue; // Cast to List
          print("FeeBloc: Fees data found, processing ${data.length} items.");

          // Map the data to Fee objects
          final List<Fee> fees = data.map((item) {
            // Ensure item is a Map before accessing keys
            if (item is Map<String, dynamic>) {
              return Fee(
                term: item['fee_register_name'] as String? ?? 'N/A',
                // Handle amount conversion safely
                amount: _formatAmount(item['amount_total']),
                date: item['invoice_date_due'] as String? ?? 'N/A',
                paymentStatus: _getPaymentStatus(item['payment_state'] as String?),
              );
            } else {
              // Handle unexpected item type in the list
              print("FeeBloc: Warning - Unexpected item type in data list: ${item.runtimeType}");
              // Return a default/error Fee object or filter it out
              // Returning N/A for now, consider filtering later
              return Fee(term: 'Error', amount: '₹ 0.00', date: 'N/A', paymentStatus: 'Invalid Data');
            }
          }).toList();

          // Filter out any potential error Fees if needed
          // final validFees = fees.where((f) => f.term != 'Error').toList();

          emit(FeeLoaded(fees: fees)); // Emit loaded state with the fees
          print("FeeBloc: FeeLoaded state emitted.");

        } else {
          print("FeeBloc: 'data' key is null or not a list in the response.");
          emit(FeeError(error: 'No valid fees data found in the response.'));
        }
      } else {
        // Handle non-200 status codes
        String errorMsg = 'Failed to load fees';
        try {
          final errorBody = jsonDecode(response.body);
          errorMsg = errorBody['message'] ?? errorBody['detail'] ?? 'Failed to load fees (Status: ${response.statusCode})';
        } catch (_) {}
        print("FeeBloc: ERROR - Failed to load fees. Status: ${response.statusCode}. Message: $errorMsg");
        emit(FeeError(error: errorMsg));
      }
    } catch (e) {
      print("FeeBloc: EXCEPTION - $e");
      // Provide more specific error messages based on exception type if needed
      emit(FeeError(error: 'An unexpected error occurred: $e'));
    }
  }

  // Helper to format amount safely
  String _formatAmount(dynamic amountValue) {
    if (amountValue is num) { // Checks if it's int or double
      return '₹ ${amountValue.toStringAsFixed(2)}';
    }
    // You might want to handle String amounts if API sometimes returns them as strings
    // else if (amountValue is String) {
    //    final double? parsedAmount = double.tryParse(amountValue);
    //    return '₹ ${parsedAmount?.toStringAsFixed(2) ?? '0.00'}';
    // }
    return '₹ 0.00'; // Default if null or unexpected type
  }


  // Helper to determine payment status string
  String _getPaymentStatus(String? state) {
    switch (state?.toLowerCase()) { // Use lowercase for case-insensitive comparison
      case 'paid':
        return 'Paid';
      case 'not_paid':
        return 'Not Paid';
      case 'partial':
        return 'Partially Paid';
      default:
      // Log unknown states if necessary
        if (state != null) print("FeeBloc: Unknown payment state encountered: $state");
        return 'Unknown';
    }
  }
}