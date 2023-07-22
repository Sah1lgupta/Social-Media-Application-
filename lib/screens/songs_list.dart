import 'package:flutter/material.dart';

import '../api/songs_api_service.dart';
import '../widgets/songs_card.dart';




class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final SpotifyApiService _apiService = SpotifyApiService();
  List<dynamic> _songList = [];

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      final songs = await _apiService.fetchAllSongs();
      setState(() {
        _songList = songs;
      });
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (context, index) {
          final song = _songList[index];
          final String title = song['name'];
          final String artist = song['artists'][0]['name'];
          final String imageUrl = song['images'][0]['url'];

          return GestureDetector(
            child: ListTile(
              leading: Image.network(imageUrl),
              title: Text(title),
              subtitle: Text(artist),
            ),
            onTap: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SongListScreenn()));},
          );
        },
      ),
    );
  }
}