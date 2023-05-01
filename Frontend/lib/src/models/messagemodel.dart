class MessageModel {
  final String username;
  final String body;

  const MessageModel({required this.username, required this.body});

  Map toJson() => {
    'username': username,
    'body': body,
  };
}