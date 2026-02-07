import 'package:flutter/material.dart';

class AdvisorScreen extends StatelessWidget {
  const AdvisorScreen({super.key});

  final Color primaryGreen = const Color(0xFF0DF20D);
  final Color darkBg = const Color(0xFF102210);
  final Color cardBg = const Color(0xFF1B271B);
  final Color textSecondary = const Color(0xFF9CBA9C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [
          Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    _buildSectionHeader('AI Feed Stream'),
                    _buildAIMessage(),
                    _buildSectionHeader('Critical Insights'),
                    _buildInsightCard(
                      title: 'Planting Window',
                      subtitle: 'Oct 12 - Oct 18 is optimal.',
                      imgUrl:
                          'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?auto=format&fit=crop&q=80&w=600',
                      badgeIcon: Icons.calendar_today,
                      badgeText: 'Seasonal Insight',
                      buttonText: 'Apply Schedule',
                      isPrimaryButton: true,
                      metrics: [
                        {'icon': Icons.thermostat, 'text': 'Soil temp: 18°C'},
                        {'icon': Icons.water_drop, 'text': 'Moisture: 65%'},
                        {
                          'icon': Icons.priority_high,
                          'text': 'Priority: Sector B4 (Corn)',
                        },
                      ],
                    ),
                    _buildInsightCard(
                      title: 'Irrigation Strategy',
                      subtitle: 'Increase flow by 15% in North Field.',
                      imgUrl:
                          'https://images.unsplash.com/photo-1563514227147-6d2ff665a6a0?auto=format&fit=crop&q=80&w=600',
                      badgeIcon: Icons.water_drop,
                      badgeText: 'Hydration Alert',
                      buttonText: 'View Detailed Map',
                      isPrimaryButton: false,
                      metrics: [
                        {
                          'icon': Icons.sensors,
                          'text': 'Evapotranspiration spike detected',
                        },
                        {
                          'icon': Icons.schedule,
                          'text': 'Automation: Starts 04:00 AM',
                        },
                        {
                          'icon': Icons.straighten,
                          'text': 'Target: 2.5mm depth',
                        },
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: primaryGreen.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.auto_awesome, color: primaryGreen, size: 28),
            const Expanded(
              child: Text(
                'Strategic Advisor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAIMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: primaryGreen.withOpacity(0.3)),
            ),
            child: Icon(Icons.smart_toy, color: primaryGreen, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AgriSmart AI • 2m ago',
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    border: Border.all(color: primaryGreen.withOpacity(0.1)),
                  ),
                  child: const Text(
                    "I've analyzed your field data and weather forecasts. Here are your strategic recommendations for today:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String subtitle,
    required String imgUrl,
    required IconData badgeIcon,
    required String badgeText,
    required String buttonText,
    required bool isPrimaryButton,
    required List<Map<String, dynamic>> metrics,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Card Image with Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imgUrl,
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
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Row(
                  children: [
                    Icon(badgeIcon, color: primaryGreen, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                ...metrics
                    .map(
                      (m) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Icon(m['icon'], color: textSecondary, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              m['text'],
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPrimaryButton
                          ? primaryGreen
                          : primaryGreen.withOpacity(0.1),
                      foregroundColor: isPrimaryButton ? darkBg : primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: isPrimaryButton
                            ? BorderSide.none
                            : BorderSide(color: primaryGreen.withOpacity(0.3)),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        decoration: BoxDecoration(
          color: darkBg,
          border: Border(top: BorderSide(color: primaryGreen.withOpacity(0.1))),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: primaryGreen.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.mic, color: textSecondary),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ask your advisor...',
                    hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: primaryGreen,
                radius: 18,
                child: Icon(Icons.arrow_upward, color: darkBg, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
