import 'package:blankmap_mobile/blank_maps.dart';
import 'package:blankmap_mobile/login.dart';
import 'package:blankmap_mobile/maps.dart';
import 'package:flutter/material.dart';

import 'package:blankmap_mobile/shared.dart';
import 'package:blankmap_mobile/profile.dart';

void main() {
  runApp(const BlankMapApp());
}

class BlankMapApp extends StatelessWidget {
  const BlankMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlankMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: BM.accent,
        scaffoldBackgroundColor: BM.bg,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: BM.textPri,
            fontFamily: '.SF Pro Display',
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
          secondary: BM.accent,
          primary: BM.accent,
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
  int _currentIndex = 0;

  void _goToMap(String layer) {
    setState(() {
      _activeLayer = layer;
      _currentIndex = 0; // Switch to The Map tab
    });
  }

  @override
  Widget build(BuildContext context) {
    // These are the pages corresponding to the tabs
    final List<Widget> pages = [
      MapScreen(
        activeLayer: _activeLayer,
        onLayerChanged: (l) => setState(() => _activeLayer = l),
      ),
      BlankMapsScreen(onTagSelected: _goToMap),
      ProfileScreen(username: widget.username),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BM.surface,
        selectedItemColor: BM.accent,
        unselectedItemColor: BM.textTer,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'The Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'BlankMaps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}