import 'dart:convert';

Song songFromJson(String str) => Song.fromJson(json.decode(str));

String songToJson(Song data) => json.encode(data.toJson());

class Song {
  String id;
  String title;
  String artist;
  List<Thumbnail> thumbnails;
  int duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnails,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        title: json["title"],
        artist: json["artist"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artist": artist,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "duration": duration,
      };
}

class Thumbnail {
  String url;
  int width;
  int height;

  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
