import 'package:flutter/material.dart';
import 'package:music_player_app/components/player_navagator.dart';
import 'package:music_player_app/components/player_popup.dart';
import 'package:music_player_app/constants.dart';
import 'package:music_player_app/provider/playlist_provider.dart';
import 'package:music_player_app/provider/device_provider.dart';
import 'package:music_player_app/provider/search_provider.dart';
import 'package:music_player_app/provider/song_provider.dart';
import 'package:music_player_app/screens/playlist_screen.dart';
import 'package:music_player_app/screens/home_screen.dart';
import 'package:music_player_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontSize: 32,
            ),
            headlineSmall: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var songProvider = Provider.of<SongProvider>(context);
    Widget currentWidgetPage = const Text('!!!');
    AppBar? currentAppBar = AppBar(
      title: const Text(
        'Music',
        style: TextStyle(
          color: textColor,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    switch (selectedIndex) {
      case 0:
        currentAppBar = HomeAppBar();
        currentWidgetPage = const HomeScreen();
        break;
      case 1:
        currentAppBar = null;
        currentWidgetPage = const SearchScreen();
        break;
      case 2:
        currentAppBar = AppBar(
          title: const Text(
            'Music 2',
            style: TextStyle(
              color: textColor,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        );
        currentWidgetPage = Row(children: [
          Container(height: 800, child: const Text('History page'))
        ]);
        break;
      case 3:
        currentAppBar = PlaylistAppBar();
        currentWidgetPage = const PlaylistScreen();
        break;
    }

    void showMusicPlayerPopup(BuildContext context) {
      showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation first, Animation second) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primaryColor,
              child: const Column(
                children: [
                  PlayerPopup(),
                ],
              ),
            ),
          );
        },
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubicEmphasized,
            )),
            child: child,
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: currentAppBar,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: iconColorActive,
            unselectedItemColor: iconColorInactive,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: 'Tìm kiếm'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_outlined), label: 'Lịch sử'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Yêu thích'),
            ]),
        body: Stack(children: [
          Container(
              color: Theme.of(context).primaryColor, child: currentWidgetPage),
          songProvider.currentSong != null
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      showMusicPlayerPopup(context);
                    },
                    child: MusicPlayerSheet(),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
