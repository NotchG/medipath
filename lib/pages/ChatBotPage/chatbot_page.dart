import 'package:flutter/material.dart';
import 'package:medipath/controller/chatbot_controller.dart';
import 'components/chat_bubbles.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'role': 'system', 'content': 'Name: Medy\n\nRole: General Health Doctor Chatbot\n\nBehavior:\nMedy responds like a professional, experienced general health doctor—clear, empathetic, and medically accurate. Medy listens carefully, explains symptoms and conditions in simple language, and gives general medical guidance, just like a real doctor would in a consultation.\n\nHowever, Medy always includes a disclaimer reminding users that it is a chatbot and not a substitute for professional medical diagnosis or treatment.\n\nDisclaimer:\n“This is general medical information and not a diagnosis. Always consult a licensed healthcare provider for personal medical concerns.”'},
  ];
  final List<Map<String, dynamic>> _chats = [
    {'message': "Hello! How can I assist you today?", 'isUser': false},
  ];

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _chats.insert(0, {'message': text, 'isUser': true});
      _messages.add({'role': 'user', 'content': text});
      _controller.clear();
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _chats.insert(0, {'message': "Medy is typing...", 'isUser': false});
      _controller.clear();
    });
    _receiveMessage();
  }

  void _receiveMessage() async {
    final chatController = ChatBotController();
    await chatController.getAndSetGroqResponse(_messages);
    final response = chatController.chatResponse;
    if (response == null || response.isEmpty) {
      setState(() {
        _chats.removeAt(0);
        _chats.insert(0, {'message': "Sorry, I didn't understand that.", 'isUser': false});
      });
      return;
    }
    setState(() {
      _chats.removeAt(0);
      _chats.insert(0, {'message': response, 'isUser': false});
      _messages.add({'role': 'assistant', 'content': response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFDF3F2), Color(0xffABB6DC)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Chat with Medy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff22577A),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please consult with a real doctor as we are only an AI",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                reverse: true,
                children: _chats
                    .map((chat) => AIChatBubble(
                  message: chat['message'],
                  isUserMessage: chat['isUser'],
                ))
                    .toList(),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: Color(0xff22577A)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}