import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

void savePreferencesBool(String key, bool data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, data);
}

Future<bool> getPreferencesBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool data = prefs.getBool(key) ?? false;
  return data;
}

void savePreferencesInt(String key, int data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, data);
}

Future<int> getPreferencesInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int data = prefs.getInt(key) ?? -1;
  return data;
}