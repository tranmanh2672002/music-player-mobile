import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/models/song.dart';

class SongProvider extends ChangeNotifier {
  bool _isPlaying = false;
  Song? _currentSong = Song(
      id: '1',
      artist: 'artist',
      title: 'title',
      thumbnails: [
        Thumbnail(url: 'url', width: 60, height: 60),
      ],
      duration: 0);

  SongDetail? _currentSongDetail;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // getter
  bool get isPlaying => _isPlaying;
  Song? get currentSong => _currentSong;
  SongDetail? get currentSongDetail => _currentSongDetail;
  AudioPlayer get audioPlayer => _audioPlayer;

  // setter

  void setCurrentSong(Song song) async {
    _currentSong = song;
    _currentSongDetail = await getSongDetail();
    setAudioPlayerUrl(_currentSongDetail!.url);
    notifyListeners();
  }

  void setPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    if (_isPlaying) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
    notifyListeners();
  }

  void setAudioPlayerUrl(String url) {
    _audioPlayer.setSourceUrl(url);
    notifyListeners();
  }

  // api

  Future<SongDetail> getSongDetail() async {
    final uri = Uri.parse(songDetailUrl + _currentSong!.id);
    try {
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi lấy chi tiết bài hát');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final SongDetail songDetail = SongDetail.fromJson(data);
      return songDetail;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
