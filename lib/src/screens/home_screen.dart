import 'package:flutter/material.dart';
import 'package:flutterbytes_animations/src/screens/1_chained_anims.dart';
import 'package:flutterbytes_animations/src/screens/2_color_changer.dart';
import 'package:flutterbytes_animations/src/screens/3_polygon_play.dart';
import 'package:flutterbytes_animations/src/screens/4_rotation_equations.dart';
import 'package:flutterbytes_animations/src/screens/5_animated_prompt.dart';
import 'package:flutterbytes_animations/src/screens/6_consecutive_basic_animations.dart';
import 'package:flutterbytes_animations/src/screens/7_linear_transformation_demo.dart';
import 'package:flutterbytes_animations/src/screens/9_random_bubble_screen.dart';
import 'package:flutterbytes_animations/src/screens/8_shader_screen.dart';
import 'package:flutterbytes_animations/src/widgets/nav_button.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A192F), Color(0xFF0284C7)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Using mathematical equations, trigonometry, and randomness in flutter animations',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 48),
                  NavButton(
                    label: 'Chained Animations',
                    color: const Color(0xFF9FED72),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChainedAnimsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Color Changer',
                    color: const Color(0xFFD552A3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorChanger(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Playing with Polygons',
                    color: const Color(0xFFFF5B42),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PolygonPlay(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Rotation in a circle',
                    color: const Color(0xFFBEDEFF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RotationInCircle(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Animated Prompt',
                    color: const Color(0xFF728E6D),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimatedPromptScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Consecutive Basic Animations',
                    color: const Color(0xFFFFA97B),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConsecutiveAnimationsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Linear Transformations Demo',
                    color: const Color(0xFF6C5CE7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LinearTransformationDemoScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Fragment Shader Demo',
                    color: const Color(0xFF00CEC9),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShaderScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  NavButton(
                    label: 'Random Bubble Animation',
                    color: const Color(0xFFFD79A8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RandomBubblesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
