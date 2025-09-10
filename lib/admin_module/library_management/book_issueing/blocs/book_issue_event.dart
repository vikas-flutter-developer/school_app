abstract class BookIssueEvent {}

class UpdateCategory extends BookIssueEvent {
  final String category;
  UpdateCategory(this.category);
}

class UpdateField extends BookIssueEvent {
  final String field;
  final String value;
  UpdateField({required this.field, required this.value});
}

class ToggleBookSelection extends BookIssueEvent {
  final String bookName;
  ToggleBookSelection(this.bookName);
}

class SubmitIssue extends BookIssueEvent {}
