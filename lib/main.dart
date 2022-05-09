import 'dart:async';
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:page_turn_clock/provider/text_style_state.dart';
import 'package:page_turn_clock/view/gradual_change_clock/index.dart';
import 'package:page_turn_clock/view/home/index.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';



// import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => TextStyleState(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  /// 手机系统自动横屏，电脑系统这是最小窗口
  Future initSetScreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    if (!Platform.isIOS && !Platform.isAndroid) {
      await DesktopWindow.setMinWindowSize(const Size(400, 400));
    } else {
      SystemChrome.setPreferredOrientations(
          []);
    }
  }

  @override
  Widget build(BuildContext context) {
    initSetScreen();
    // 禁止屏幕休眠
    Wakelock.enable();
    return const MaterialApp(
      // home: DigitalClock(),
      home: Home(),
      // home: GradualChangeClock(),
      // home: PageTurnTest(),
      // home: Test3d(),
      // home: SaveFileTest(),
      debugShowCheckedModeBanner: false,
    );
  }
}
