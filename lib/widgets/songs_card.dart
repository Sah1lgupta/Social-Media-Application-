import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../api/songs_api_service.dart';
import '../models/songs_model.dart';

class SongListScreenn extends StatefulWidget {
  const SongListScreenn({Key? key}) : super(key: key);

  @override
  State<SongListScreenn> createState() => _SongListScreenState();
}



class _SongListScreenState extends State<SongListScreenn> {
  final SpotifyApiService _apiService = SpotifyApiService();
  List<SongModel> _songList = [];
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      final songs = await _apiService.fetchAllSongs();
      setState(() {
        _songList = songs
            .map<SongModel>((song) => SongModel.fromJson(song))
            .toList();
      });
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  Future<void> playSong(String url) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(url));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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

          return ListTile(
            leading: Image.network(song.imageUrl),
            title: Text(song.title),
            subtitle: Text(song.artist),
            onTap: () => playSong(song.url),
          );
        },
      ),
    );
  }
}
/***
 * class _SongListScreenState extends State<SongListScreen> {
    final SpotifyApiService _apiService = SpotifyApiService();
    List<SongModel> _songList = [];
    late AudioPlayer _audioPlayer;

    @override
    void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    fetchSongs();
    }

    Future<void> fetchSongs() async {
    try {
    final songs = await _apiService.fetchSongs();
    setState(() {
    _songList = songs
    .map<SongModel>((song) => SongModel.fromJson(song))
    .toList();
    });
    } catch (e) {
    print('Error fetching songs: $e');
    }
    }

    Future<void> playSong(String url) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(url);
    }

    @override
    void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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

    return ListTile(
    leading: Image.network(song.imageUrl),
    title: Text(song.title),
    subtitle: Text(song.artist),
    onTap: () => playSong(song.url),
    );
    },
    ),
    );
    }
    }
 */