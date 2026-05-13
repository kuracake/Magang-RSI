import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  //0. WAJIB KEY
  static const String keyNama = 'nama';
  static const String keyPin = 'pin';
  static const String keyDarkMode = 'dark_mode';
  static const String keyMhs = 'mahasiswa';
  static const String keyLoved = 'loved';
  static const String keyLoved2 = 'loved2';

  //0. WAJIB NOTIFIER
  static ValueNotifier<int> notifier = ValueNotifier<int>(0);

  // 1. SIMPAN (CREATE)
  static Future<void> simpanShared({
    required String nama,
    required String pin,
    required bool darkMode,
    required String mahasiswa,
    required bool loved,
    required bool loved2
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyNama, nama);
    await prefs.setString(keyPin, pin);
    await prefs.setBool(keyDarkMode, darkMode);
    await prefs.setString(keyMhs, mahasiswa);
    await prefs.setBool(keyLoved, loved);
    await prefs.setBool(keyLoved2, loved2);

    notifier.value++; // trigger update
  }

  // 2. LOAD (READ)
  static Future<Map<String, dynamic>> loadShared() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'nama': prefs.getString(keyNama) ?? '',
      'pin': prefs.getString(keyPin) ?? '',
      'darkMode': prefs.getBool(keyDarkMode) ?? false,
      'mahasiswa': prefs.getString(keyMhs) ?? '',
      'loved': prefs.getBool(keyLoved) ?? false,
      'loved2': prefs.getBool(keyLoved2) ?? false,
    };
  }

  // 3. APAKAH ADA DATA (READ)
  static Future<bool> adaSharedKah() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(keyNama);
  }

  // 4. HAPUS DATA (SESSIONNYA) (DELETE)
  static Future<void> hapusShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifier.value++;
  }

}