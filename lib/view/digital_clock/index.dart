import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:provider/provider.dart';

/// 数字时钟
class DigitalClock extends StatefulWidget {
  final int hour, minute, second;
  final String dateText;

  const DigitalClock({Key? key, required this.hour, required this.minute, required this.second, required this.dateText}) : super(key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {


  /// 手机系统自动横屏，电脑系统这是最小窗口
  Future testWindowFunctions() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // if (!Platform.isIOS && !Platform.isAndroid) {
    //   await DesktopWindow.setMinWindowSize(const Size(400, 400));
    // } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    // }
  }

  @override
  void initState()  {
    super.initState();

    testWindowFunctions();

  }




  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Color _textColor = Provider.of<TextStyleState>(context).textColor;
    Color _dateTextColor = Provider.of<TextStyleState>(context).dateTextColor;
    Color _timeTextColor = Provider.of<TextStyleState>(context).timeTextColor;
    String _text = Provider.of<TextStyleState>(context).text;
    bool _showText = Provider.of<TextStyleState>(context).showText;
    bool _showDateText = Provider.of<TextStyleState>(context).showDateText;




    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _showDateText
              ? Container(
            padding: EdgeInsets.only(left: 50),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.dateText,
              maxLines: 1,
              style:
              TextStyle(fontSize: 0.03.sw, color: _dateTextColor),
            ),
          )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.35.sw,
                child: Stack(
                  children: [
                    AnimatedFlipCounter(
                      value: widget.hour.toDouble(),
                      wholeDigits: 2,
                      textStyle: TextStyle(
                          fontSize: .25.sw, color: _timeTextColor),
                    ),
                    Positioned(
                      top: -.02.sw,
                      left: .295.sw,
                      child: Text(
                        ":",
                        style: TextStyle(
                            color: _timeTextColor, fontSize: .25.sw),
                      ),
                    )
                  ],
                  alignment: Alignment.centerLeft,
                ),
              ),
              AnimatedFlipCounter(
                value: widget.minute.toDouble(),
                wholeDigits: 2,
                textStyle:
                TextStyle(fontSize: .25.sw, color: _timeTextColor),
              ),
              AnimatedFlipCounter(
                value: widget.second.toDouble(),
                wholeDigits: 2,
                textStyle:
                TextStyle(fontSize: .05.sw, color: _timeTextColor),
              ),
            ],
          ),
          // Expanded(child: Container()),
          _showText
              ? Text(
            _text,
            maxLines: 1,
            style: TextStyle(fontSize: 0.03.sw, color: _textColor),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
