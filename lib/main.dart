import 'package:blankmap_mobile/blank_maps.dart';
import 'package:blankmap_mobile/login.dart';
import 'package:blankmap_mobile/maps.dart';
import 'package:flutter/material.dart';
import 'package:blankmap_mobile/shared.dart';
import 'package:blankmap_mobile/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ).copyWith(secondary: BM.accent, primary: BM.accent),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// MAIN NAVIGATION
// ==========================================
class MainNav extends StatefulWidget {
  final String username;
  const MainNav({super.key, required this.username});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  final _storage = const FlutterSecureStorage();

  String _activeLayer = '';
  String _activeLayerId = '';
  String _token = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final t = await _storage.read(key: 'jwt') ?? '';
    setState(() => _token = t);
  }

  void _goToMap(String id, String name) {
    setState(() {
      _activeLayerId = id;
      _activeLayer = name;
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BlankMapsScreen(onTagSelected: _goToMap),
      MapScreen(
        activeLayer: _activeLayer,
        // activeLayerId: _activeLayerId,
        // token: _token,
        onLayerChanged: (name) => setState(() => _activeLayer = name),
      ),
      ProfileScreen(token: _token),
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
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'BlankMaps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'The Map',
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
