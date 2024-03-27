import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/provider/page_provider.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    return Container(
      margin: songProvider.currentSong != null
          ? const EdgeInsets.only(bottom: 60)
          : null,
      child: Column(
        children: [
          const Header(),
          SizedBox(
            height: 160,
            width: 160,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/album_default.png',
                  width: 160,
                  height: 160,
                )),
          ),
        ],
      ),
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
