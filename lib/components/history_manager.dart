import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryManager {
  static const String historyKey = 'qrHistory';

  // Save scan data to SharedPreferences
  static Future<void> saveScanData(String type, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString(historyKey);
    List<Map<String, String>> qrHistory = [];
    if (historyString != null) {
      List<dynamic> historyList = jsonDecode(historyString);
      qrHistory = List<Map<String, String>>.from(
          historyList.map((item) => Map<String, String>.from(item)));
    }
    qrHistory.add({'type': type, 'data': data});
    String newHistoryString = jsonEncode(qrHistory);
    await prefs.setString(historyKey, newHistoryString);
  }

  // Load scan history from SharedPreferences
  static Future<List<Map<String, String>>> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString(historyKey);
    if (historyString != null) {
      List<dynamic> historyList = jsonDecode(historyString);
      return List<Map<String, String>>.from(
          historyList.map((item) => Map<String, String>.from(item)));
    }
    return [];
  }
}
