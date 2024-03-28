import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:music_player_app/provider/page_provider.dart';
import 'package:music_player_app/provider/playlist_provider.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    var playlistProvider = Provider.of<PlaylistProvider>(context);
    return Container(
      margin: songProvider.currentSongDetail != null
          ? const EdgeInsets.only(bottom: 60)
          : null,
      child: Column(
        children: [
          const Header(),
          const Thumbnail(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              playlistProvider.currentPlaylist!.name,
              style: const TextStyle(color: textColor, fontSize: 20),
            ),
          ),
          const Expanded(child: PlaylistSongs()),
        ],
      ),
    );
  }
}

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({super.key});
  @override
  Widget build(BuildContext context) {
    var playlistProvider = Provider.of<PlaylistProvider>(context);
    var songs = playlistProvider.currentPlaylistDetail!.songs;
    return songs.isNotEmpty
        ? ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return PlaylistSongItem(song: songs[index]);
            },
          )
        : const Center(
            child: Text(
              'Không có bài hát nào',
              style: TextStyle(color: textColor),
            ),
          );
  }
}

class PlaylistSongItem extends StatelessWidget {
  final PlaylistSong song;

  const PlaylistSongItem({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    return GestureDetector(
      onTap: () {
        songProvider.setCurrentSong(song.youtubeId);
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
                  fit: BoxFit.cover,
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
                        song.name,
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
                Icons.delete_outline,
                color: iconColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Thumbnail extends StatelessWidget {
  const Thumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/album_default.png',
            width: 160,
            height: 160,
          )),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => pageProvider.setCurrentPage(3),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: iconColor,
            ),
          )
        ],
      ),
    );
  }
}
