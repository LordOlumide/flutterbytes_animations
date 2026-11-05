import 'dart:math' as math;

import 'package:flutter/material.dart';

getRandomColor() => Color(
  0xFF000000 + math.Random().nextInt(0x00FFFFFF),
);

class ColorChanger extends StatefulWidget {
  const ColorChanger({Key? key}) : super(key: key);

  @override
  State<ColorChanger> createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  Color _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipPath(
            clipper: const CircleClipper(),
            child: TweenAnimationBuilder(
              tween: ColorTween(
                begin: getRandomColor(),
                end: _color,
              ),
              onEnd: () {
                setState(() {
                  _color = getRandomColor();
                });
              },
              duration: const Duration(seconds: 1),
              builder: (context, Color? color, child) {
                return ColorFiltered(
                  colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                  child: child!,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
