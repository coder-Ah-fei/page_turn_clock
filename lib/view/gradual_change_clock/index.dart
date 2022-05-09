import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// 渐变时钟
class GradualChangeClock extends StatefulWidget {
  final int hour, minute, second;
  final String dateText;

  const GradualChangeClock(
      {Key? key,
      required this.hour,
      required this.minute,
      required this.second,
      required this.dateText})
      : super(key: key);

  @override
  _GradualChangeClockState createState() => _GradualChangeClockState();
}

class _GradualChangeClockState extends State<GradualChangeClock>
    with SingleTickerProviderStateMixin {
  double a = 0;
  double i = 0;

  late CurvedAnimation _curve;
  late AnimationController _controller;

  @override
  void didUpdateWidget(covariant GradualChangeClock oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('${widget.second}');
    if (oldWidget.minute != widget.minute) {
      print('${widget.minute}');
      // _controller.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 60,milliseconds: 0), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.addListener(() {});
    setState(() {
      a = widget.second.toDouble();
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    print('_controller.dispose()');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Positioned(
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateZ((1.5 + a / 30) * pi),
                child: Container(
                    // color: Color.fromARGB(255, 120, 82, 251),
                    width: double.infinity,
                    height: double.infinity,
                    child: RotationTransition(
                      turns: _controller,
                      child: Center(
                        child: CustomPaint(
                          painter: MyCustomPainter(),
                        ),
                      ),
                    ))
                // child: Transform(
                //   alignment: Alignment.center,
                //   transform: Matrix4.identity()..rotateZ(pi * i),
                //   child: Center(
                //     child: CustomPaint(
                //       painter: MyCustomPainter(),
                //     ),
                //   ),
                // )),
                )),
        Text(
          "${widget.hour}:${widget.minute}",
          style: TextStyle(
            fontSize: 70.w,
            color: Colors.white,
          ),
        ),
      ]),
    ));
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter(); //屏幕高度

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..moveTo(-1000.0, -1000.0)
          ..lineTo(1000, -1000.0)
          ..lineTo(1000, 1000)
          ..lineTo(-1000.0, 1000)
          ..close(),
        Paint()
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke
          ..style = PaintingStyle.fill
          ..shader = const SweepGradient(colors: [
            Color.fromARGB(255, 238, 116, 225),
            Color.fromARGB(255, 62, 236, 172)
            // Color.fromARGB(255, 120, 82, 251),
            // Color.fromARGB(255, 68, 1, 143)
          ]).createShader(Rect.fromCircle(center: Offset(0, 0), radius: 1000)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
