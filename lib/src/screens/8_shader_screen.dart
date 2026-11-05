import 'package:flutter/material.dart';
import 'package:flutter_shaders_ui/flutter_shaders_ui.dart';

class ShaderScreen extends StatelessWidget {
  const ShaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fragment shaders')),
      body: PageView(
        children: [
          WaveBackground(
            color1: const Color(0xFF1685FF),
            color2: const Color(0xFFCA4FED),
            speed: 4.0,
            amplitude: 1.0,
            child: const Center(
              child: Text(
                'Wave Background',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          AuroraEffect(
            color1: const Color(0xFFCFE637),
            color2: const Color(0xFFFF1FB0),
            speed: 4.0,
            child: const Center(
              child: Text(
                'Aurora Effect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FireEffect(
            speed: 5.0,
            intensity: 1.0,
            color1: const Color(0xFFFFEB3B),
            color2: const Color(0xFFFF5722),
            child: const Center(
              child: Text(
                'Fire Effect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          WaterEffect(
            child: const Center(
              child: Text(
                'Water Effect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
