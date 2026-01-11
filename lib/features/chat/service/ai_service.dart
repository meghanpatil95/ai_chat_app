import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const _apiKey = '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';
  static const _openRouterApiKey = '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';

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      // Uri.parse('https://api.openai.com/v1/chat/completions'),
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_openRouterApiKey',
      },
      body: jsonEncode({
        "model": "meta-llama/llama-3.1-8b-instruct", // SAFE & cheap
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant."
          },
          {
            "role": "user",
            "content": message
          }
        ],
        "temperature": 0.7,
        "max_tokens": 300
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('AI Error');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }

}
