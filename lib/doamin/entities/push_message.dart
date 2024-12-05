class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic> data;
  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    required this.data,
    required this.imageUrl,
  });

  static Map<String, dynamic> toJson(PushMessage message) {
    return {
      'messageId': message.messageId,
      'title': message.title,
      'body': message.body,
      'sentDate': message.sentDate.toString(),
      'data': message.data,
      'imageUrl': message.imageUrl,
    };
  }

  @override
  String toString() {
    return '''
PushMessage{
  messageId: $messageId, 
  title: $title, 
  body: $body, 
  sentDate: $sentDate, 
  data: $data, 
  imageUrl: $imageUrl
}
''';
  }

  static void fromJson(jsonDecode) {}
}
