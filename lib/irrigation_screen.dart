import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IrrigationScreen extends StatefulWidget {
  const IrrigationScreen({super.key});

  @override
  State<IrrigationScreen> createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  bool _isManualOverride = false;
  final Color primaryGreen = const Color(0xFF0DF20D);
  final Color darkBg = const Color(0xFF102210);
  final Color cardBg = const Color(0xFF1B271B);
  final Color borderGreen = const Color(0xFF3B543B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          // Sticky Top App Bar
          SliverAppBar(
            backgroundColor: darkBg.withOpacity(0.8),
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              children: [
                Text(
                  'Irrigation Control',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'North Field - Zone A',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      size: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              _buildAIRecommendationCard(),
              _buildManualOverridePanel(),
              _buildAnalyticsSection(),
              _buildQuickStatsGrid(),
              const SizedBox(height: 120), // Bottom nav space
            ]),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAIRecommendationCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image Header with Gradient
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1563514227147-6d2ff665a6a0?q=80&w=600',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, cardBg],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE OPTIMIZATION',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SMART INSIGHT',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Text(
                    'AI Recommendation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: const Color(0xFF9CBA9C),
                        fontSize: 14,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'AI predicts '),
                        TextSpan(
                          text: '85% soil saturation efficiency',
                          style: TextStyle(
                            color: primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' if irrigation starts at '),
                        const TextSpan(
                          text: '04:00 PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' today to leverage lower evaporation rates.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.schedule_send),
                    label: const Text('Apply Recommended Schedule'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualOverridePanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: darkBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderGreen),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.settings_input_component, color: primaryGreen),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manual Override',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Take control of all zones',
                    style: TextStyle(
                      color: const Color(0xFF9CBA9C),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _isManualOverride,
              onChanged: (val) => setState(() => _isManualOverride = val),
              activeColor: primaryGreen,
              activeTrackColor: primaryGreen.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.show_chart, color: primaryGreen),
              const SizedBox(width: 8),
              const Text(
                'Moisture vs. Forecast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: darkBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderGreen),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Saturation',
                          style: TextStyle(
                            color: const Color(0xFF9CBA9C),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '62%',
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Next 24 Hours',
                          style: TextStyle(
                            color: const Color(0xFF9CBA9C),
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: primaryGreen,
                              size: 16,
                            ),
                            Text(
                              ' +5% Expected',
                              style: TextStyle(
                                color: primaryGreen,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Chart Widget
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(painter: ChartPainter(primaryGreen)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['12PM', '4PM', '8PM', '12AM', '4AM', '8AM']
                      .map(
                        (t) => Text(
                          t,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildStatCard(Icons.water_drop, 'Flow Rate', '12.5', 'L/min'),
          const SizedBox(width: 16),
          _buildStatCard(Icons.savings, 'Water Saved', '1.2k', 'Gal'),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String val, String unit) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryGreen, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF9CBA9C),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: val,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: cardBg.withOpacity(0.9),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.dashboard, 'Overview', false),
              _navItem(Icons.opacity, 'Irrigation', true),
              const SizedBox(width: 50), // Center gap
              _navItem(Icons.analytics, 'Analytics', false),
              _navItem(Icons.settings, 'Settings', false),
            ],
          ),
          Positioned(
            top: -25,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryGreen,
              elevation: 10,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? primaryGreen : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: active ? primaryGreen : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for the Graph
class ChartPainter extends CustomPainter {
  final Color primary;
  ChartPainter(this.primary);

  @override
  void paint(Canvas canvas, Size size) {
    final moisturePaint = Paint()
      ..color = primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primary.withOpacity(0.3), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final rainPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final moisturePath = Path();
    moisturePath.moveTo(0, size.height * 0.7);
    moisturePath.cubicTo(
      size.width * 0.2,
      size.height * 0.5,
      size.width * 0.4,
      size.height * 0.8,
      size.width * 0.6,
      size.height * 0.6,
    );
    moisturePath.cubicTo(
      size.width * 0.8,
      size.height * 0.4,
      size.width * 0.9,
      size.height * 0.7,
      size.width,
      size.height * 0.6,
    );

    final areaPath = Path.from(moisturePath);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(moisturePath, moisturePaint);

    // Draw Rain Dashed Line
    final rainPath = Path();
    rainPath.moveTo(0, size.height * 0.9);
    rainPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.9,
      size.width * 0.7,
      size.height * 0.2,
    );
    rainPath.lineTo(size.width, size.height * 0.1);

    // Manual dashing for simplicity
    for (double i = 0; i < 1.0; i += 0.05) {
      canvas.drawPath(extractPathPart(rainPath, i, i + 0.02), rainPaint);
    }
  }

  Path extractPathPart(Path path, double start, double end) {
    final metrics = path.computeMetrics().first;
    return metrics.extractPath(metrics.length * start, metrics.length * end);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
