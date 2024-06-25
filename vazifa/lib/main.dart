import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClockScreen(),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Clock',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: CustomPaint(
          painter: ClockPainter(_controller),
          size: const Size(300, 300),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final Animation<double> animation;
  ClockPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 49, 27, 146)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;
    final paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
    final paint3 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius + 5, paint);
    canvas.drawCircle(center, radius + 10, paint2);

    final dateTime = DateTime.now();
    final hourHandLength = radius * 0.5;
    final minuteHandLength = radius * 0.7;
    final secondHandLength = radius * 0.9;

    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round;
    final minuteHandPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round;
    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final hourHandX = center.dx +
        hourHandLength *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5 - 90) * pi / 180);
    final hourHandY = center.dy +
        hourHandLength *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5 - 90) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandPaint);

    final minuteHandX = center.dx +
        minuteHandLength * cos((dateTime.minute * 6 - 90) * pi / 180);
    final minuteHandY = center.dy +
        minuteHandLength * sin((dateTime.minute * 6 - 90) * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandPaint);

    final secondHandX = center.dx +
        secondHandLength * cos((dateTime.second * 6 - 90) * pi / 180);
    final secondHandY = center.dy +
        secondHandLength * sin((dateTime.second * 6 - 90) * pi / 180);
    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondHandPaint);
    canvas.drawCircle(center, radius - 130, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
