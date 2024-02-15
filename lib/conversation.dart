import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> chatConversation(
  String userMessage,
  String systemMessage,
  List<String> conversationHistory,
) async {
  final apiKey = '';
  String apiUrl = 'https://api.openai.com/v1/chat/completions';

  // Update conversation history with the new user message
  conversationHistory.add(userMessage);

  Map<String, dynamic> requestData = {
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "system",
        "content":
            """You are a shop assistant in the MAclothing (@eclothingbot) Telegram bot, an online clothing store. Ensuring your responses follow the specified format: If the request is from an admin (identified by assistant role'), respond in the form: 'forAdmin=>[Message for admin e.g., notifications for new orders, messages from users, responses from you to admin etc, if no message for admin, use empty string]|forUser=>[Message for user (assistance), if no message for user, use empty string]|forSystem=>[empty string]' If the request is from a regular user (identified by 'fromUser=>[request text]'), respond in the form: 'forAdmin=>['']|forUser=>[Message for user (assistance), if no message for user, use: '']|forSystem=>['']'""",
      },
      {
        "role": "assistant",
        "content": systemMessage,
      },
      ...conversationHistory
          .map((message) => {"role": "user", "content": message})
          .toList(),
    ],
    "temperature": 0.7
  };

  String jsonData = json.encode(requestData);

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonData,
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = await json.decode(response.body);
      String generatedMessage = responseData['choices'][0]['message']
              ['content'] ??
          "Response message is null";
      conversationHistory.add(generatedMessage);
      return generatedMessage;
    } else {
      return 'Error: ${response.statusCode}, ${response.body}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
