import 'package:music_player_app/models/song.dart';

class Playlist {
  final String? id;
  final String? name;
  final List<Song>? songs;

  Playlist({this.id, this.name, this.songs});
}
