part of 'complaint_form_bloc.dart';

enum FormSubmissionStatus { initial, submitting, success, error }

class ComplaintFormState extends Equatable {
  final String? selectedAction;
  final String? selectedStatus;
  final String? selectedResolvedDate;
  final String comment;
  final FormSubmissionStatus submissionStatus;

  final List<String> actionItems;
  final List<String> statusItems;
  final List<String> dateItems; // In real app, use DatePicker

  const ComplaintFormState({
    this.selectedAction = "Contacted MSEB",
    this.selectedStatus = "Pending",
    this.selectedResolvedDate = "15/03/25",
    this.comment = "Please order white color fans",
    this.submissionStatus = FormSubmissionStatus.initial,
    this.actionItems = const [
      "Contacted MSEB",
      "Visited Site",
      "Called Customer",
    ],
    this.statusItems = const ["Pending", "In Progress", "Resolved", "Closed"],
    this.dateItems = const ["15/03/25", "16/03/25", "17/03/25"],
  });

  ComplaintFormState copyWith({
    String? selectedAction,
    String? selectedStatus,
    String? selectedResolvedDate,
    String? comment,
    FormSubmissionStatus? submissionStatus,
  }) {
    return ComplaintFormState(
      selectedAction: selectedAction ?? this.selectedAction,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedResolvedDate: selectedResolvedDate ?? this.selectedResolvedDate,
      comment: comment ?? this.comment,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      actionItems: actionItems, // These usually don't change
      statusItems: statusItems,
      dateItems: dateItems,
    );
  }

  @override
  List<Object?> get props => [
    selectedAction,
    selectedStatus,
    selectedResolvedDate,
    comment,
    submissionStatus,
    actionItems,
    statusItems,
    dateItems,
  ];
}
