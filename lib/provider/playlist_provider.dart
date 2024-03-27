import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PlaylistProvider extends ChangeNotifier {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // getter
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
      final List<Playlist> albums = (data as List<dynamic>).map((album) {
        return Playlist.fromJson(album);
      }).toList();
      print(albums);
      return albums;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  void refresh() {
    notifyListeners();
  }
}
