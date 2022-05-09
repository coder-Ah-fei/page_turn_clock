import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_turn_clock/components/sliding_block.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:provider/provider.dart';

/// 滑动时钟
class SlidingClock extends StatefulWidget {
  final int hour, minute, second;
  final String dateText;

  const SlidingClock({Key? key, required this.hour, required this.minute, required this.second, required this.dateText}) : super(key: key);

  @override
  _SlidingClockState createState() => _SlidingClockState();
}

class _SlidingClockState extends State<SlidingClock> {

  Future testWindowFunctions() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // if (!Platform.isIOS && !Platform.isAndroid) {
    //   await DesktopWindow.setMinWindowSize(const Size(400, 400));
    // } else {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      extendBody: true,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlidingBlock(
              value: widget.hour ~/ 10,
              blocks: const ['0', '1', '2'],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
            SizedBox(
              width: 15.w,
            ),
            SlidingBlock(
              value: widget.hour % 10,
              blocks: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
            SizedBox(
              width: 30.w,
            ),
            SlidingBlock(
              value: widget.minute ~/ 10,
              blocks: const [
                '0',
                '1',
                '2',
                '3',
                '4',
                '5',
              ],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
            SizedBox(
              width: 15.w,
            ),
            SlidingBlock(
              value: widget.minute % 10,
              blocks: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
            SizedBox(
              width: 30.w,
            ),
            SlidingBlock(
              value: widget.second ~/ 10,
              blocks: const ['0', '1', '2', '3', '4', '5'],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
            SizedBox(
              width: 15.w,
            ),
            SlidingBlock(
              value: widget.second % 10,
              blocks: const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
              // color: Provider.of<TextStyleState>(context).timeTextColor,
            ),
          ],
        )),
      ),
      // drawer: Drawer(),
    );
  }
}
