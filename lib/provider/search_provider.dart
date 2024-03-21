import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  String _keyword = '';
  Timer? _debounce;
  bool _isFetching = false;
  List<Song> _songs = [];
  // getter
  TextEditingController? get searchController => _searchController;
  List<Song> get songs => _songs;
  bool get isFetching => _isFetching;

  // setter
  void setKeyword(String keyword) {
    _keyword = keyword;
    notifyListeners();
  }

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (_keyword != _searchController.text) {
        setKeyword(_searchController.text);
        if (_keyword.isNotEmpty) {
          getSongs();
        } else {
          _songs = [];
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void getSongs() async {
    final uri = Uri.parse(songsUrl).replace(queryParameters: {
      'keyword': _keyword,
    });
    try {
      _isFetching = true;
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi tìm kiếm dữ liệu');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      _isFetching = false;
      _songs = (data as List<dynamic>).map((song) {
        return Song.fromJson(song);
      }).toList();
      print(_songs);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    notifyListeners();
  }
}
