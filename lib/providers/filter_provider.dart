import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List<String> _selectedSports = ['All'];
  RangeValues _priceRange = const RangeValues(200, 3500);
  double _minRating = 0.0;
  String _surfaceType = 'All Surfaces';
  bool _floodlightsOnly = false;

  List<String> get selectedSports => _selectedSports;
  RangeValues get priceRange => _priceRange;
  double get minRating => _minRating;
  String get surfaceType => _surfaceType;
  bool get floodlightsOnly => _floodlightsOnly;

  bool get isFilterActive =>
      !_selectedSports.contains('All') ||
      _priceRange.start > 200 ||
      _priceRange.end < 3500 ||
      _minRating > 0.0 ||
      _surfaceType != 'All Surfaces' ||
      _floodlightsOnly;

  void toggleSport(String sport) {
    if (sport == 'All') {
      _selectedSports = ['All'];
    } else {
      _selectedSports.remove('All');
      if (_selectedSports.contains(sport)) {
        _selectedSports.remove(sport);
        if (_selectedSports.isEmpty) {
          _selectedSports = ['All'];
        }
      } else {
        _selectedSports.add(sport);
      }
    }
    notifyListeners();
  }

  void setPriceRange(RangeValues range) {
    _priceRange = range;
    notifyListeners();
  }

  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  void setSurfaceType(String surface) {
    _surfaceType = surface;
    notifyListeners();
  }

  void setFloodlightsOnly(bool val) {
    _floodlightsOnly = val;
    notifyListeners();
  }

  void resetFilters() {
    _selectedSports = ['All'];
    _priceRange = const RangeValues(200, 3500);
    _minRating = 0.0;
    _surfaceType = 'All Surfaces';
    _floodlightsOnly = false;
    notifyListeners();
  }
}
