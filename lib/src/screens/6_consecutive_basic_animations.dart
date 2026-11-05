import 'dart:math' as math;

import 'package:flutter/material.dart';

class ConsecutiveAnimationsScreen extends StatefulWidget {
  const ConsecutiveAnimationsScreen({super.key});

  @override
  State<ConsecutiveAnimationsScreen> createState() =>
      _ConsecutiveAnimationsScreenState();
}

class _ConsecutiveAnimationsScreenState
    extends State<ConsecutiveAnimationsScreen>
    with TickerProviderStateMixin {
  List<String> titles = [
    'Position',
    'Rotation',
    'Size',
    'Border Radius',
    'Color',
    'Opacity',
    'And More...',
  ];
  final List<AnimationController> controllers = [];

  late final Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < titles.length; i++) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        ),
      );
    }
    colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.green,
    ).animate(controllers[4]);
  }

  @override
  void dispose() {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }

  void nextStep() {
    if (selectedIndex <= 6) {
      setState(() {
        selectedTitle = titles[selectedIndex];
      });
      controllers[selectedIndex].forward();

      selectedIndex++;
    }
  }

  void previousStep() {
    if (selectedIndex > 0) {
      selectedIndex--;

      setState(() {
        selectedTitle = titles[selectedIndex];
      });
      controllers[selectedIndex].reverse();
    }
  }

  int selectedIndex = 0;

  String selectedTitle = 'Properties:';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controllers[6],
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  0.0,
                  -0.8 * (1 - controllers[6].value).abs(),
                ),
                child: child,
              );
            },
            child: Text(
              selectedTitle,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge(controllers),
            builder: (context, child) {
              final double size =
                  (controllers[2].value + 4) * (screenHeight / 20);

              return Align(
                alignment: Alignment(
                  controllers[0].value - 1,
                  (controllers[0].value / 2) - 0.6,
                ),
                child: Transform.rotate(
                  angle: controllers[1].value * math.pi,
                  child: Opacity(
                    opacity: (1 - controllers[5].value).abs(),
                    child: Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: colorAnimation.value,
                        border: Border.all(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(
                          (controllers[3].value) * (screenHeight / 9),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 60,
            child: AnimatedBuilder(
              animation: controllers[6],
              builder: (context, child) {
                return Opacity(
                  opacity: (1 - controllers[6].value).abs(),
                  child: child,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        previousStep();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        nextStep();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: 50,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
