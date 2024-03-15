import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';

class SongProvider extends ChangeNotifier {
  Song? _currentSong;
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  Song? get currentSong => _currentSong;

  void setCurrentSong(Song song) {
    _currentSong = song;
    notifyListeners();
  }

  void setPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }
}
