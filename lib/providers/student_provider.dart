import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  String _studentName = 'Anney Begum';
  String _studentId = 'USR-2026-88';
  String _phone = '+880 1712-345678';
  String _location = 'Sylhet, Bangladesh';
  String _primarySport = 'Football';
  bool _isStudentDiscountApplied = true;
  int _preferredRadioValue = 1; // 1 = Morning Prime Slot, 2 = Evening Regular

  String get studentName => _studentName;
  String get studentId => _studentId;
  String get phone => _phone;
  String get location => _location;
  String get primarySport => _primarySport;
  String get studentEmail => '${_studentName.toLowerCase().replaceAll(' ', '.')}@gmail.com';
  bool get isStudentDiscountApplied => _isStudentDiscountApplied;
  int get preferredRadioValue => _preferredRadioValue;

  StudentProvider() {
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _studentName = prefs.getString('student_name') ?? 'Anney Begum';
    _studentId = prefs.getString('student_id') ?? 'USR-2026-88';
    _phone = prefs.getString('student_phone') ?? '+880 1712-345678';
    _location = prefs.getString('student_location') ?? 'Sylhet, Bangladesh';
    _primarySport = prefs.getString('student_primary_sport') ?? 'Football';
    _isStudentDiscountApplied = prefs.getBool('student_discount') ?? true;
    _preferredRadioValue = prefs.getInt('preferred_radio_slot') ?? 1;
    print('DEBUG: loadProfile() executed in StudentProvider - Name: $_studentName');
    notifyListeners();
  }

  Future<void> saveProfile(String name, String id, {String? phoneNum, String? userLoc, String? sport}) async {
    final prefs = await SharedPreferences.getInstance();
    _studentName = name;
    _studentId = id;
    if (phoneNum != null) _phone = phoneNum;
    if (userLoc != null) _location = userLoc;
    if (sport != null) _primarySport = sport;

    await prefs.setString('student_name', name);
    await prefs.setString('student_id', id);
    await prefs.setString('student_phone', _phone);
    await prefs.setString('student_location', _location);
    await prefs.setString('student_primary_sport', _primarySport);

    print('DEBUG: saveProfile() executed - Saved User Name: $name, Phone: $_phone');
    notifyListeners();
  }

  void toggleStudentDiscount(bool value) async {
    _isStudentDiscountApplied = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('student_discount', value);
  }

  void setPreferredRadioValue(int? value) async {
    if (value != null) {
      _preferredRadioValue = value;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('preferred_radio_slot', value);
    }
  }
}
