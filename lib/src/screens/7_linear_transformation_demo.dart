import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class LinearTransformationDemoScreen extends StatefulWidget {
  const LinearTransformationDemoScreen({super.key});

  @override
  State<LinearTransformationDemoScreen> createState() =>
      _LinearTransformationDemoScreenState();
}

class _LinearTransformationDemoScreenState
    extends State<LinearTransformationDemoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10.0,
                ),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    vector_math.Matrix3 scaleTransformation =
                        vector_math.Matrix3(
                          _scaleAnimation.value,
                          0,
                          0,
                          0,
                          _scaleAnimation.value,
                          0,
                          0,
                          0,
                          _scaleAnimation.value,
                        );

                    vector_math.Matrix3 rotationTransformation =
                        vector_math.Matrix3(
                          math.cos(_rotationAnimation.value),
                          math.sin(_rotationAnimation.value),
                          0,
                          -math.sin(_rotationAnimation.value),
                          math.cos(_rotationAnimation.value),
                          0,
                          0,
                          0,
                          1,
                        );

                    vector_math.Matrix3 combinedTransformation =
                        vector_math.Matrix3(
                          _scaleAnimation.value *
                              math.cos(_rotationAnimation.value),
                          _scaleAnimation.value *
                              math.sin(_rotationAnimation.value),
                          0,
                          -_scaleAnimation.value *
                              math.sin(_rotationAnimation.value),
                          _scaleAnimation.value *
                              math.cos(_rotationAnimation.value),
                          0,
                          0,
                          0,
                          _scaleAnimation.value,
                        );

                    return Column(
                      children: [
                        Text(
                          'Using Linear Transformations',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.fredoka(
                            fontSize: 30,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 70),
                        Transform(
                          transform: getMatrix4(scaleTransformation),
                          alignment: Alignment.center,
                          child: DemoContainer(text: 'Scale'),
                        ),
                        const SizedBox(height: 100),
                        Transform(
                          transform: getMatrix4(rotationTransformation),
                          alignment: Alignment.center,
                          child: DemoContainer(text: 'Rotation'),
                        ),
                        const SizedBox(height: 100),
                        Transform(
                          transform: getMatrix4(combinedTransformation),
                          alignment: Alignment.center,
                          child: DemoContainer(text: 'Combined'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

vector_math.Matrix4 getMatrix4(vector_math.Matrix3 matrix3) {
  const perspectiveStrength = 0.001;

  return Matrix4(
    matrix3.entry(0, 0),
    matrix3.entry(1, 0),
    matrix3.entry(2, 0),
    perspectiveStrength * matrix3.entry(2, 0),
    matrix3.entry(0, 1),
    matrix3.entry(1, 1),
    matrix3.entry(2, 1),
    perspectiveStrength * matrix3.entry(2, 1),
    matrix3.entry(0, 2),
    matrix3.entry(1, 2),
    matrix3.entry(2, 2),
    perspectiveStrength * matrix3.entry(2, 2),
    0,
    0,
    0,
    1,
  );
}

class DemoContainer extends StatelessWidget {
  final String text;

  const DemoContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.fredoka(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
