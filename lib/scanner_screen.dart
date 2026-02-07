import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;
  final Color primaryGreen = const Color(0xFF0DF20D);
  final Color darkBg = const Color(0xFF102210);

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Column(
        children: [
          // Top App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Disease Scanner',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flashlight_on, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Viewfinder Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Mock Camera Feed
                          Positioned.fill(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?auto=format&fit=crop&q=80&w=600',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Viewfinder Corners & Scan Line
                          _buildViewfinderOverlay(),
                          // AI Status
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: _buildAIStatusBadge(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildCameraControls(),
                ],
              ),
            ),
          ),

          // Recent History Panel
          _buildHistoryPanel(),
        ],
      ),
    );
  }

  Widget _buildViewfinderOverlay() {
    return Stack(
      children: [
        // Corners
        Positioned(top: 30, left: 30, child: _corner(top: true, left: true)),
        Positioned(top: 30, right: 30, child: _corner(top: true, left: false)),
        Positioned(
          bottom: 30,
          left: 30,
          child: _corner(top: false, left: true),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: _corner(top: false, left: false),
        ),

        // Animated Scan Line
        AnimatedBuilder(
          animation: _scanController,
          builder: (context, child) {
            return Positioned(
              top:
                  MediaQuery.of(context).size.height *
                      0.4 *
                      _scanController.value +
                  50,
              left: 20,
              right: 20,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      primaryGreen,
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _corner({required bool top, required bool left}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(color: primaryGreen, width: 4)
              : BorderSide.none,
          bottom: !top
              ? BorderSide(color: primaryGreen, width: 4)
              : BorderSide.none,
          left: left
              ? BorderSide(color: primaryGreen, width: 4)
              : BorderSide.none,
          right: !left
              ? BorderSide(color: primaryGreen, width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: top && left ? const Radius.circular(12) : Radius.zero,
          topRight: top && !left ? const Radius.circular(12) : Radius.zero,
          bottomLeft: !top && left ? const Radius.circular(12) : Radius.zero,
          bottomRight: !top && !left ? const Radius.circular(12) : Radius.zero,
        ),
      ),
    );
  }

  Widget _buildAIStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: primaryGreen.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'AI SCANNING...',
            style: TextStyle(
              color: primaryGreen,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circleBtn(Icons.image_outlined),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryGreen, width: 2),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: primaryGreen,
              child: const Icon(
                Icons.photo_camera,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
          _circleBtn(Icons.help_outline),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildHistoryPanel() {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 40),
      decoration: const BoxDecoration(
        color: Color(0xFF152A15),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _historyItem(
            'Leaf Rust',
            'Resolved • Oct 24',
            'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=100',
            true,
          ),
          _historyItem(
            'Spider Mites',
            'ACTION REQUIRED',
            'https://images.unsplash.com/photo-1628352081506-83c43123ed6d?auto=format&fit=crop&w=100&q=80',
            false,
          ),
        ],
      ),
    );
  }

  Widget _historyItem(
    String title,
    String subtitle,
    String imgUrl,
    bool resolved,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imgUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: resolved ? const Color(0xFF9CBA9C) : Colors.amber,
                    fontSize: 12,
                    fontWeight: resolved ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: resolved ? primaryGreen : Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
