import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking_model.dart';

class SharedPrefService {
  static const String _keyThemeMode = 'is_dark_mode';
  static const String _keyFavorites = 'favorite_turf_ids';
  static const String _keyBookings = 'user_bookings_json';

  // Theme Mode
  Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeMode, isDark);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyThemeMode) ?? false;
  }

  // Favorite Turfs
  Future<void> saveFavoriteTurfIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyFavorites, ids);
  }

  Future<List<String>> getFavoriteTurfIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyFavorites) ?? [];
  }

  // Booking History
  Future<void> saveBookings(List<BookingModel> bookings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = bookings.map((b) => jsonEncode(b.toJson())).toList();
    await prefs.setStringList(_keyBookings, jsonList);
  }

  Future<List<BookingModel>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyBookings) ?? [];
    return jsonList.map((str) {
      final map = jsonDecode(str) as Map<String, dynamic>;
      return BookingModel.fromJson(map);
    }).toList();
  }
}
