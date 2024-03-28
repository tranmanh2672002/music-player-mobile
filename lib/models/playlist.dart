import 'dart:convert';

import 'package:music_player_app/models/song.dart';

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

class PlaylistDetail {
  String id;
  String name;
  List<PlaylistSong> songs;

  PlaylistDetail({
    required this.name,
    required this.songs,
    required this.id,
  });

  factory PlaylistDetail.fromJson(Map<String, dynamic> json) => PlaylistDetail(
        name: json["name"],
        songs: List<PlaylistSong>.from(
            json["songs"].map((x) => PlaylistSong.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "songs": List<dynamic>.from(songs.map((x) => toJson())),
        "_id": id,
      };
}

class PlaylistSong {
  String id;
  String name;
  String artist;
  List<Thumbnail> thumbnails;
  int duration;
  String youtubeId;

  PlaylistSong({
    required this.id,
    required this.name,
    required this.artist,
    required this.thumbnails,
    required this.duration,
    required this.youtubeId,
  });

  factory PlaylistSong.fromJson(Map<String, dynamic> json) => PlaylistSong(
        id: json["_id"],
        name: json["name"],
        artist: json["artist"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        duration: json["duration"],
        youtubeId: json["youtubeId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "artist": artist,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "duration": duration,
        "youtubeId": youtubeId,
      };
}
