// ==========================================
// 3. BLANKMAPS SCREEN
// ==========================================
import 'package:blankmap_mobile/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> trendingMaps = allBlankMaps
    .where((m) => m['hot'] == true)
    .toList();

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
