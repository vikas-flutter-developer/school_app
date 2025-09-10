class Recipient {
  final String name;
  final String number;

  Recipient({required this.name, required this.number});
}

class MessageData {
  static const List<String> recipientTypes = ['Parents', 'Teachers', 'All'];
  static const List<String> classes = ['Class VI', 'Class VII', 'Class VIII'];
  static const List<String> sections = ['A', 'B', 'C', 'D'];
  static const List<String> departments = ['Science', 'Math', 'Computer'];

  static List<Recipient> getRecipients() {
    return List.generate(
      30,
      (index) =>
          Recipient(name: 'Ansh Gupta', number: '999999999${index % 30}'),
    );
  }
}
