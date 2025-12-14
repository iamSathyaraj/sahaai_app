
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocationLocalDataSource {
//   static const _kPrimaryId = 'primary_location_id';
//   static const _kHistory = 'location_history_json';

//   Future<void> savePrimaryId(String id) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_kPrimaryId, id);
//   }

//   Future<String?> getPrimaryId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_kPrimaryId);
//   }

//   Future<void> saveHistory(List<Map<String, dynamic>> listJson) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_kHistory, jsonEncode(listJson));
//   }

//   Future<List<Map<String, dynamic>>> getHistoryJson() async {
//     final prefs = await SharedPreferences.getInstance();
//     final s = prefs.getString(_kHistory);
//     if (s == null || s.isEmpty) return [];
//     try {
//       final arr = jsonDecode(s) as List;
//       return arr.map((e) => Map<String, dynamic>.from(e)).toList();
//     } catch (_) {
//       return [];
//     }
//   }

//   Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_kPrimaryId);
//     await prefs.remove(_kHistory);
//   }
// }
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocationLocalDataSource {
  static const _kPrimaryId = 'primary_location_id';
  static const _kPrimaryAddress = 'primary_location_address';  
  static const _kHistory = 'location_history_json';

  Future<void> savePrimaryId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrimaryId, id);
  }

  Future<void> savePrimaryLocation(String id, String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrimaryId, id);
    await prefs.setString(_kPrimaryAddress, address);  
  }

  Future<String?> getPrimaryId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPrimaryId);
  }

  Future<String?> getPrimaryLocationAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPrimaryAddress);
  }

  Future<void> saveHistory(List<Map<String, dynamic>> listJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kHistory, jsonEncode(listJson));
  }

  Future<List<Map<String, dynamic>>> getHistoryJson() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_kHistory);
    if (s == null || s.isEmpty) return [];
    try {
      final arr = jsonDecode(s) as List;
      return arr.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kPrimaryId);
    await prefs.remove(_kPrimaryAddress);  
    await prefs.remove(_kHistory);
  }
}
