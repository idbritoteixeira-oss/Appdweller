import 'package:http/http.dart' as http;
import 'dart:convert';

class EnXService {
  // Endereço do seu Webserver C++
  static const String _baseUrl = 'http://127.0.0.1:8080';

  static Future<Map<String, dynamic>?> sendIntegration({
    required String nick,
    required String key,
    required String nat,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/integration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nick': nick,
          'key': key,
          'nat': nat,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Erro de conexão EnX: $e");
    }
    return null;
  }
}
