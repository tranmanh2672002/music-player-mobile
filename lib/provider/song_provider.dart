import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/models/song.dart';

class SongProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;

  bool _isLoop = false;

  Song? _currentSong;
  SongDetail? _currentSongDetail;

  Duration _currentPosition = const Duration(seconds: 0);
  Duration _duration = const Duration(seconds: 0);

  bool _isFetchingDetail = false;

  // getter
  Song? get currentSong => _currentSong;
  SongDetail? get currentSongDetail => _currentSongDetail;
  AudioPlayer get audioPlayer => _audioPlayer;
  Duration? get currentPosition => _currentPosition;
  Duration? get duration => _duration;
  PlayerState get playerState => _playerState;

  bool get isLoop => _isLoop;
  bool get isFetchingDetail => _isFetchingDetail;

  // setter

  void setCurrentSong(Song song) async {
    resetDuration();
    _currentSong = song;
    _currentSongDetail = await getSongDetail();
    setAudioPlayerUrl(_currentSongDetail!.url);
    notifyListeners();
  }

  void setAudioPlayerUrl(String url) async {
    await _audioPlayer.play(UrlSource(url));
    _playerState = PlayerState.playing;
    final data = await _audioPlayer.getDuration();
    _duration = (data as Duration);
    _audioPlayer.onPositionChanged.listen((event) {
      _currentPosition = (event);
      notifyListeners();
    });
    audioPlayer.onPlayerStateChanged.listen((state) {
      print(state);
      if (state == PlayerState.playing) {
        _playerState = PlayerState.playing;
      } else if (state == PlayerState.paused) {
        _playerState = PlayerState.paused;
      } else if (state == PlayerState.completed) {
        if (_isLoop) {
          _audioPlayer.play(UrlSource(url));
        } else {
          _playerState = PlayerState.completed;
        }
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    notifyListeners();
  }

  void play() {
    if (_playerState == PlayerState.completed &&
        currentSongDetail?.url != null) {
      _audioPlayer.play(UrlSource(currentSongDetail!.url));
    }
    _audioPlayer.resume();
    notifyListeners();
  }

  void changeToSecond(int second) {
    final Duration newDuration = Duration(seconds: second);
    _currentPosition = newDuration;
    if (_currentPosition < _duration) {
      _audioPlayer.seek(newDuration);
    }
    notifyListeners();
  }

  void resetDuration() {
    _currentPosition = const Duration(seconds: 0);
    _duration = const Duration(seconds: 0);
    notifyListeners();
  }

  // api

  Future<SongDetail> getSongDetail() async {
    final uri = Uri.parse(songDetailUrl + _currentSong!.id);
    try {
      _isFetchingDetail = true;
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi lấy chi tiết bài hát');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final SongDetail songDetail = SongDetail.fromJson(data);
      _isFetchingDetail = false;
      return songDetail;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
