import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class MusicPlayerSheet extends StatefulWidget {
  @override
  _MusicPlayerSheetState createState() => _MusicPlayerSheetState();
}

class _MusicPlayerSheetState extends State<MusicPlayerSheet> {
  @override
  Widget build(BuildContext context) {
    var song = Provider.of<SongProvider>(context);
    return Container(
      height: 66,
      color: secondaryColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  song.currentSong?.thumbnails[0].url as String,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/music.png',
                      width: 40,
                      height: 40,
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
                      constraints: const BoxConstraints(maxWidth: 180),
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        song.currentSong?.title as String,
                        style: const TextStyle(
                          fontSize: 15,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        song.currentSong?.artist as String,
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded, color: iconColor),
              ),
            ],
          )),
    );
  }
}
