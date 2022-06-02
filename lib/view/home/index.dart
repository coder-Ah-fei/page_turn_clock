import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_turn_clock/components/drawer.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:page_turn_clock/util/shared_preferences_util.dart';
import 'package:page_turn_clock/view/digital_clock/index.dart';
import 'package:page_turn_clock/view/gradual_change_clock/index.dart';
import 'package:page_turn_clock/view/page_turn_clock/index.dart';
import 'package:page_turn_clock/view/sliding_clock/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _clocks = [
    {'title': '数字时钟', 'clock': 'DigitalClock'},
    {'title': '滑块时钟', 'clock': 'SlidingClock'},
    {'title': '翻页时钟', 'clock': 'PageTurnClock'},
    {'title': '渐变时钟', 'clock': 'GradualChangeClock'},
  ];
  final player = AudioPlayer();
  bool _openSound = false;
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  int _second = DateTime.now().second;
  String _dateText = DateFormat('yMMMMEEEEd', "zh_CN").format(DateTime.now());
  Timer? _undateTimer;



  @override
  void initState() {
    super.initState();
    player.setVolume(0.5);
    getDataFromSharedPreferences();
    var updateSecond = const Duration(seconds: 1);
    _undateTimer = Timer.periodic(updateSecond, (timer) async {
      if(_openSound){
        await player.setAsset('sounds/1.mp3');
        player.play();
      }
      setState(() {
        _hour = DateTime.now().hour;
        _minute = DateTime.now().minute;
        _second = DateTime.now().second;
        _dateText = DateFormat('yMMMMEEEEd', "zh_CN").format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _undateTimer?.cancel();
    _undateTimer = null;
    player.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _openSound = Provider.of<TextStyleState>(context).openSound;
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width,
    //         maxHeight: MediaQuery.of(context).size.height),
    //     designSize: Size(406, 879),
    //     context: context,
    //     minTextAdapt: true,
    //     orientation: Orientation.portrait);
    ScreenUtil.init(context,
      designSize: Size(406, 879),
    );


    return  Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      extendBody: true,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: getClock(),
          ),
        ),
      ),
      drawer:  MyDrawer(clocks: _clocks,),
    );
  }

  getClock(){
    String str = _clocks[Provider.of<TextStyleState>(context).clockIndex]['clock'];
    if(str == 'DigitalClock'){
      return DigitalClock(hour: _hour, minute: _minute, second: _second, dateText: _dateText);
    }
    if(str == 'SlidingClock'){
      return SlidingClock(hour: _hour, minute: _minute, second: _second, dateText: _dateText);
    }
    if(str == 'PageTurnClock'){
      return PageTurnClock(hour: _hour, minute: _minute, second: _second, dateText: _dateText);
    }
    if(str == 'GradualChangeClock'){
      return GradualChangeClock(hour: _hour, minute: _minute, second: _second, dateText: _dateText);
    }
    return Container();
  }



  /// 从SharedPreferences读取数据到Provider
  Future<void> getDataFromSharedPreferences() async {
    SharedPreferencesUtil.prefs = await SharedPreferences.getInstance();
    final int? _textColor = SharedPreferencesUtil.prefs?.getInt('_textColor');
    final int? _dateTextColor = SharedPreferencesUtil.prefs?.getInt('_dateTextColor');
    final int? _timeTextColor = SharedPreferencesUtil.prefs?.getInt('_timeTextColor');
    final String? _text = SharedPreferencesUtil.prefs?.getString('_text');
    final bool? _showText = SharedPreferencesUtil.prefs?.getBool('_showText');
    final bool? _showDateText = SharedPreferencesUtil.prefs?.getBool('_showDateText');
    final bool? _openSound = SharedPreferencesUtil.prefs?.getBool('_openSound');
    final int? _clockIndex = SharedPreferencesUtil.prefs?.getInt('_clockIndex');
    Provider.of<TextStyleState>(context, listen: false).setTextColor(_textColor == null ? Colors.white: Color(_textColor));
    Provider.of<TextStyleState>(context, listen: false).setDateTextColor(_dateTextColor == null ? Colors.white: Color(_dateTextColor));
    Provider.of<TextStyleState>(context, listen: false).setTimeTextColor(_timeTextColor == null ? Colors.white: Color(_timeTextColor));
    Provider.of<TextStyleState>(context, listen: false).setText(_text ?? "天行健，君子以自强不息。地势坤，君子以厚德载物。");
    Provider.of<TextStyleState>(context, listen: false).setShowText(_showText ?? false);
    Provider.of<TextStyleState>(context, listen: false).setShowDateText(_showDateText ?? false);
    Provider.of<TextStyleState>(context, listen: false).setOpenSound(_openSound ?? false);
    Provider.of<TextStyleState>(context, listen: false).setClockIndex(_clockIndex ?? 0);
  }
}
