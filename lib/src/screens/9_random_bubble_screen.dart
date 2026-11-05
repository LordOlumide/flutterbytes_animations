import 'dart:math';

import 'package:flutter/material.dart';

class RandomBubblesScreen extends StatefulWidget {
  final int count;
  final double minRadius;
  final double maxRadius;
  final double minSpeed;
  final double maxSpeed;

  const RandomBubblesScreen({
    super.key,
    this.count = 40,
    this.minRadius = 15.0,
    this.maxRadius = 50.0,
    this.minSpeed = 0.5,
    this.maxSpeed = 2.5,
  });

  @override
  State<RandomBubblesScreen> createState() => _RandomBubblesScreenState();
}

class _RandomBubblesScreenState extends State<RandomBubblesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();
  Size _screenSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateBubbles);

    _controller.repeat();
  }

  void _initBubbles(Size size) {
    _screenSize = size;
    _bubbles.clear();

    for (int i = 0; i < widget.count; i++) {
      final radius =
          widget.minRadius +
          _random.nextDouble() * (widget.maxRadius - widget.minRadius);

      final position = Offset(
        radius + _random.nextDouble() * (size.width - 2 * radius),
        radius + _random.nextDouble() * (size.height - 2 * radius),
      );

      final speed =
          widget.minSpeed +
          _random.nextDouble() * (widget.maxSpeed - widget.minSpeed);
      final angle = _random.nextDouble() * 2 * pi;

      final velocity = Offset(cos(angle) * speed, sin(angle) * speed);

      _bubbles.add(
        Bubble(position: position, radius: radius, velocity: velocity),
      );
    }
  }

  void _updateBubbles() {
    if (_screenSize == Size.zero) return;
    setState(() {
      for (final bubble in _bubbles) {
        bubble.update(_screenSize);
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
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          if (_screenSize != size && size.width > 0 && size.height > 0) {
            _initBubbles(size);
          }

          return CustomPaint(
            painter: BubblePainter(bubbles: _bubbles),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final bubble in bubbles) {
      final paint = Paint()
        ..shader =
            RadialGradient(
              colors: [
                Colors.purpleAccent.withAlpha(20),
                Colors.purple.withAlpha(50),
                Colors.deepPurple.withAlpha(100),
              ],
              stops: const [0.0, 0.7, 1.0],
            ).createShader(
              Rect.fromCircle(center: bubble.position, radius: bubble.radius),
            )
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = Colors.white.withAlpha(70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(bubble.position, bubble.radius, paint);
      canvas.drawCircle(bubble.position, bubble.radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Offset position;
  double radius;
  Offset velocity;

  Bubble({
    required this.position,
    required this.radius,
    required this.velocity,
  });

  void update(Size bounds) {
    position += velocity;

    if (position.dx - radius < 0) {
      position = Offset(radius, position.dy);
      velocity = Offset(-velocity.dx, velocity.dy);
    } else if (position.dx + radius > bounds.width) {
      position = Offset(bounds.width - radius, position.dy);
      velocity = Offset(-velocity.dx, velocity.dy);
    }

    if (position.dy - radius < 0) {
      position = Offset(position.dx, radius);
      velocity = Offset(velocity.dx, -velocity.dy);
    } else if (position.dy + radius > bounds.height) {
      position = Offset(position.dx, bounds.height - radius);
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}
