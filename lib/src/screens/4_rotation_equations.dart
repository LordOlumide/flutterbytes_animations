import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_3d_carousel/flutter_3d_carousel.dart';

class RotationInCircle extends StatelessWidget {
  const RotationInCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'x = r.cos(θ), y = r.sin(θ)',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          Expanded(
            child: Expanded(
              child: CarouselWidget3D(
                radius: 100,
                childOrientation: OrientedFacingScreen(),
                roll: LinearInputFunction(gradient: math.pi / 6),
                pitch: ConstantInputFunction(value: math.pi / 2),
                childTapBehavior: ChildTapBehavior.doNothing,
                backgroundTapBehavior: BackgroundTapBehavior.none,
                dragEndBehavior: DragEndBehavior.continueSpinning,
                backgroundBlur: 0,
                children: List.generate(
                  colors.length,
                  (index) => CarouselChild(
                    child: Container(
                      width: 70,
                      height: 70,
                      color: colors[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Color> colors = [
  Colors.lightBlue,
  Colors.greenAccent,
  Colors.indigo,
  Colors.grey,
  Colors.yellow,
  Colors.purple,
];
