import 'package:flutter/material.dart';
import 'dart:math';

// Animated Wave Header

class CanvasScreen extends StatefulWidget {
  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  Wave Header
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return ClipPath(
                    clipper: AnimatedWaveClipper(_controller.value),
                    child: Container(
                      height: 180,
                      color: Colors.tealAccent,
                      padding: const EdgeInsets.only(left: 16, top: 40),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 81, 81, 81),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Text('Canvas Screen',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          const SizedBox(height: 16),
                          const Text('Wavy Header',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // MediaQuery Display
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "MediaQuery Size:\n"
                  "Width: ${mediaQuery.size.width.toStringAsFixed(2)} px\n"
                  "Height: ${mediaQuery.size.height.toStringAsFixed(2)} px\n"
                  "Pixel Ratio: ${mediaQuery.devicePixelRatio.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Bar Graph
              const Text("Bar Graph",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                width: 200,
                child: CustomPaint(painter: BarGraphPainter()),
              ),

              const SizedBox(height: 30),

              // Triangle
              const Text("Triangle Shape",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                width: 100,
                child: CustomPaint(painter: TrianglePainter()),
              ),

              const SizedBox(height: 30),

              // Line with Circle
              const Text("Line with Circle",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: 300,
                child: CustomPaint(painter: LineCirclePainter()),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Wave Clipper

class AnimatedWaveClipper extends CustomClipper<Path> {
  final double waveValue;
  AnimatedWaveClipper(this.waveValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    double waveHeight = 20;

    path.lineTo(0, size.height - waveHeight);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(
        i,
        size.height -
            waveHeight * sin((i / size.width * 2 * pi) + (waveValue * 2 * pi)),
      );
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(AnimatedWaveClipper oldClipper) =>
      waveValue != oldClipper.waveValue;
}

// Triangle Painter

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Bar Graph Painter

class BarGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple;
    double barWidth = size.width / 10;
    List<double> heights = [40, 60, 100, 80, 60];

    for (int i = 0; i < heights.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
            i * barWidth * 2, size.height - heights[i], barWidth, heights[i]),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Line  Circle Painter

class LineCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4;

    final circlePaint = Paint()..color = Colors.red;

    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), linePaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
