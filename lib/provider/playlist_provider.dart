import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PlaylistProvider extends ChangeNotifier {
  Playlist? _currentPlaylist;
  PlaylistDetail? _currentPlaylistDetail;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // getter

  Playlist? get currentPlaylist => _currentPlaylist;
  PlaylistDetail? get currentPlaylistDetail => _currentPlaylistDetail;

  // setter
  void setCurrentPlaylist(Playlist playlist) {
    _currentPlaylist = playlist;
    notifyListeners();
  }

  // api
  Future<String> getDeviceId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  Future<List<Playlist>> getListPlaylist() async {
    final deviceId = await getDeviceId();
    final uri = Uri.parse('$getPlaylistUrl/$deviceId');
    try {
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi tải playlists');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final List<Playlist> playlists = (data as List<dynamic>).map((playlist) {
        return Playlist.fromJson(playlist);
      }).toList();
      return playlists;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  void getDetailPlaylist() async {
    final id = _currentPlaylist!.id;
    final uri = Uri.parse('$getDetailPlaylistUrl/$id');
    try {
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi tải playlist detail');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final PlaylistDetail playlist = PlaylistDetail.fromJson(data as dynamic);
      _currentPlaylistDetail = playlist;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
