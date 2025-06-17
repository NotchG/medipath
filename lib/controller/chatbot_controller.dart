import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/chatbot_model.dart';

class ChatBotController {
  String? _chatResponse;

  String? get chatResponse => _chatResponse;

  void setChatResponse(String response) {
    _chatResponse = response;
  }

  void clearChatResponse() {
    _chatResponse = null;
  }

  Future<ChatCompletionResponse?> fetchGroqCompletion(List<Map<String, dynamic>> messages) async {
    var apiKey = dotenv.get("GROQ_API_KEY", fallback: "");
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      "model": "gemma2-9b-it",
      'messages': messages
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ChatCompletionResponse.fromJson(data);
    } else {
      // Handle error as needed
      print('Error: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  String _sanitizeResponse(String response) {
    // Remove all asterisks
    return response.replaceAll('*', '');
  }

  Future<void> getAndSetGroqResponse(List<Map<String, dynamic>> messages) async {
    final completion = await fetchGroqCompletion(messages);
    if (completion != null &&
        completion.choices != null &&
        completion.choices!.isNotEmpty &&
        completion.choices!.first.message?.content != null) {
      _chatResponse = _sanitizeResponse(completion.choices!.first.message!.content!);
    } else {
      _chatResponse = null;
    }
  }
}