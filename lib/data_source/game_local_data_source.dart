import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class GameDataSource {
  static const String _SOUND_KEY = "sound";
  static const String _VIBRATION_KEY = "vibration";

  static const String _LANGUAGE_KEY = "lang";

  static Future<SharedPreferences> get pref async {
    return await SharedPreferences.getInstance();
  }

  static Future saveSound(
    bool? val,
  ) async {
    try {
      await pref.then((value) => value.setBool(_SOUND_KEY, val!));
    } catch (e) {
      log(e.toString());
    }
  }

  static Future saveVibration(bool? val) async {
    try {
      await pref.then((value) => value.setBool(_VIBRATION_KEY, val!));
    } catch (e) {
      log(e.toString());
    }
  }

  static Future saveLanguage(String? language) async {
    try {
      await pref.then((value) => value.setString(_LANGUAGE_KEY, language!));
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<bool>? getSound() async {
    try {
      final sp = await pref;
      return sp.getBool(_SOUND_KEY) ?? false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool>? getVibration() async {
    try {
      final sp = await pref;
      return sp.getBool(_VIBRATION_KEY)!;
    } catch (e) {
      log(e.toString());
      return true;
    }
  }

  static Future<String>? getLanguage() async {
    try {
      final sp = await pref;
      return sp.getString(_LANGUAGE_KEY)!;
    } catch (e) {
      log(e.toString());
      return "eng";
    }
  }
}
