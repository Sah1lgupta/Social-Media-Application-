import 'package:http/http.dart' as http;
import 'dart:convert';

class SpotifyApiService {
  final String clientId = 'd7557aafe5734dd7b195ed6b29ad82a0';
  final String clientSecret = 'b3aa76fcadce4b2abb53901a8833e794';
  final String authUrl = 'https://accounts.spotify.com/api/token';
  final String apiUrl = 'https://api.spotify.com/v1';
  final int pageSize = 50;
  Future<String> getAccessToken() async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
    final http.Response response = await http.post(
      Uri.parse(authUrl),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final String accessToken = jsonData['access_token'];
      return accessToken;
    } else {
      throw Exception('Failed to authenticate with Spotify API');
    }
  }

  Future<List<dynamic>> fetchAllSongs() async {
    List<dynamic> allSongs = [];
    int currentPage = 1;
    bool hasNextPage = true;
    final String accessToken = await getAccessToken();

    while (hasNextPage) {
      final http.Response response = await http.get(
        Uri.parse('$apiUrl/browse/new-releases?limit=$pageSize&offset=${(currentPage - 1) * pageSize}'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> tracks = jsonData['albums']['items'];
        allSongs.addAll(tracks);

        // Check if there are more pages
        final int totalItems = jsonData['albums']['total'];
        if ((currentPage * pageSize) >= totalItems) {
          hasNextPage = false;
        } else {
          currentPage++;
        }
      } else {
        throw Exception('Failed to load songs from Spotify API');
      }
    }

    return allSongs;
  }
}

// final String accessToken = await getAccessToken();
//  http.get(
//       Uri.parse('$apiUrl/browse/new-releases'),
//       headers: {'Authorization': 'Bearer $accessToken'},
//     );