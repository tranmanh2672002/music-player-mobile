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
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: iconColor,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: iconColor,
                    )),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    song.currentSongDetail?.thumbnails[4].url as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/music.png',
                        width: 240,
                        height: 240,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(
                        song.currentSongDetail?.title as String,
                        style: const TextStyle(
                          fontSize: 18,
                          color: textColor,
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 40,
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        song.currentSongDetail?.artist as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: textColor,
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
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
