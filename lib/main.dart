import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

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
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.tealAccent,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 1. LOGIN SCREEN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _login() {
    if (_nameController.text.trim().isEmpty) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MainNavigationScreen(username: _nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.layers, size: 60, color: Colors.tealAccent),
              const SizedBox(height: 20),
              const Text(
                'BlankMap.',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Commercial maps are broken.\nTake back your city. Map what actually matters.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Choose a Civic Username',
                  labelStyle: const TextStyle(color: Colors.tealAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.tealAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Join the Map',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. ALL BLANKMAPS DATA (shared globally)
// ==========================================
final List<Map<String, dynamic>> allBlankMaps = [
  {
    'tag': 'r/Dustbins',
    'desc': 'Track public dustbins to stop littering.',
    'pins': '1,204',
    'icon': Icons.delete_outline,
  },
  {
    'tag': 'r/Potholes',
    'desc': 'Warning tags for dangerous road damage.',
    'pins': '842',
    'icon': Icons.warning_amber_rounded,
  },
  {
    'tag': 'r/CleanToilets',
    'desc': 'Verified usable public restrooms.',
    'pins': '610',
    'icon': Icons.wc,
  },
  {
    'tag': 'r/SafeWalking',
    'desc': 'Well-lit, safe routes for walking at night.',
    'pins': '430',
    'icon': Icons.directions_walk,
  },
  {
    'tag': 'r/FreeWater',
    'desc': 'Public drinking water points.',
    'pins': '290',
    'icon': Icons.water_drop,
  },
  {
    'tag': 'r/StreetFood',
    'desc': 'Best street food stalls verified by locals.',
    'pins': '780',
    'icon': Icons.fastfood,
  },
  {
    'tag': 'r/BrokenLights',
    'desc': 'Broken streetlights and dark zones.',
    'pins': '215',
    'icon': Icons.lightbulb_outline,
  },
  {
    'tag': 'r/PublicParks',
    'desc': 'Clean and accessible public parks.',
    'pins': '320',
    'icon': Icons.park,
  },
  {
    'tag': 'r/Flooding',
    'desc': 'Waterlogging-prone zones during rain.',
    'pins': '198',
    'icon': Icons.water,
  },
  {
    'tag': 'r/ATMs',
    'desc': 'Working ATMs in your area.',
    'pins': '540',
    'icon': Icons.atm,
  },
  {
    'tag': 'r/Hospitals',
    'desc': 'Accessible public hospitals and clinics.',
    'pins': '410',
    'icon': Icons.local_hospital,
  },
  {
    'tag': 'r/FreeWifi',
    'desc': 'Public WiFi hotspots that actually work.',
    'pins': '370',
    'icon': Icons.wifi,
  },
  {
    'tag': 'r/Pharmacies',
    'desc': 'Open pharmacies and medical stores.',
    'pins': '260',
    'icon': Icons.local_pharmacy,
  },
  {
    'tag': 'r/BusStops',
    'desc': 'Working bus stops with route info.',
    'pins': '890',
    'icon': Icons.directions_bus,
  },
  {
    'tag': 'r/EVCharging',
    'desc': 'Electric vehicle charging stations.',
    'pins': '145',
    'icon': Icons.electric_car,
  },
  {
    'tag': 'r/Stray Animals',
    'desc': 'Feeding spots and shelters for strays.',
    'pins': '175',
    'icon': Icons.pets,
  },
  {
    'tag': 'r/NoisePollution',
    'desc': 'Zones with excessive noise complaints.',
    'pins': '132',
    'icon': Icons.volume_off,
  },
  {
    'tag': 'r/Libraries',
    'desc': 'Free public libraries and reading rooms.',
    'pins': '88',
    'icon': Icons.menu_book,
  },
];

// Top trending (subset shown on BlankMaps home screen)
final List<Map<String, dynamic>> trendingBlankMaps = allBlankMaps
    .take(5)
    .toList();

// ==========================================
// 3. MAIN NAVIGATION
// ==========================================
class MainNavigationScreen extends StatefulWidget {
  final String username;
  const MainNavigationScreen({super.key, required this.username});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // 0 = The Map (DEFAULT)
  String _activeLayer = 'r/Dustbins';

  void _goToMapWithLayer(String layer) {
    setState(() {
      _activeLayer = layer;
      _currentIndex = 0; // Switch to The Map tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      MapScreen(
        activeLayer: _activeLayer,
        onLayerChanged: (newLayer) => setState(() => _activeLayer = newLayer),
      ),
      BlankMapsScreen(onTagSelected: _goToMapWithLayer),
      ProfileScreen(username: widget.username),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'The Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'BlankMaps',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==========================================
// 4. BLANKMAPS SCREEN (Trending + Search)
// ==========================================
class BlankMapsScreen extends StatefulWidget {
  final Function(String) onTagSelected;
  const BlankMapsScreen({super.key, required this.onTagSelected});

  @override
  State<BlankMapsScreen> createState() => _BlankMapsScreenState();
}

class _BlankMapsScreenState extends State<BlankMapsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMaps {
    if (_searchQuery.isEmpty) return allBlankMaps;
    return allBlankMaps
        .where(
          (map) =>
              (map['tag'] as String).toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              (map['desc'] as String).toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BlankMaps',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Discover community-built civic layers.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 12),

                // Search Bar
                GestureDetector(
                  onTap: () => setState(() => _isSearching = true),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _isSearching
                            ? Colors.tealAccent
                            : Colors.grey.shade800,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 2,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.tealAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            autofocus: false,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search all BlankMaps...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onTap: () => setState(() => _isSearching = true),
                            onChanged: (val) =>
                                setState(() => _searchQuery = val),
                          ),
                        ),
                        if (_isSearching)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSearching = false;
                                _searchQuery = '';
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Trending label (only when not searching)
          if (!_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.whatshot,
                    color: Colors.orangeAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Trending Today',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: _isSearching
                  ? _filteredMaps.length
                  : trendingBlankMaps.length,
              itemBuilder: (context, index) {
                final item = _isSearching
                    ? _filteredMaps[index]
                    : trendingBlankMaps[index];
                return Card(
                  color: Colors.grey.shade900,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.tealAccent.withOpacity(0.15),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Colors.tealAccent,
                      ),
                    ),
                    title: Text(
                      item['tag'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        item['desc'] as String,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['pins'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.tealAccent,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => widget.onTagSelected(item['tag'] as String),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. MAP PIN DATA MODEL
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
// 6. THE MAP SCREEN
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
  final MapController _mapController = MapController();

  // Fallback center (New Delhi) used until GPS kicks in
  LatLng _center = const LatLng(28.6315, 77.2167);
  bool _locationLoaded = false;

  static final List<MapPin> _globalPins = [];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final userLatLng = LatLng(position.latitude, position.longitude);

    if (mounted) {
      setState(() {
        _center = userLatLng;
        _locationLoaded = true;
      });
      // Animate map to user's real location
      _mapController.move(userLatLng, 15.0);
    }
  }

  void _dropPin() {
    setState(() {
      _globalPins.add(
        MapPin(
          id: DateTime.now().toString(),
          location: _mapController.camera.center,
          layer: widget.activeLayer,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pinned to ${widget.activeLayer}! +10 Civic Karma 🎯'),
        backgroundColor: Colors.teal.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showPinDetails(MapPin pin) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    pin.layer,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lat: ${pin.location.latitude.toStringAsFixed(5)}, Lng: ${pin.location.longitude.toStringAsFixed(5)}',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Community Verified Location',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          setModalState(() => pin.upvotes++);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          '${pin.upvotes} Works',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          setModalState(() => pin.downvotes++);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.thumb_down,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          '${pin.downvotes} Broken',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePins = _globalPins
        .where((pin) => pin.layer == widget.activeLayer)
        .toList();

    // Only show top 5 layers as quick chips on the map
    final quickLayers = allBlankMaps
        .take(5)
        .map((m) => m['tag'] as String)
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // 1. OpenStreetMap
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: _center, initialZoom: 15.0),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.hackathon.blankmap',
              ),
              // Live location blue dot
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: const DefaultLocationMarker(
                    color: Colors.tealAccent,
                    child: Icon(
                      Icons.person_pin,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                  markerSize: const Size(28, 28),
                  accuracyCircleColor: Colors.tealAccent.withOpacity(0.15),
                  headingSectorColor: Colors.tealAccent.withOpacity(0.5),
                ),
              ),
              // Dropped pins
              MarkerLayer(
                markers: activePins.map((pin) {
                  return Marker(
                    point: pin.location,
                    width: 44,
                    height: 44,
                    child: GestureDetector(
                      onTap: () => _showPinDetails(pin),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.tealAccent,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 2. Crosshair
          const Center(child: Icon(Icons.add, color: Colors.black54, size: 30)),

          // 3. Floating Layer Chips (top of map)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: quickLayers.length,
                itemBuilder: (context, index) {
                  final layer = quickLayers[index];
                  final isSelected = layer == widget.activeLayer;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        layer,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.tealAccent,
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (selected) {
                        if (selected) widget.onLayerChanged(layer);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // 4. Location loading indicator
          if (!_locationLoaded)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.tealAccent,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Finding your location...',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // 5. Locate Me button (top-right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 66,
            right: 14,
            child: GestureDetector(
              onTap: () {
                if (_locationLoaded) {
                  _mapController.move(_center, 16.0);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.tealAccent,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _dropPin,
        backgroundColor: Colors.tealAccent,
        icon: const Icon(Icons.add_location_alt, color: Colors.black),
        label: Text(
          'Pin to ${widget.activeLayer}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ==========================================
// 7. PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.tealAccent,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Civic Contributor',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '42',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pins Dropped',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '850',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Civic Karma', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Active SubMaps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['r/Dustbins', 'r/Potholes', 'r/FreeWater']
                        .map(
                          (tag) => Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: Colors.tealAccent,
                            padding: EdgeInsets.zero,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
