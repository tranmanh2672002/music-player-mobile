import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/helpers.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:provider/provider.dart';

class PlayerPopup extends StatelessWidget {
  const PlayerPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    var value = songProvider.currentPosition!.inSeconds.toDouble() >
            songProvider.duration!.inSeconds.toDouble()
        ? 0.0
        : songProvider.currentPosition!.inSeconds.toDouble();
    return Material(
      child: Container(
        color: primaryColor,
        padding: const EdgeInsets.only(top: 30),
        child: songProvider.isFetchingDetail
            ? const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Column(
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
                            songProvider.currentSongDetail?.thumbnails[4].url
                                as String,
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
                                songProvider.currentSongDetail?.title as String,
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
                                songProvider.currentSongDetail?.artist
                                    as String,
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
                  Slider(
                    activeColor: sliderColor,
                    min: 0.0,
                    max: songProvider.duration!.inSeconds.toDouble(),
                    value: value,
                    onChanged: (value) {
                      if (value <=
                          songProvider.duration!.inSeconds.toDouble()) {
                        songProvider.changeToSecond(value.toInt());
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          convertToTimeMusic(songProvider.currentPosition),
                          style: const TextStyle(color: textColor),
                        ),
                        const Spacer(),
                        Text(
                          convertToTimeMusic(songProvider.duration),
                          style: const TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ),
                  // Phần cuối trang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon:
                            const Icon(Icons.shuffle_rounded, color: iconColor),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded,
                            color: iconColor),
                        onPressed: () {},
                      ),
                      GestureDetector(
                        onTap: () {
                          songProvider.playerState == PlayerState.playing
                              ? songProvider.pause()
                              : songProvider.play();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: songProvider.playerState == PlayerState.playing
                              ? const Icon(
                                  Icons.pause_rounded,
                                  color: iconColor,
                                  size: 40,
                                )
                              : const Icon(
                                  Icons.play_arrow_rounded,
                                  color: iconColor,
                                  size: 40,
                                ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded,
                            color: iconColor),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.repeat_rounded, color: iconColor),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
