import 'package:blankmap_mobile/blank_maps.dart';
import 'package:blankmap_mobile/login.dart';
import 'package:blankmap_mobile/maps.dart';
import 'package:flutter/cupertino.dart';

import 'package:blankmap_mobile/shared.dart';
import 'package:blankmap_mobile/profile.dart';

void main() {
  runApp(const BlankMapApp());
}

class BlankMapApp extends StatelessWidget {
  const BlankMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'BlankMap',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: BM.accent,
        barBackgroundColor: BM.bg,
        scaffoldBackgroundColor: BM.bg,
        textTheme: CupertinoTextThemeData(
          primaryColor: BM.textPri,
          textStyle: TextStyle(
            color: BM.textPri,
            fontFamily: '.SF Pro Display',
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 2. MAIN NAVIGATION
// ==========================================
class MainNav extends StatefulWidget {
  final String username;
  const MainNav({super.key, required this.username});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  String _activeLayer = 'r/Dustbins';

  void _goToMap(String layer) {
    setState(() => _activeLayer = layer);
    // CupertinoTabController would be needed for programmatic switching
    // For the demo, layer is updated and user taps to The Map tab
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: BM.bg,
      tabBar: CupertinoTabBar(
        backgroundColor: BM.surface,
        activeColor: BM.accent,
        inactiveColor: BM.textTer,
        border: const Border(top: BorderSide(color: BM.border, width: 0.5)),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            activeIcon: Icon(CupertinoIcons.map_fill),
            label: 'The Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.compass),
            activeIcon: Icon(CupertinoIcons.compass_fill),
            label: 'BlankMaps',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return MapScreen(
              activeLayer: _activeLayer,
              onLayerChanged: (l) => setState(() => _activeLayer = l),
            );
          case 1:
            return BlankMapsScreen(onTagSelected: _goToMap);
          case 2:
            return ProfileScreen(username: widget.username);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
