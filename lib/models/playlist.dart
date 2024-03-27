import 'dart:convert';

Playlist albumFromJson(String str) => Playlist.fromJson(json.decode(str));

String albumToJson(Playlist data) => json.encode(data.toJson());

class Playlist {
  String id;
  String name;
  List<String> songIds;

  Playlist({
    required this.name,
    required this.songIds,
    required this.id,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        name: json["name"],
        songIds: List<String>.from(json["songIds"].map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "songIds": List<String>.from(songIds.map((x) => x)),
        "id": id,
      };
}
