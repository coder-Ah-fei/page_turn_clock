// CountProviderModel.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/shared_preferences_util.dart';


class TextStyleState extends ChangeNotifier {
  int _clockIndex = 0;
  // 文字颜色
  Color _textColor = Colors.white;
  // 日期颜色
  Color _dateTextColor = Colors.white;
  // 时间颜色
  Color _timeTextColor = Colors.white;

  String _text = "天行健，君子以自强不息。地势坤，君子以厚德载物。";

  bool _showText = true;
  bool _showDateText = true;
  bool _openSound = false;


  int get clockIndex => _clockIndex;
  Color get textColor => _textColor;
  Color get dateTextColor => _dateTextColor;
  Color get timeTextColor => _timeTextColor;
  String get text => _text;
  bool get showDateText => _showDateText;
  bool get showText => _showText;
  bool get openSound => _openSound;

  setClockIndex(int value) {
    _clockIndex = value;
    SharedPreferencesUtil.prefs?.setInt('_clockIndex', value);
    notifyListeners();
  }

  setOpenSound(bool value) {
    _openSound = value;
    SharedPreferencesUtil.prefs?.setBool('_openSound', value);
    notifyListeners();
  }

  setText(String value) {
    _text = value;
    SharedPreferencesUtil.prefs?.setString('_text', value);
    notifyListeners();
  }

  setTextColor(Color value) {
    _textColor = value;
    SharedPreferencesUtil.prefs?.setInt('_textColor', value.value);
    notifyListeners();
  }

  setTimeTextColor(Color value) {
    _timeTextColor = value;
    SharedPreferencesUtil.prefs?.setInt('_timeTextColor', value.value);
    notifyListeners();
  }

  setDateTextColor(Color value) {
    _dateTextColor = value;
    SharedPreferencesUtil.prefs?.setInt('_dateTextColor', value.value);
    notifyListeners();
  }

  setShowText(bool value) {
    _showText = value;
    SharedPreferencesUtil.prefs?.setBool('_showText', value);
    notifyListeners();
  }

  setShowDateText(bool value) {
    _showDateText = value;
    SharedPreferencesUtil.prefs?.setBool('_showDateText', value);
    notifyListeners();
  }
}