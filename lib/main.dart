import 'package:flutter/material.dart';
import 'package:agris/login_screen.dart';
import 'package:google_fonts/google_fonts.dart'; // Required for the Inter look

void main() {
  runApp(const AgrisApp());
}

class AgrisApp extends StatelessWidget {
  const AgrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agris', // This changes the name in the App Switcher/Web Tab
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        // Using Google Fonts to match your Tailwind "Inter" font
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const AgrisSplashScreen(),
    );
  }
}

class AgrisSplashScreen extends StatefulWidget {
  const AgrisSplashScreen({super.key});

  @override
  State<AgrisSplashScreen> createState() => _AgrisSplashScreenState();
}

class _AgrisSplashScreenState extends State<AgrisSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Wait 3 seconds, then navigate to LoginScreen
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // Smooth fade transition between screens
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF14A38B);
    const backgroundColor = Color(0xFF0A1A0A);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background Pattern (The dots)
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(primaryColor.withOpacity(0.05)),
            ),
          ),

          // Decorative Blur Orbs
          Positioned(
            left: -150,
            bottom: -150,
            child: _BlurOrb(color: primaryColor.withOpacity(0.05)),
          ),
          Positioned(
            right: -150,
            top: -150,
            child: _BlurOrb(color: primaryColor.withOpacity(0.05)),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 60),

              // Logo Section
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Glow behind text
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.15),
                            blurRadius: 80,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'agris',
                      style: GoogleFonts.inter(
                        fontSize: 84,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        letterSpacing: -5,
                      ),
                    ),
                    // The Leaves (Eco Icons)
                    Positioned(
                      top: 15,
                      right: -5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(0.3)..scale(-1.0, 1.0),
                            child: const Icon(
                              Icons.eco,
                              color: primaryColor,
                              size: 32,
                            ),
                          ),
                          Transform.rotate(
                            angle: -0.1,
                            child: const Icon(
                              Icons.eco,
                              color: primaryColor,
                              size: 44,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Loader/Progress Section
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  children: [
                    RotationTransition(
                      turns: _controller,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor.withOpacity(0.1),
                            width: 3,
                          ),
                        ),
                        child: const CircularProgressIndicator(
                          value: 0.2,
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'INITIALIZING AI CORE',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 160,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.45,
                        child: Container(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double i = 0; i < size.width; i += 24) {
      for (double j = 0; j < size.height; j += 24) {
        canvas.drawCircle(Offset(i, j), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BlurOrb extends StatelessWidget {
  final Color color;
  const _BlurOrb({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

