import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // For BackdropFilter

class LandMapScreen extends StatelessWidget {
  const LandMapScreen({super.key});

  final Color primaryGreen = const Color(0xFF0DF20D);
  final Color darkBg = const Color(0xFF102210);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [
          // 1. Map Layer (Satellite Simulation)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&q=80&w=1200',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Polygon Overlay Layer
          Positioned.fill(child: CustomPaint(painter: MapPolygonPainter())),

          // 3. Top App Bar (Glassmorphism)
          _buildTopAppBar(context),

          // 4. Search Bar Overlay
          Positioned(top: 120, left: 16, right: 16, child: _buildSearchBar()),

          // 5. Right Side Floating Controls
          _buildFloatingMapControls(),

          // 6. Bottom Sheet (Details)
          _buildDraggableDetailSheet(),

          // 7. Polyling FAB
          Positioned(
            bottom: 440, // Positioned relative to the sheet height
            right: 16,
            child: FloatingActionButton(
              backgroundColor: primaryGreen,
              foregroundColor: darkBg,
              shape: const CircleBorder(),
              onPressed: () {},
              child: const Icon(Icons.polyline, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 15,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: darkBg.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Land Segmentation',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'PATTERN ANALYTICS',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.layers, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF102210).withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: primaryGreen),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search fields or coordinates',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(Icons.mic, color: Colors.white60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingMapControls() {
    return Positioned(
      right: 16,
      top: 220,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkBg.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {},
                ),
                Divider(height: 1, color: Colors.white.withOpacity(0.1)),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: darkBg.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: IconButton(
              icon: Icon(Icons.my_location, color: primaryGreen),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableDetailSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.48,
      minChildSize: 0.48,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: darkBg.withOpacity(0.85),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 20),
                      width: 48,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  _buildHeaderInfo(),
                  const SizedBox(height: 24),
                  _buildNPKSection(),
                  const SizedBox(height: 24),
                  _buildMoistureTempRow(),
                  const SizedBox(height: 24),
                  _buildRecommendedCrops(),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.timeline),
                    label: const Text('Generate Full Analysis Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: darkBg,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Zone A-4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryGreen.withOpacity(0.3)),
                  ),
                  child: Text(
                    'HIGH YIELD',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              '12.5 Acres • Silt Loam Soil',
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '88%',
              style: TextStyle(
                color: primaryGreen,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'HEALTH SCORE',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNPKSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SOIL FERTILITY (N-P-K)',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Optimal Range',
              style: TextStyle(
                color: primaryGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _bar('Nitrogen (N)', '42 mg/kg', 0.75, primaryGreen),
        _bar('Phosphorus (P)', '28 mg/kg', 0.60, primaryGreen),
        _bar('Potassium (K)', '185 mg/kg', 0.85, Colors.orange),
      ],
    );
  }

  Widget _bar(String label, String value, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.white10,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMoistureTempRow() {
    return Row(
      children: [
        _statBox(Icons.opacity, '24%', 'MOISTURE', Colors.blueAccent),
        const SizedBox(width: 16),
        _statBox(Icons.thermostat, '21°C', 'SOIL TEMP', Colors.orangeAccent),
      ],
    );
  }

  Widget _statBox(IconData icon, String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(
              val,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedCrops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI RECOMMENDED CROPS',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            _cropChip('Corn (Maize)', true),
            _cropChip('Soybeans', false),
            _cropChip('Alfalfa', false),
          ],
        ),
      ],
    );
  }

  Widget _cropChip(String label, bool primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primary ? primaryGreen : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primary ? darkBg : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class MapPolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF0DF20D).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final stroke1 = Paint()
      ..color = const Color(0xFF0DF20D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path1 = Path()
      ..moveTo(50, 250)
      ..lineTo(180, 220)
      ..lineTo(220, 300)
      ..lineTo(190, 420)
      ..lineTo(70, 450)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path1, stroke1);

    // Add more paths for other zones as needed
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
