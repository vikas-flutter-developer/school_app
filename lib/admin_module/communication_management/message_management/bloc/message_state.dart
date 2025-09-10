part of 'message_bloc.dart';

class MessageState extends Equatable {
  final String? recipientType; // Stays nullable as per your definition
  final String? selectedClass;
  final String? selectedSection;
  final String? selectedDepartment;
  final String sendVia;
  final bool selectAll;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String title;
  final String message;
  final FormStatus status;

  MessageState({
    this.recipientType = 'Parents', // Default makes it non-null initially
    this.selectedClass,
    this.selectedSection,
    this.selectedDepartment,
    this.sendVia = 'Text',
    this.selectAll = false,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    this.title = '',
    this.message = '',
    this.status = FormStatus.initial,
  }) : selectedDate = selectedDate ?? DateTime.now(),
       selectedTime = selectedTime ?? TimeOfDay.now();

  // --- isValid GETTER ADDED HERE ---
  bool get isValid {
    // Rule 1: Title must not be empty
    if (title.trim().isEmpty) {
      return false;
    }

    // Rule 2: Message must not be empty
    if (message.trim().isEmpty) {
      return false;
    }

    // Rule 3: Recipient type specific validation
    // recipientType is initialized to 'Parents' and current copyWith prevents it from becoming null,
    // so recipientType! is safe here. If it could become null, a null check would be needed.
    if (recipientType == 'Parents') {
      if (selectedClass == null ||
          selectedClass!.trim().isEmpty ||
          selectedSection == null ||
          selectedSection!.trim().isEmpty) {
        return false; // Class and Section are required for Parents
      }
    } else if (recipientType == 'Teachers') {
      if (selectedDepartment == null || selectedDepartment!.trim().isEmpty) {
        return false; // Department is required for Teachers
      }
    }
    // Add more checks for other recipientTypes if necessary (e.g., 'Students', 'All')
    // For 'All', if no further selections are needed, it would pass this stage.
    // If recipientType could be null (which it can't with current setup):
    // else if (recipientType == null) { return false; }

    // Consider other validations if needed:
    // - Date/Time validation (e.g., selectedDate must be in the future for scheduling)
    // - If !selectAll, then some other recipient selection mechanism must be satisfied
    //   (This state doesn't hold individual selected recipients, so that's harder to validate here)

    // If all checks pass, the form is valid
    return true;
  }
  // --- END OF isValid GETTER ---

  MessageState copyWith({
    String? recipientType,
    String? selectedClass,
    String? selectedSection,
    String? selectedDepartment,
    String? sendVia,
    bool? selectAll,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? title,
    String? message,
    FormStatus? status,
  }) {
    return MessageState(
      recipientType: recipientType ?? this.recipientType,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSection: selectedSection ?? this.selectedSection,
      selectedDepartment: selectedDepartment ?? this.selectedDepartment,
      sendVia: sendVia ?? this.sendVia,
      selectAll: selectAll ?? this.selectAll,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    recipientType,
    selectedClass,
    selectedSection,
    selectedDepartment,
    sendVia,
    selectAll,
    selectedDate,
    selectedTime,
    title,
    message,
    status,
  ];
}

enum FormStatus { initial, submitting, success, failure }
