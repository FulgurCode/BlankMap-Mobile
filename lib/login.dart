// ==========================================
// 1. LOGIN SCREEN
// ==========================================
import 'package:blankmap_mobile/main.dart';
import 'package:blankmap_mobile/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        VDivider(),
                        StatBadge(value: '6.2K', label: 'Pins'),
                        VDivider(),
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
