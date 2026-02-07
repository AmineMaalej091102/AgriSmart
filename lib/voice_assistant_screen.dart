import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  final Color primaryGreen = const Color(0xFF0DF20D);
  final Color darkBg = const Color(0xFF102210);

  @override
  void initState() {
    super.initState();
    // Animates the wave movement
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background will show through
      body: Stack(
        children: [
          // 1. Simulating the background app content (Dimmed/Grayscale)
          _buildBackgroundMockup(),

          // 2. The Glass Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: darkBg.withOpacity(0.85),
                child: SafeArea(
                  child: Column(
                    children: [
                      _buildTopBar(context),
                      const Spacer(),
                      _buildListeningStatus(),
                      const Spacer(),
                      _buildSuggestionsSection(),
                      const SizedBox(height: 120), // Space for waves
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. The Animated Waves & Mic Button
          _buildAnimatedWaves(),
        ],
      ),
    );
  }

  Widget _buildBackgroundMockup() {
    return Positioned.fill(
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: Opacity(
          opacity: 0.3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'AgriSmart AI',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildListeningStatus() {
    return Column(
      children: [
        Text(
          'Listening...',
          style: GoogleFonts.inter(
            color: primaryGreen,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            '"Check the soil moisture in Sector B"',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionsSection() {
    return Column(
      children: [
        Text(
          'TRY SAYING',
          style: TextStyle(
            color: primaryGreen.withOpacity(0.7),
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _buildChip(Icons.filter_center_focus, 'Scan this plant'),
            _buildChip(Icons.water_drop, 'Turn on irrigation'),
            _buildChip(Icons.wb_sunny, 'Weather forecast'),
            _buildChip(Icons.sensors, 'Check sensor status'),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: primaryGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: primaryGreen, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedWaves() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 240,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Pulse 1
              _buildPulseCircle(
                1.0 + (_waveController.value * 0.5),
                0.3 - (_waveController.value * 0.3),
              ),
              // Pulse 2
              _buildPulseCircle(
                1.0 + ((_waveController.value + 0.5) % 1.0 * 0.5),
                0.3 - ((_waveController.value + 0.5) % 1.0 * 0.3),
              ),

              // Central Mic Button
              GestureDetector(
                onTap: () => Navigator.pop(context), // Close on tap
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.5),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Icon(Icons.mic, color: darkBg, size: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPulseCircle(double scale, double opacity) {
    return Transform.scale(
      scale: scale,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: primaryGreen.withOpacity(opacity.clamp(0, 1)),
            width: 2,
          ),
        ),
      ),
    );
  }
}
