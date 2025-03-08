import 'dart:convert';
import 'package:http/http.dart' as http;

class Yatta {
  static const String _baseUrl = 'https://sr.yatta.moe/';
  static const String _apiPath = 'api/v2/en/';
  static const String _assetPath = 'assets/UI/avatar/';

  static const String _charactersEndpoint = '${_apiPath}avatar';
  static const String _statsEndpoint = '${_apiPath}manualAvatar';

  /// Fetch the list of characters
  Future<List<dynamic>> getCharacters() async {
    final url = Uri.parse('$_baseUrl$_charactersEndpoint');
    print(url);
    try {
      final response = await http.get(url);
      print("hello 123");
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return data['data']['items'] ?? [];
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching characters: $e');
      rethrow;
    }
  }

  /// Fetch details for a specific character by ID
  Future<Map<String, dynamic>> getCharacterDetail(String id) async {
    final url = Uri.parse('$_baseUrl$_apiPath}avatar/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception(
          'Failed to load character detail: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching character detail: $e');
      rethrow;
    }
  }

  /// Get URL for character avatar icon (medium size)
  String getAvatarIconUrl(String id) {
    return '$_baseUrl$_assetPath}medium/$id.png';
  }

  /// Get URL for character gacha icon (large size)
  String getGachaIconUrl(String id) {
    return '$_baseUrl$_assetPath}large/$id.png';
  }
}
