import 'package:flutter/material.dart';

const String appName = 'Ứng dụng nghe nhạc';
const Color primaryColor = Color.fromRGBO(10, 7, 30, 1);
const Color secondaryColor = Color.fromRGBO(68, 68, 148, 1);
const Color primaryColorOpacity = Color.fromRGBO(10, 7, 30, 0.1);

// icons
const Color iconColor = Colors.white;
const Color iconColorInactive = Color.fromRGBO(142, 142, 142, 1);
const Color iconColorActive = Color.fromRGBO(97, 86, 226, 1);

// text
const Color textColor = Color.fromRGBO(242, 242, 242, 1);
const Color textColorSecondary = Color.fromRGBO(142, 142, 142, 1);

const Color sliderColor = Color.fromRGBO(97, 86, 226, 1);

// API
// 192.168.0.101
// 172.16.0.60
const String baseUrl = 'http://192.168.0.103:1000/api/v1';
// const String baseUrl = 'http://172.16.0.60:1000/api/v1';
const String songsUrl = '$baseUrl/music/search';
const String songDetailUrl = '$baseUrl/music/get-detail/';

// album
const String createPlaylistUrl = '$baseUrl/album/create';
const String getPlaylistUrl = '$baseUrl/album/get-list';
const String getDetailPlaylistUrl = '$baseUrl/album/get-detail';
const String addSongToPlaylistUrl = '$baseUrl/album/add-song';
const String removeSongToPlaylistUrl = '$baseUrl/album/remove-song';
const String deletePlaylistUrl = '$baseUrl/album/delete';
