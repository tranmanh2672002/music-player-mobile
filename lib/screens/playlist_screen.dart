import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:music_player_app/provider/page_provider.dart';
import 'package:music_player_app/provider/playlist_provider.dart';
import 'package:music_player_app/provider/device_provider.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:music_player_app/screens/playlist_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    return Container(
      margin: songProvider.currentSong != null
          ? const EdgeInsets.only(bottom: 60)
          : null,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            PlaylistCreate(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: PlaylistList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaylistList extends StatelessWidget {
  const PlaylistList({super.key});

  @override
  Widget build(BuildContext context) {
    var playlistProvider = Provider.of<PlaylistProvider>(context);
    return FutureBuilder(
      future: playlistProvider.getListPlaylist(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Playlist> albums = snapshot.data as List<Playlist>;
          return ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, index) {
              return PlaylistItem(
                playlist: albums[index],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;

  const PlaylistItem({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PageProvider>(context);
    return GestureDetector(
      onTap: () {
        pageProvider.setCurrentPage(4);
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/album_default.png',
                  width: 80,
                  height: 80,
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
                        playlist.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        playlist.songIds.length.toString() + ' bài hát',
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
              const Spacer(), // Hoặc Expanded(flex: 1)
              const Icon(
                Icons.delete_outline,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaylistCreate extends StatelessWidget {
  const PlaylistCreate({super.key});

  @override
  Widget build(BuildContext context) {
    void showPlaylistDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PlaylistDialog();
        },
      );
    }

    return GestureDetector(
      onTap: () {
        showPlaylistDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: textColor, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: primaryColorOpacity,
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.add,
                color: textColor,
              ),
            ),
            Text(
              'Tạo playlist',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistDialog extends StatelessWidget {
  const PlaylistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistProvider = Provider.of<PlaylistProvider>(context);
    final TextEditingController inputNameController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    final deviceProvider = Provider.of<DeviceProvider>(context);

    focusNode.requestFocus();

    void createPlaylist(String name, String deviceId) async {
      final url = Uri.parse(createPlaylistUrl);
      final body = {
        'name': name,
        'deviceId': deviceId,
      };

      final response = await post(
        url,
        body: body,
      );
      if (response.statusCode != 200) {
        throw Exception('Lỗi tạo playlist');
      } else {
        Navigator.pop(context);
        playlistProvider.refresh();
      }
    }

    void handleCreatePlaylist() async {
      final deviceId = await deviceProvider.getDeviceId();
      createPlaylist(inputNameController.text, deviceId);
    }

    return Dialog(
      child: Container(
        height: 220,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                focusNode: focusNode,
                controller: inputNameController,
                decoration: const InputDecoration(
                  labelText: 'Nhập tên playlist',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                handleCreatePlaylist();
              },
              style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
              child: const Text(
                'Tạo playlist',
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistAppBar extends AppBar {
  PlaylistAppBar()
      : super(
          key: const ValueKey("album_app_bar"),
          backgroundColor: primaryColor,
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 26,
                height: 26,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Danh sách nhạc',
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        );
}
