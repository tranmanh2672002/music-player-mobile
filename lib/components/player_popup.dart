import 'package:flutter/material.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PlayerPopup extends StatelessWidget {
  const PlayerPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var song = Provider.of<SongProvider>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_downward)),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_rounded)),
            ],
          ),
          Stack(
            children: <Widget>[
              Image.network(song.currentSong?.thumbnails[1].url as String),
              Column(
                children: <Widget>[
                  Text(song.currentSong?.title as String),
                  Text(song.currentSong?.artist as String),
                  Slider(
                    value: 0.5,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
          // Phần cuối trang
          Row(
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
