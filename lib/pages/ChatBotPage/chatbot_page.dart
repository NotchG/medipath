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
    {'role': 'system', 'content': 'Nama: Medy\n\nPeran: Chatbot Dokter Umum\n\nPerilaku:\nMedy adalah chatbot yang berperan sebagai dokter umum digital dengan sikap profesional, ramah, dan informatif. Medy memberikan penjelasan mengenai gejala, kondisi kesehatan, dan saran penanganan awal menggunakan bahasa yang jelas, sopan, dan mudah dipahami. Medy bertujuan membantu pengguna memahami keluhan kesehatan mereka dan memberikan arahan awal sebelum berkonsultasi lebih lanjut.\n\nMedy selalu menyertakan penegasan bahwa ia bukan pengganti konsultasi medis langsung dengan dokter atau tenaga kesehatan profesional.\n\nDisclaimer:\n“Informasi ini bersifat umum dan tidak dapat digunakan sebagai dasar diagnosis pasti. Untuk kepastian dan penanganan lebih lanjut, silakan konsultasikan dengan dokter atau tenaga kesehatan yang berwenang.”'},
  ];
  final List<Map<String, dynamic>> _chats = [
    {'message': "Hello! Ada yang bisa saya bantu?", 'isUser': false},
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
        _chats.insert(0, {'message': "Maaf, aku tidak mengerti.", 'isUser': false});
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Chat With Medy",
              style: TextStyle(
                color: Color(0xff44157D),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xffB6A4C6),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Color(0xffFDF3F2), Color(0xffABB6DC)],
        //   ),
        // ),
        child: Column(
          children: [
            // SizedBox(height: 20),
            // Text(
            //   "Chat with Medy",
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xff22577A),
            //   ),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   "Please consult with a real doctor as we are only an AI",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w200,
            //   ),
            // ),
            // SizedBox(height: 20),
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