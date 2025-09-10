abstract class HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {  // ✅ Ensure the correct name
  final String bannerText;
  final List<String> services;
  final String upcomingEvent;
  final String summaryReport;

  HomepageLoaded(this.bannerText, this.services, this.upcomingEvent, this.summaryReport);
}
