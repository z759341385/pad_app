

import 'package:flutter/material.dart';
import 'package:flutter_demo_example/utils/global.dart';










class ScanImageView extends StatefulWidget {
  final Widget child;

  const ScanImageView({Key? key, required this.child}) : super(key: key);

  @override
  _ScanImageViewState createState() => _ScanImageViewState();
}

class _ScanImageViewState extends State<ScanImageView>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) => CustomPaint(
          foregroundPainter:
          _ScanPainter(controller.value, Colors.white, Colors.green),
          child: widget.child,
          willChange: true,
        ));
  }
}

class _ScanPainter extends CustomPainter {
  final double value;
  final Color borderColor;
  final Color scanColor;

  _ScanPainter(this.value, this.borderColor, this.scanColor);

  Paint? _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      initPaint();
    }
    double width = size.width;
    double height = size.height;

    double boxWidth = size.width ;
    double boxHeight = height / 2;

    double left = 15;
    double top = MediaQuery.of(Global.navigatorKey.currentContext!).padding.top+30;
    double bottom = boxHeight * 2;
    double right = left + boxWidth;
    _paint!.color = borderColor;
    // final rect = Rect.fromLTWH(left, top, boxWidth, boxHeight);
    // canvas.drawRect(rect, _paint!);

    _paint!.strokeWidth = 3;

    // Path path1 = Path()
    //   ..moveTo(left, top + 10)
    //   ..lineTo(left, top)
    //   ..lineTo(left + 10, top);
    // canvas.drawPath(path1, _paint!);
    // Path path2 = Path()
    //   ..moveTo(left, bottom - 10)
    //   ..lineTo(left, bottom)
    //   ..lineTo(left + 10, bottom);
    // canvas.drawPath(path2, _paint!);
    // Path path3 = Path()
    //   ..moveTo(right, bottom - 10)
    //   ..lineTo(right, bottom)
    //   ..lineTo(right - 10, bottom);
    // canvas.drawPath(path3, _paint!);
    // Path path4 = Path()
    //   ..moveTo(right, top + 10)
    //   ..lineTo(right, top)
    //   ..lineTo(right - 10, top);
    // canvas.drawPath(path4, _paint!);

    _paint!.color = scanColor;

    final scanRect = Rect.fromLTWH(
        left, top + 80 + (value * (boxHeight - 20)), boxWidth - 20, 3);

    _paint!.shader = LinearGradient(colors: <Color>[
      Colors.transparent,
      Colors.green.withOpacity(0.5),
      Colors.green,
      Colors.green,
      Colors.green.withOpacity(0.5),
      Colors.transparent,
    ], stops: [
      0.0,
      0.1,
      0.3,
      0.7,
      0.9,
      1,
    ]).createShader(scanRect);
    canvas.drawRect(scanRect, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void initPaint() {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }
}