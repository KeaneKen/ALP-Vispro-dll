class Chat {
  final String name;
  final String lastMessage;
  final String time;
  final bool isUnread;
  final String? imageUrl;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isUnread,
    this.imageUrl,
  });
}