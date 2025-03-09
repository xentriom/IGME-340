import 'dart:convert';
import 'package:http/http.dart' as http;

class Yatta {
  static const String _baseUrl = 'https://sr.yatta.moe/';
  static const String _apiPath = 'api/v2/en';
  static const String _assetPath = 'hsr/assets/UI';

  static const String _charactersEndpoint = '$_apiPath/avatar';
  static const String _statsEndpoint = '$_apiPath/manualAvatar';

  /// Fetch the list of characters
  Future<List<dynamic>> getCharacters() async {
    final url = Uri.parse('$_baseUrl$_charactersEndpoint');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final characterMap = data['data']['items'] as Map<String, dynamic>;
        return characterMap.values.toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Fetch details for a specific character by ID
  Future<Map<String, dynamic>> getCharacterDetail(String id) async {
    final url = Uri.parse('$_baseUrl$_apiPath/avatar/$id');
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
      rethrow;
    }
  }

  /// Get URL for character avatar icon
  String getAvatarIconUrl(String id) {
    return '$_baseUrl$_assetPath//avatar/medium/$id.png';
  }

  /// Get URL for character gacha icon
  String getGachaIconUrl(String id) {
    return '$_baseUrl$_assetPath//avatar/large/$id.png';
  }

  /// Get URL for character profession icon (paths)
  String getPathIcon(String name) {
    return '$_baseUrl$_assetPath/profession/$name.png';
  }

  /// Get URL for character type icon (combative)
  String getTypeIcon(String name) {
    return '$_baseUrl$_assetPath/attribute/$name.png';
  }
}
