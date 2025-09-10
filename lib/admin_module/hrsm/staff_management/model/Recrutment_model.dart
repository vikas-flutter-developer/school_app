class Candidate {
  final String name;
  final String time;

  Candidate({required this.name, required this.time});
}

class ScheduledInterview {
  final String title;
  final List<Candidate> candidates;

  ScheduledInterview({required this.title, required this.candidates});
}
