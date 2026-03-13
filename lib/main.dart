import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, BoxShadow, LinearGradient;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

// ==========================================
// THEME CONSTANTS
// ==========================================
class BM {
  static const bg = Color(0xFF080C18); // deep navy black
  static const surface = Color(0xFF0F1623); // card surface
  static const surfaceAlt = Color(0xFF172030); // elevated surface
  static const border = Color(0xFF1E2A3D); // subtle border
  static const accent = Color(0xFF00E5BE); // electric teal
  static const accentSoft = Color(0x1A00E5BE); // transparent teal
  static const accentGlow = Color(0x4400E5BE); // glow teal
  static const blue = Color(0xFF3B82F6); // cool blue
  static const textPri = Color(0xFFEDF2FF); // near-white
  static const textSec = Color(0xFF7B90B2); // muted blue-grey
  static const textTer = Color(0xFF3D5066); // very muted
  static const danger = Color(0xFFFF4D6D); // coral
  static const warn = Color(0xFFFFAB2E); // amber
  static const success = Color(0xFF00C98D); // green
}

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
// SHARED WIDGETS
// ==========================================

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 18,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: BM.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border ?? BM.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class AccentButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const AccentButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: BM.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: BM.accentGlow,
              blurRadius: 22,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: BM.bg, size: 18),
              const SizedBox(width: 9),
            ],
            Text(
              label,
              style: const TextStyle(
                color: BM.bg,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: BM.border);
}

class StatBadge extends StatelessWidget {
  final String value;
  final String label;

  const StatBadge({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: BM.accent,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: BM.textSec,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// ALL BLANKMAPS DATA
// ==========================================
final List<Map<String, dynamic>> allBlankMaps = [
  {
    'tag': 'r/Dustbins',
    'desc': 'Track public dustbins to stop littering.',
    'pins': '1,204',
    'icon': CupertinoIcons.trash,
    'hot': true,
  },
  {
    'tag': 'r/Potholes',
    'desc': 'Warning tags for dangerous road damage.',
    'pins': '842',
    'icon': CupertinoIcons.exclamationmark_triangle,
    'hot': true,
  },
  {
    'tag': 'r/CleanToilets',
    'desc': 'Verified usable public restrooms.',
    'pins': '610',
    'icon': CupertinoIcons.checkmark_shield,
    'hot': false,
  },
  {
    'tag': 'r/SafeWalking',
    'desc': 'Well-lit, safe routes for night walks.',
    'pins': '430',
    'icon': CupertinoIcons.moon_stars,
    'hot': false,
  },
  {
    'tag': 'r/FreeWater',
    'desc': 'Public drinking water points.',
    'pins': '290',
    'icon': CupertinoIcons.drop,
    'hot': false,
  },
  {
    'tag': 'r/StreetFood',
    'desc': 'Best street food verified by locals.',
    'pins': '780',
    'icon': CupertinoIcons.cart,
    'hot': true,
  },
  {
    'tag': 'r/BrokenLights',
    'desc': 'Broken streetlights and dark zones.',
    'pins': '215',
    'icon': CupertinoIcons.lightbulb,
    'hot': false,
  },
  {
    'tag': 'r/PublicParks',
    'desc': 'Clean and accessible public parks.',
    'pins': '320',
    'icon': CupertinoIcons.tree,
    'hot': false,
  },
  {
    'tag': 'r/Flooding',
    'desc': 'Waterlogging zones during monsoon.',
    'pins': '198',
    'icon': CupertinoIcons.cloud_rain,
    'hot': false,
  },
  {
    'tag': 'r/ATMs',
    'desc': 'Working ATMs in your area.',
    'pins': '540',
    'icon': CupertinoIcons.creditcard,
    'hot': false,
  },
  {
    'tag': 'r/Hospitals',
    'desc': 'Accessible public hospitals and clinics.',
    'pins': '410',
    'icon': CupertinoIcons.heart_circle,
    'hot': false,
  },
  {
    'tag': 'r/FreeWifi',
    'desc': "Public WiFi hotspots that actually work.",
    'pins': '370',
    'icon': CupertinoIcons.wifi,
    'hot': false,
  },
  {
    'tag': 'r/Pharmacies',
    'desc': 'Open pharmacies and medical stores.',
    'pins': '260',
    'icon': CupertinoIcons.bandage,
    'hot': false,
  },
  {
    'tag': 'r/BusStops',
    'desc': 'Working bus stops with route info.',
    'pins': '890',
    'icon': CupertinoIcons.bus,
    'hot': true,
  },
  {
    'tag': 'r/EVCharging',
    'desc': 'Electric vehicle charging stations.',
    'pins': '145',
    'icon': CupertinoIcons.car,
    'hot': false,
  },
  {
    'tag': 'r/StrayAnimals',
    'desc': 'Feeding spots and shelters for strays.',
    'pins': '175',
    'icon': CupertinoIcons.paw,
    'hot': false,
  },
  {
    'tag': 'r/NoisePollution',
    'desc': 'Zones with excessive noise complaints.',
    'pins': '132',
    'icon': CupertinoIcons.speaker_slash,
    'hot': false,
  },
  {
    'tag': 'r/Libraries',
    'desc': 'Free public libraries and reading rooms.',
    'pins': '88',
    'icon': CupertinoIcons.book,
    'hot': false,
  },
];

final List<Map<String, dynamic>> trendingMaps = allBlankMaps
    .where((m) => m['hot'] == true)
    .toList();

// ==========================================
// 1. LOGIN SCREEN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _ctrl = TextEditingController();
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_ctrl.text.trim().isEmpty) return;
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => MainNav(username: _ctrl.text.trim())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: BM.bg,
      child: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),

                  // Logo
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: BM.accentSoft,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: BM.accent.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.layers_alt,
                      color: BM.accent,
                      size: 28,
                    ),
                  ),

                  const SizedBox(height: 26),

                  const Text(
                    'BlankMap.',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: BM.textPri,
                      letterSpacing: -2,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Gradient subtitle
                  ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [BM.accent, Color(0xFF3B82F6)],
                    ).createShader(b),
                    child: const Text(
                      'Your city. Uncensored.',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Commercial maps hide what matters.\n'
                    'BlankMap is built by citizens, for citizens.',
                    style: TextStyle(
                      fontSize: 14,
                      color: BM.textSec,
                      height: 1.65,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Stats card
                  GlassCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 22,
                      horizontal: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        StatBadge(value: '18', label: 'SubMaps'),
                        _VDivider(),
                        StatBadge(value: '6.2K', label: 'Pins'),
                        _VDivider(),
                        StatBadge(value: '840+', label: 'Citizens'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Username field
                  Container(
                    decoration: BoxDecoration(
                      color: BM.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: BM.border),
                    ),
                    child: CupertinoTextField(
                      controller: _ctrl,
                      placeholder: 'Choose a civic username',
                      placeholderStyle: const TextStyle(
                        color: BM.textTer,
                        fontSize: 15,
                      ),
                      style: const TextStyle(color: BM.textPri, fontSize: 15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      decoration: null,
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Icon(
                          CupertinoIcons.person,
                          color: BM.accent,
                          size: 18,
                        ),
                      ),
                      onSubmitted: (_) => _login(),
                    ),
                  ),

                  const SizedBox(height: 14),

                  AccentButton(
                    label: 'Join the Map',
                    icon: CupertinoIcons.arrow_right,
                    onPressed: _login,
                  ),

                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Free forever · No ads · No data selling',
                      style: TextStyle(
                        fontSize: 12,
                        color: BM.textTer,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),
      ),
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

// ==========================================
// 3. BLANKMAPS SCREEN
// ==========================================
class BlankMapsScreen extends StatefulWidget {
  final Function(String) onTagSelected;
  const BlankMapsScreen({super.key, required this.onTagSelected});

  @override
  State<BlankMapsScreen> createState() => _BlankMapsScreenState();
}

class _BlankMapsScreenState extends State<BlankMapsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isSearching = false;
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_query.isEmpty) return allBlankMaps;
    final q = _query.toLowerCase();
    return allBlankMaps
        .where(
          (m) =>
              (m['tag'] as String).toLowerCase().contains(q) ||
              (m['desc'] as String).toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: BM.bg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: BM.bg,
        border: const Border(bottom: BorderSide(color: BM.border, width: 0.5)),
        middle: const Text(
          'BlankMaps',
          style: TextStyle(
            color: BM.textPri,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: BM.accentSoft,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: BM.accent.withOpacity(0.3)),
          ),
          child: Text(
            '${allBlankMaps.length} maps',
            style: const TextStyle(
              color: BM.accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: _SearchBar(
                  controller: _searchCtrl,
                  isSearching: _isSearching,
                  onTap: () => setState(() => _isSearching = true),
                  onChanged: (v) => setState(() => _query = v),
                  onClear: () {
                    setState(() {
                      _isSearching = false;
                      _query = '';
                      _searchCtrl.clear();
                      FocusScope.of(context).unfocus();
                    });
                  },
                ),
              ),
            ),

            if (!_isSearching) ...[
              // Trending header
              SliverToBoxAdapter(
                child: _SectionHeader(
                  icon: CupertinoIcons.flame_fill,
                  iconColor: BM.warn,
                  title: 'Trending Today',
                  topPad: 22,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => _MapCard(
                      item: trendingMaps[i],
                      onTap: () => widget.onTagSelected(trendingMaps[i]['tag']),
                      showHot: true,
                    ),
                    childCount: trendingMaps.length,
                  ),
                ),
              ),
              // All header
              SliverToBoxAdapter(
                child: _SectionHeader(
                  icon: CupertinoIcons.square_grid_2x2_fill,
                  iconColor: BM.textSec,
                  title: 'All BlankMaps',
                  topPad: 20,
                ),
              ),
            ],

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final list = _isSearching ? _filtered : allBlankMaps;
                    return _MapCard(
                      item: list[i],
                      onTap: () => widget.onTagSelected(list[i]['tag']),
                    );
                  },
                  childCount: _isSearching
                      ? _filtered.length
                      : allBlankMaps.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isSearching;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchBar({
    required this.controller,
    required this.isSearching,
    required this.onTap,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: BM.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSearching ? BM.accent : BM.border,
          width: isSearching ? 1.5 : 1.0,
        ),
        boxShadow: isSearching
            ? [BoxShadow(color: BM.accentGlow, blurRadius: 14)]
            : [],
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            color: isSearching ? BM.accent : BM.textTer,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: 'Search all BlankMaps...',
              placeholderStyle: const TextStyle(
                color: BM.textTer,
                fontSize: 15,
              ),
              style: const TextStyle(color: BM.textPri, fontSize: 15),
              decoration: null,
              onTap: onTap,
              onChanged: onChanged,
            ),
          ),
          if (isSearching)
            GestureDetector(
              onTap: onClear,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: BM.surfaceAlt,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.xmark,
                  color: BM.textSec,
                  size: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double topPad;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.topPad = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, topPad, 16, 10),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 14),
          const SizedBox(width: 7),
          Text(
            title,
            style: const TextStyle(
              color: BM.textSec,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final bool showHot;

  const _MapCard({
    required this.item,
    required this.onTap,
    this.showHot = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: BM.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: BM.border),
        ),
        child: Row(
          children: [
            // Icon bubble
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: BM.accentSoft,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: BM.accent.withOpacity(0.25)),
              ),
              child: Icon(item['icon'] as IconData, color: BM.accent, size: 20),
            ),
            const SizedBox(width: 13),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item['tag'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: BM.textPri,
                        ),
                      ),
                      if (showHot && item['hot'] == true) ...[
                        const SizedBox(width: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: BM.warn.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: BM.warn.withOpacity(0.35),
                            ),
                          ),
                          child: const Text(
                            'HOT',
                            style: TextStyle(
                              color: BM.warn,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['desc'] as String,
                    style: const TextStyle(color: BM.textSec, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Pin count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['pins'] as String,
                  style: const TextStyle(
                    color: BM.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'pins',
                  style: TextStyle(color: BM.textTer, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(
              CupertinoIcons.chevron_right,
              color: BM.textTer,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. MAP PIN MODEL
// ==========================================
class MapPin {
  final String id;
  final LatLng location;
  final String layer;
  int upvotes;
  int downvotes;

  MapPin({
    required this.id,
    required this.location,
    required this.layer,
    this.upvotes = 1,
    this.downvotes = 0,
  });
}

// ==========================================
// 5. MAP SCREEN
// ==========================================
class MapScreen extends StatefulWidget {
  final String activeLayer;
  final Function(String) onLayerChanged;

  const MapScreen({
    super.key,
    required this.activeLayer,
    required this.onLayerChanged,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapCtrl = MapController();
  LatLng _userLoc = const LatLng(28.6315, 77.2167);
  bool _locLoaded = false;

  static final List<MapPin> _pins = [];

  final List<String> _quickLayers = allBlankMaps
      .take(6)
      .map((m) => m['tag'] as String)
      .toList();

  @override
  void initState() {
    super.initState();
    _initLoc();
  }

  Future<void> _initLoc() async {
    try {
      bool svcOn = await Geolocator.isLocationServiceEnabled();
      if (!svcOn) return;
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.denied) return;
      }
      if (perm == LocationPermission.deniedForever) return;

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final loc = LatLng(pos.latitude, pos.longitude);
      if (mounted) {
        setState(() {
          _userLoc = loc;
          _locLoaded = true;
        });
        _mapCtrl.move(loc, 15.5);
      }
    } catch (_) {}
  }

  void _dropPin() {
    setState(() {
      _pins.add(
        MapPin(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          location: _mapCtrl.camera.center,
          layer: widget.activeLayer,
        ),
      );
    });
    _toast('Pinned to ${widget.activeLayer}  ·  +10 Karma');
  }

  void _toast(String msg) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Align(
        alignment: const Alignment(0, 0.75),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: BM.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: BM.border),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.45), blurRadius: 24),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: BM.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  msg,
                  style: const TextStyle(
                    color: BM.textPri,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void _showPinSheet(MapPin pin) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 32),
          decoration: BoxDecoration(
            color: BM.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: BM.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: BM.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Icon
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: BM.accentSoft,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: BM.accent.withOpacity(0.35)),
                ),
                child: const Icon(
                  CupertinoIcons.location_solid,
                  color: BM.accent,
                  size: 26,
                ),
              ),
              const SizedBox(height: 14),

              Text(
                pin.layer,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: BM.textPri,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${pin.location.latitude.toStringAsFixed(5)}, '
                '${pin.location.longitude.toStringAsFixed(5)}',
                style: const TextStyle(color: BM.textTer, fontSize: 11),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: BM.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BM.success.withOpacity(0.3)),
                ),
                child: const Text(
                  '✓  Community Verified',
                  style: TextStyle(
                    color: BM.success,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  // Works
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setSheet(() => pin.upvotes++);
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: BM.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: BM.success.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              CupertinoIcons.hand_thumbsup_fill,
                              color: BM.success,
                              size: 22,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${pin.upvotes}  Works',
                              style: const TextStyle(
                                color: BM.success,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Broken
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setSheet(() => pin.downvotes++);
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: BM.danger.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: BM.danger.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              CupertinoIcons.hand_thumbsdown_fill,
                              color: BM.danger,
                              size: 22,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${pin.downvotes}  Broken',
                              style: const TextStyle(
                                color: BM.danger,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePins = _pins
        .where((p) => p.layer == widget.activeLayer)
        .toList();
    final topPad = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      backgroundColor: BM.bg,
      child: Stack(
        children: [
          // ── MAP ──────────────────────────────────
          FlutterMap(
            mapController: _mapCtrl,
            options: MapOptions(initialCenter: _userLoc, initialZoom: 15.0),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.hackathon.blankmap',
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: const DefaultLocationMarker(
                    color: BM.accent,
                    child: Icon(
                      CupertinoIcons.location_fill,
                      color: BM.bg,
                      size: 12,
                    ),
                  ),
                  markerSize: const Size(30, 30),
                  accuracyCircleColor: BM.accentSoft,
                  headingSectorColor: BM.accentGlow,
                ),
              ),
              MarkerLayer(
                markers: activePins.map((pin) {
                  return Marker(
                    point: pin.location,
                    width: 44,
                    height: 50,
                    child: GestureDetector(
                      onTap: () => _showPinSheet(pin),
                      child: Column(
                        children: const [
                          Icon(
                            CupertinoIcons.location_solid,
                            color: BM.accent,
                            size: 38,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // ── CROSSHAIR ────────────────────────────
          const Center(
            child: Icon(CupertinoIcons.plus, color: Colors.black54, size: 26),
          ),

          // ── TOP GRADIENT + LAYER CHIPS ────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: topPad + 8, bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [BM.bg.withOpacity(0.96), BM.bg.withOpacity(0.0)],
                  stops: const [0.35, 1.0],
                ),
              ),
              child: SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: _quickLayers.length,
                  itemBuilder: (_, i) {
                    final l = _quickLayers[i];
                    final sel = l == widget.activeLayer;
                    return GestureDetector(
                      onTap: () => widget.onLayerChanged(l),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: sel ? BM.accent : BM.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: sel ? BM.accent : BM.border,
                          ),
                          boxShadow: sel
                              ? [
                                  BoxShadow(
                                    color: BM.accentGlow,
                                    blurRadius: 12,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          l,
                          style: TextStyle(
                            color: sel ? BM.bg : BM.textSec,
                            fontSize: 12,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // ── LOCATE ME BUTTON ─────────────────────
          Positioned(
            top: topPad + 58,
            right: 14,
            child: GestureDetector(
              onTap: () {
                if (_locLoaded) _mapCtrl.move(_userLoc, 16.0);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: BM.surface,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: BM.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  _locLoaded
                      ? CupertinoIcons.location_fill
                      : CupertinoIcons.location,
                  color: _locLoaded ? BM.accent : BM.textTer,
                  size: 18,
                ),
              ),
            ),
          ),

          // ── GPS LOADING ───────────────────────────
          if (!_locLoaded)
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: BM.surface,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: BM.border),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoActivityIndicator(color: BM.accent),
                      SizedBox(width: 10),
                      Text(
                        'Finding your location...',
                        style: TextStyle(
                          color: BM.textSec,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── DROP PIN BUTTON ───────────────────────
          Positioned(
            bottom: 20,
            left: 18,
            right: 18,
            child: GestureDetector(
              onTap: _dropPin,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: BM.accent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: BM.accentGlow,
                      blurRadius: 28,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.location_fill,
                      color: BM.bg,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Pin to ${widget.activeLayer}',
                      style: const TextStyle(
                        color: BM.bg,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: BM.bg,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: BM.bg,
        border: Border(bottom: BorderSide(color: BM.border, width: 0.5)),
        middle: Text(
          'Profile',
          style: TextStyle(
            color: BM.textPri,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Avatar with glow
              Stack(
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [BM.accent, Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: BM.accentGlow, blurRadius: 22),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.person_solid,
                      color: BM.bg,
                      size: 44,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: BM.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: BM.bg, width: 2.5),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: BM.textPri,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: BM.accentSoft,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BM.accent.withOpacity(0.3)),
                ),
                child: const Text(
                  'Civic Contributor',
                  style: TextStyle(
                    color: BM.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // Stats
              GlassCard(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    StatBadge(value: '42', label: 'Pins Dropped'),
                    _VDivider(),
                    StatBadge(value: '850', label: 'Civic Karma'),
                    _VDivider(),
                    StatBadge(value: '3', label: 'SubMaps'),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Active SubMaps
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          CupertinoIcons.layers_alt,
                          color: BM.accent,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Active SubMaps',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: BM.textPri,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['r/Dustbins', 'r/Potholes', 'r/FreeWater']
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: BM.accentSoft,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: BM.accent.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: BM.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Karma breakdown
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          CupertinoIcons.star_fill,
                          color: BM.warn,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Karma Breakdown',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: BM.textPri,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _KRow(label: 'Pins Verified', value: '+400'),
                    _KRow(label: 'Upvotes Received', value: '+310'),
                    _KRow(label: 'Reports Confirmed', value: '+140'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _KRow extends StatelessWidget {
  final String label;
  final String value;
  const _KRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: BM.textSec, fontSize: 13)),
          Text(
            value,
            style: const TextStyle(
              color: BM.accent,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
