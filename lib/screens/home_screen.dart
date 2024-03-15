import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/models/song.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const Text('Explore',
              style: TextStyle(fontSize: 24, color: textColor))),
      Container(
          margin: const EdgeInsets.only(top: 50), child: const MusicExplore()),
      Container(
          margin: const EdgeInsets.only(top: 230),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const Text('Trending',
              style: TextStyle(fontSize: 24, color: textColor))),
      Container(
          margin: const EdgeInsets.fromLTRB(0, 280, 0, 60),
          height: 700,
          child: const MusicTrending())
    ]);
  }
}

class MusicTrending extends StatelessWidget {
  const MusicTrending({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSongs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Song> songs = snapshot.data as List<Song>;
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return MusicTrendingItem(song: songs[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Song>> _getSongs() async {
    final uri = Uri.parse(songsUrl).replace(queryParameters: {
      'keyword': "Xếp hạng nhạc Việt",
    });
    try {
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi tải dữ liệu');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final List<Song> songs = (data as List<dynamic>).map((song) {
        return Song.fromJson(song);
      }).toList();
      return songs;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}

class MusicTrendingItem extends StatelessWidget {
  final Song song;

  const MusicTrendingItem({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SongProvider>().setCurrentSong(song);
      },
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                song.thumbnails[0].url,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/music.png',
                    width: 60,
                    height: 60,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      song.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      song.artist,
                      style: const TextStyle(
                        fontSize: 12,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Hoặc Expanded(flex: 1)
            const Icon(
              Icons.play_arrow,
              color: iconColor,
            ),
          ],
        ),
      )),
    );
  }
}

class MusicExplore extends StatelessWidget {
  const MusicExplore({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSongs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Song> songs = snapshot.data as List<Song>;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return MusicExploreItem(song: songs[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: Text(''));
      },
    );
  }

  Future<List<Song>> _getSongs() async {
    final uri = Uri.parse(songsUrl).replace(queryParameters: {
      'keyword': "Nhạc Việt mới nhất",
    });
    try {
      final response = await get(uri);
      if (response.statusCode != 200) {
        throw Exception('Lỗi tải dữ liệu');
      }
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      final List<Song> songs = (data as List<dynamic>).map((song) {
        return Song.fromJson(song);
      }).toList();
      return songs;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}

class MusicExploreItem extends StatelessWidget {
  final Song song;

  const MusicExploreItem({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<SongProvider>().setCurrentSong(song);
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            height: 200,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    song.thumbnails[1].url,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/music.png',
                        width: 110,
                        height: 110,
                      );
                    },
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    song.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class HomeAppBar extends AppBar {
  HomeAppBar()
      : super(
          key: const ValueKey("home_app_bar"),
          backgroundColor: primaryColor,
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/images/music.png',
                width: 26,
                height: 26,
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: iconColor,
              ),
              onPressed: () {},
            ),
          ],
        );
}
