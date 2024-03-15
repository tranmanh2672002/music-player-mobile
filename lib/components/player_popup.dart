import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PlayerPopup extends StatelessWidget {
  const PlayerPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var song = Provider.of<SongProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const RotatedBox(
                  quarterTurns: 1, // Rotates by 2 right angles (80 degrees)
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_rounded)),
            ],
          ),
          Column(
            children: <Widget>[
              Image.network(song.currentSong?.thumbnails[1].url as String),
              Column(
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      song.currentSong?.title as String,
                      style: const TextStyle(
                        fontSize: 18,
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
                        fontSize: 14,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Phần cuối trang
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shuffle_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.skip_previous_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.play_arrow_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.skip_next_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.repeat_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
