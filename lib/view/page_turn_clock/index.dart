import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_turn_clock/components/page_turn.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 翻页时钟
class PageTurnClock extends StatefulWidget {
  final int hour, minute, second;
  final String dateText;

  const PageTurnClock(
      {Key? key,
      required this.hour,
      required this.minute,
      required this.second,
      required this.dateText})
      : super(key: key);

  @override
  _PageTurnClockState createState() => _PageTurnClockState();
}

class _PageTurnClockState extends State<PageTurnClock> {
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
  void initState() {
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
          Expanded(child: Container()),
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
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.black,
                width: 90.w,
                height: 90.w,
                child: PageTurn(
                  num: widget.hour,
                  width: 90.w,
                ),
              ),
              Container(
                // color: Colors.black,
                width: 90.w,
                height: 90.w,
                child: PageTurn(
                  num: widget.minute,
                  width: 90.w,
                ),
              ),
              Container(

                // color: Colors.black,
                width: 90.w,
                height: 90.w,
                child: PageTurn(
                  num: widget.second,
                  width: 90.w,
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          _showText
              ? Text(
            _text,
            maxLines: 1,
            style: TextStyle(fontSize: 0.03.sw, color: _textColor),
          )
              : SizedBox(),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
