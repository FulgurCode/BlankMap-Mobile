// ==========================================
// 6. PROFILE SCREEN
// ==========================================
import 'package:flutter/cupertino.dart';
import 'package:blankmap_mobile/shared.dart';

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
                    VDivider(),
                    StatBadge(value: '850', label: 'Civic Karma'),
                    VDivider(),
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
                    KRow(label: 'Pins Verified', value: '+400'),
                    KRow(label: 'Upvotes Received', value: '+310'),
                    KRow(label: 'Reports Confirmed', value: '+140'),
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
