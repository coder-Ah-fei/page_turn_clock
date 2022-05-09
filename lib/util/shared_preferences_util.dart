
import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesUtil{

  static SharedPreferences? prefs;


  Future<void> aaa() async {
    final prefs = await SharedPreferences.getInstance();
    final int? _textColor = prefs.getInt('_textColor');
    final int? _dateTextColor = prefs.getInt('_dateTextColor');
    final int? _timeTextColor = prefs.getInt('_timeTextColor');
    final String? _text = prefs.getString('_text');
    final bool? _showText = prefs.getBool('_showText');
    final bool? _showDateText = prefs.getBool('_showDateText');
  }


}