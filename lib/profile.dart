import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:blankmap_mobile/shared.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _email = '';
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.token.isNotEmpty) _fetchMe();
  }

  @override
  void didUpdateWidget(ProfileScreen old) {
    super.didUpdateWidget(old);
    // Token loads async in parent — refetch once it arrives
    if (old.token.isEmpty && widget.token.isNotEmpty) _fetchMe();
  }

  Future<void> _fetchMe() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _name = data['name'] ?? '';
          _email = data['email'] ?? '';
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load profile';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

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
        child: _loading
            ? const Center(child: CupertinoActivityIndicator(radius: 14))
            : _error != null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.wifi_slash,
                      color: BM.textTer,
                      size: 36,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: const TextStyle(color: BM.textSec, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _fetchMe,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: BM.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: BM.border),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            color: BM.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // ── Avatar ──────────────────────────────────
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

                    // ── Name ─────────────────────────────────────
                    Text(
                      _name.isNotEmpty ? _name : 'Anonymous',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: BM.textPri,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // ── Email ────────────────────────────────────
                    Text(
                      _email,
                      style: const TextStyle(color: BM.textSec, fontSize: 13),
                    ),
                    const SizedBox(height: 10),

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

                    // ── Stats ────────────────────────────────────
                    GlassCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          StatBadge(value: '42', label: 'Pins Dropped'),
                          VDivider(),
                          StatBadge(value: '850', label: 'Civic Karma'),
                          VDivider(),
                          StatBadge(value: '3', label: 'SubMaps'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Active SubMaps ────────────────────────────
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
                            children: ['Dustbins', 'Potholes', 'FreeWater']
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

                    // ── Karma Breakdown ───────────────────────────
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
                          const KRow(label: 'Pins Verified', value: '+400'),
                          const KRow(label: 'Upvotes Received', value: '+310'),
                          const KRow(label: 'Reports Confirmed', value: '+140'),
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
