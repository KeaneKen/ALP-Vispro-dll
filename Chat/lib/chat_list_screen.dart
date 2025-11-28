import 'package:flutter/material.dart';
import 'chat_room_screen.dart';
import 'models.dart';

class ChatListScreen extends StatelessWidget {
  final List<Chat> chats = [
    Chat(
      name: 'Gacoan',
      lastMessage: 'The weather will be perfect for the st...',
      time: '2:14 PM',
      isUnread: false,
      imageUrl: 'assets/gacoan.png'
    ),
    Chat(
      name: 'Wendys',
      lastMessage: 'You: The store only has (gasp!) 2% m...',
      time: '2:14 PM',
      isUnread: false,
      imageUrl: 'assets/Wendys.png' // PERHATIKAN: 'W' besar
    ),
    Chat(
      name: 'KFC',
      lastMessage: '@Philippe: Hmm, are you sure?',
      time: '10:16 PM',
      isUnread: true,
      imageUrl: 'assets/kfc.png'
    ),
    Chat(
      name: 'Solaria',
      lastMessage: 'You: The game went into OT, it\'s gonn...',
      time: 'Friday',
      isUnread: false,
      imageUrl: 'assets/Solaria.png' // PERHATIKAN: 'S' besar
    ),
    Chat(
      name: 'Burger King',
      lastMessage: 'The class has open enrollment until th...',
      time: '12/28/20',
      isUnread: false,
      imageUrl: 'assets/Burger King.png' // PERHATIKAN: spasi dan kapital
    ),
    Chat(
      name: 'PT Suka Makan',
      lastMessage: '@waldo Is Cleveland nice in October?',
      time: '08/09/20',
      isUnread: false,
      imageUrl: 'assets/PT Suka Makan.png' // PERHATIKAN: spasi dan kapital
    ),
    Chat(
      name: 'PT Makan Banyak',
      lastMessage: 'You: Can you mail my rent check?',
      time: '22/08/20',
      isUnread: false,
      imageUrl: 'assets/PT Makan Banyak.png' // PERHATIKAN: spasi dan kapital
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAE0), 
      appBar: AppBar(
        title: Text(
          'Pesan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Color(0xFFFEFAE0),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
          // Chat List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEFAE0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return ChatListItem(
                    chat: chats[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoomScreen(
                            chat: chats[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatListItem({
    Key? key,
    required this.chat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          child: chat.imageUrl != null && chat.imageUrl!.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: AssetImage(chat.imageUrl!),
                  radius: 25,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: _getAvatarColor(chat.name),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(chat.name),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
        ),
        title: Row(
          children: [
            Text(
              chat.name,
              style: TextStyle(
                fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
            if (chat.isUnread)
              Container(
                margin: EdgeInsets.only(left: 8),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Text(
          chat.lastMessage,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.normal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          chat.time,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  String _getInitials(String name) {
    List<String> words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}';
    } else if (words.length == 1) {
      return words[0][0];
    }
    return '?';
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
    ];
    int index = name.length % colors.length;
    return colors[index];
  }
}