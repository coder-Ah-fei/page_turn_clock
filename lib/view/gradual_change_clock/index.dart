import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    if (oldWidget.minute != widget.minute) {
      print('${widget.minute}');
      // _controller.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: const Duration(seconds: 60, milliseconds: 0), vsync: this);
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
                    width: double.infinity,
                    height: double.infinity,
                    child: RotationTransition(
                      turns: _controller,
                      child: Center(
                        child: CustomPaint(
                          painter: MyCustomPainter(),
                        ),
                      ),
                    )))),
        Text(
          "${widget.hour < 10 ? '0' : ''}${widget.hour}:${widget.minute < 10 ? '0' : ''}${widget.minute}:${widget.second < 10 ? '0' : ''}${widget.second}",
          style: TextStyle(
            fontSize: (1.sw < 1.sh ? 30.w : 80.h),
            color: Colors.white,
          ),
        ),
        ...getArr(),
      ]),
    ));
  }

  /// 计算每小时的坐标x
  getx(int a) {
    return (1.sw < 1.sh ? 120.w : 250.h) * sin(pi * (a / 6));
  }

  /// 计算每个小时的坐标y
  gety(int a) {
    return (1.sw < 1.sh ? 120.w : 250.h) * cos(pi * (a / 6));
  }

  /// 获取时针数字
  getArr() {
    var arr = [];
    for (int i = 1; i < 13; i++) {
      arr.add(Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..translate(getx(i), -gety(i)),
          child: Text(
            '$i',
            style: TextStyle(fontSize: (1.sw < 1.sh ? 30.w : 60.h), color: Colors.white),
          )));
    }
    return arr;
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter(); //屏幕高度

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..moveTo(-2000.0, -2000.0)
          ..lineTo(2000, -2000.0)
          ..lineTo(2000, 2000)
          ..lineTo(-2000.0, 2000)
          ..close(),
        Paint()
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke
          ..style = PaintingStyle.fill
          ..shader = const SweepGradient(colors: [
            Color.fromARGB(255, 36, 207, 197),
            Color.fromARGB(255, 0, 28, 99)
            // Color.fromARGB(255, 238, 116, 225),
            // Color.fromARGB(255, 62, 236, 172)
            //background: linear-gradient(220.55deg, #24CFC5 0%, #001C63 100%);
            // Color.fromARGB(255, 120, 82, 251),
            // Color.fromARGB(255, 68, 1, 143)
          ]).createShader(Rect.fromCircle(center: Offset(0, 0), radius: 1000)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
