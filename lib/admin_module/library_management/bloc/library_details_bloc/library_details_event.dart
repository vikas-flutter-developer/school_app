part of 'library_details_bloc.dart'; // Link to the BLoC file

abstract class LibraryDetailsEvent extends Equatable {
  const LibraryDetailsEvent();
  @override
  List<Object?> get props => [];
}

// --- Events for Loading & Basic UI ---
class LoadBooks extends LibraryDetailsEvent {
  final int tabIndex; // 0: Issued, 1: Received, 2: Due
  const LoadBooks(this.tabIndex);
  @override List<Object> get props => [tabIndex];
}

class TabChanged extends LibraryDetailsEvent {
  final int tabIndex;
  const TabChanged(this.tabIndex);
  @override List<Object> get props => [tabIndex];
}

class SearchChanged extends LibraryDetailsEvent {
  final String query;
  const SearchChanged(this.query);
  @override List<Object> get props => [query];
}

class BottomNavTapped extends LibraryDetailsEvent {
  final int index;
  const BottomNavTapped(this.index);
  @override List<Object?> get props => [index];
}

// --- Events for Alert Dialog Flow ---
// Triggered when paper plane icon is tapped on a 'Due Book' card
class ShowAlertRequest extends LibraryDetailsEvent {
  final LibraryBookItem book; // Pass the specific book needing the alert
  const ShowAlertRequest(this.book);
  @override List<Object?> get props => [book];
}

// Triggered when user taps "Delay fine" or "Damage fine" in the dialog
class SendAlert extends LibraryDetailsEvent {
  final LibraryBookItem book;
  final String alertType; // e.g., 'delay', 'damage'
  const SendAlert(this.book, this.alertType);
  @override List<Object?> get props => [book, alertType];
}

// Triggered by the UI after the success/failure message snackbar is dismissed
class DismissAlertStatus extends LibraryDetailsEvent {} // Renamed for clarity