import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/helpers.dart';
import 'package:music_player_app/models/song.dart';

class SongProvider extends ChangeNotifier {
  bool _isPlaying = false;
  Song? _currentSong;
  SongDetail? _currentSongDetail;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _currentPosition = '00:00';
  String _duration = '00:00';

  // getter
  bool get isPlaying => _isPlaying;
  Song? get currentSong => _currentSong;
  SongDetail? get currentSongDetail => _currentSongDetail;
  AudioPlayer get audioPlayer => _audioPlayer;
  String get currentPosition => _currentPosition;
  String get duration => _duration;

  // setter

  void setCurrentSong(Song song) async {
    _currentSong = song;
    _currentSongDetail = await getSongDetail();
    setAudioPlayerUrl(_currentSongDetail!.url);
    setPlaying(true);
    notifyListeners();
  }

  void setPlaying(bool isPlaying) async {
    _isPlaying = isPlaying;
    if (_isPlaying) {
      await _audioPlayer.resume();
    } else {
      await _audioPlayer.pause();
    }
    notifyListeners();
  }

  void setAudioPlayerUrl(String url) async {
    await _audioPlayer.setSourceUrl(url);
    final data = await _audioPlayer.getDuration();
    _duration = convertToTimeMusic(data as Duration);
    _audioPlayer.onPositionChanged.listen((event) {
      _currentPosition = convertToTimeMusic(event);
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      notifyListeners();
    });
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
