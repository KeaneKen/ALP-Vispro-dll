import 'package:flutter/material.dart';
import 'models.dart';

class Message {
  final String text;
  final String time;
  final bool isMe;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class ChatRoomScreen extends StatefulWidget {
  final Chat chat;

  const ChatRoomScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late TextEditingController _messageController;
  late List<Message> messages;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    
    // Inisialisasi pesan awal
    messages = [
      Message(
        text: 'Suporte ADMIN',
        time: '05:43',
        isMe: false,
      ),
      Message(
        text: 'Online',
        time: '05:43',
        isMe: false,
      ),
      Message(
        text: 'How can I help you?',
        time: '05:43',
        isMe: false,
      ),
      Message(
        text: 'Hello, I need help with my order',
        time: '05:44',
        isMe: true,
      ),
      Message(
        text: 'My order number is #12345',
        time: '05:44',
        isMe: true,
      ),
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    DateTime now = DateTime.now();
    String time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      messages.add(
        Message(
          text: _messageController.text,
          time: time,
          isMe: true,
        ),
      );
      _messageController.clear();
    });


    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });


    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        DateTime replyTime = DateTime.now();
        String replyTimeStr = '${replyTime.hour.toString().padLeft(2, '0')}:${replyTime.minute.toString().padLeft(2, '0')}';
        
        setState(() {
          messages.add(
            Message(
              text: 'Terima kasih telah menghubungi kami. Tim kami akan membantu Anda segera.',
              time: replyTimeStr,
              isMe: false,
            ),
          );
        });

        Future.delayed(Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAE0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFAE0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: widget.chat.imageUrl != null && widget.chat.imageUrl!.isNotEmpty 
                  ? CircleAvatar(
                      backgroundImage: AssetImage(widget.chat.imageUrl!), 
                      radius: 20,
                    )
                    : Container(
                      decoration: BoxDecoration(
                        color: _getAvatarColor(widget.chat.name),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          _getInitials(widget.chat.name),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.call, color: Colors.black),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    _buildMessageBubble(
                      message: messages[index].text,
                      time: messages[index].time,
                      isMe: messages[index].isMe,
                    ),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: _focusNode.hasFocus ? Color(0xFFABC270) : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: 'Type here',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEAB1B),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 30,
                        child: Icon(Icons.send, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required String time,
    required bool isMe,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFFABC270) : Color(0xFFFEAB1B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
            bottomRight: isMe ? Radius.circular(4) : Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
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