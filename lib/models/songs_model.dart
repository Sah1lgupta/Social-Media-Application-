class SongModel {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.url,
    required this.imageUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json['title'],
      artist: json['artist']['name'],
      url: json['url'],
      imageUrl: json['imageUrl'],
    );
  }
}