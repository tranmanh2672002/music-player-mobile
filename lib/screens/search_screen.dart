import 'package:flutter/material.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/provider/search_provider.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:music_player_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    return Container(
      margin: songProvider.currentSongDetail != null
          ? const EdgeInsets.only(bottom: 60)
          : null,
      child: const Column(
        children: [SearchBar(), Expanded(child: MusicSearch())],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(11, 7, 39, 0.498),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: searchProvider.searchController,
          style: const TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: 'Nhập tên bài hát hoặc ca sĩ',
            hintStyle: const TextStyle(
              color: textColorSecondary,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: primaryColor,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              color: iconColor,
              onPressed: () {},
            ),
          ),
          onChanged: (text) {
            searchProvider.onSearchChanged();
          },
        ));
  }
}

class MusicSearch extends StatelessWidget {
  const MusicSearch({super.key});

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);
    var songs = searchProvider.songs;
    return !searchProvider.isFetching
        ? (songs.isNotEmpty
            ? ListView.builder(
                itemCount: songs.length,
                itemBuilder: (BuildContext context, int index) {
                  return MusicTrendingItem(song: songs[index]);
                },
              )
            : const Center(
                child: Text(
                  'Không có kết quả tìm kiếm',
                  style: TextStyle(color: textColor),
                ),
              ))
        : const Center(child: CircularProgressIndicator());
  }
}
