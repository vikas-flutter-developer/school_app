part of 'notice_bloc.dart';

class NoticeState extends Equatable {
  final List<Notice> notices;
  final String selectedRecipientType;
  final String selectedSendVia;
  final bool selectAll;
  final List<Recipient> recipients;
  final List<bool> selectedRecipients;
  final String searchTerm;

  const NoticeState({
    required this.notices,
    this.selectedRecipientType = 'Teachers',
    this.selectedSendVia = 'Email',
    this.selectAll = false,
    required this.recipients,
    required this.selectedRecipients,
    this.searchTerm = '',
  });

  List<Recipient> get filteredRecipients {
    if (searchTerm.isEmpty) {
      return recipients;
    } else {
      return recipients.where((recipient) {
        return recipient.name.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    }
  }

  bool get shouldShowSubjectField =>
      !(selectedRecipientType == 'All' && selectedSendVia == 'Text');

  NoticeState copyWith({
    List<Notice>? notices,
    String? selectedRecipientType,
    String? selectedSendVia,
    bool? selectAll,
    List<Recipient>? recipients,
    List<bool>? selectedRecipients,
    String? searchTerm,
  }) {
    return NoticeState(
      notices: notices ?? this.notices,
      selectedRecipientType:
          selectedRecipientType ?? this.selectedRecipientType,
      selectedSendVia: selectedSendVia ?? this.selectedSendVia,
      selectAll: selectAll ?? this.selectAll,
      recipients: recipients ?? this.recipients,
      selectedRecipients: selectedRecipients ?? this.selectedRecipients,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object> get props => [
    notices,
    selectedRecipientType,
    selectedSendVia,
    selectAll,
    recipients,
    selectedRecipients,
    searchTerm,
  ];
}
