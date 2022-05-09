import 'dart:math';

import 'package:flutter/material.dart';

class PageTurn extends StatefulWidget {
  final int num;
  final double width;

  const PageTurn({Key? key, required this.num, required this.width})
      : super(key: key);

  @override
  _PageTurnState createState() => _PageTurnState();
}

class _PageTurnState extends State<PageTurn>
    with SingleTickerProviderStateMixin {
  int _b = 0;
  int _d = 0;
  int _threshold = 0;
  double _c = 0;
  late CurvedAnimation _curve;
  late AnimationController _controller;

  @override
  void didUpdateWidget(covariant PageTurn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.num != widget.num) {
      _controller.forward();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _b = widget.num;
    _d = widget.num;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      _threshold = (_curve.value * 10).truncate();
      if ((_curve.value * 10).truncate() == 5) {
        setState(() {
          _b = widget.num;
        });
      }
      if ((_curve.value * 10).truncate() == 10) {
        _controller.reset();
        setState(() {
          _d = widget.num;
        });
      }
      setState(() {
        _c = _curve.value;
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.0),
                    color: Colors.black,
                  ),
                  width: widget.width,
                  height: widget.width,
                ),
                Transform.translate(
                  offset: Offset(0, 0),
                  child: ClipRect(
                    clipper: _MyClipper1(widget.width * 0.8),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 68, 68, 68),
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.width * 0.05))),
                      width: widget.width * 0.8,
                      height: widget.width * 0.8,
                      child: Text(
                        widget.num < 10
                            ? ('0' + widget.num.toString())
                            : widget.num.toString(),
                        style: TextStyle(
                            fontSize: widget.width * 0.6, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ClipRect(
                  clipper: _MyClipper2(widget.width * 0.8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 68, 68, 68),
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.width * 0.05))),
                    alignment: Alignment.center,
                    width: widget.width * 0.8,
                    height: widget.width * 0.8,
                    child: Text(
                      _d < 10 ? ('0' + _d.toString()) : _d.toString(),
                      style: TextStyle(
                          fontSize: widget.width * 0.6, color: Colors.white),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(pi * _c),
                  child: ClipRect(
                    clipper: _MyClipper1(widget.width * 0.8),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 68, 68, 68),
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.width * 0.05))),
                      width: widget.width * 0.8,
                      height: widget.width * 0.8,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateX((_threshold ~/ 5) * pi),
                        child: Text(
                          _b < 10 ? ('0' + _b.toString()) : _b.toString(),
                          style: TextStyle(
                              fontSize: widget.width * 0.6,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 截取上半部分内容
class _MyClipper1 extends CustomClipper<Rect> {
  final double widthNum;

  _MyClipper1(this.widthNum);

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(Offset(0, 0), Offset(widthNum, (widthNum / 2) - 2));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

/// 截取下半部分内容
class _MyClipper2 extends CustomClipper<Rect> {
  final double widthNum;

  _MyClipper2(this.widthNum);

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(
        Offset(0, widthNum / 2 + 2), Offset(widthNum, widthNum));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
