import 'package:flutter/material.dart';
import '../models/turf_model.dart';
import '../services/shared_pref_service.dart';
import '../utils/constants.dart';

class TurfProvider extends ChangeNotifier {
  final SharedPrefService _prefService = SharedPrefService();

  List<TurfModel> _turfs = [];
  List<String> _favoriteIds = [];
  String _searchQuery = '';
  String _selectedSport = 'All';
  bool _isLoading = true;

  List<TurfModel> get turfs => _turfs;
  List<String> get favoriteIds => _favoriteIds;
  String get searchQuery => _searchQuery;
  String get selectedSport => _selectedSport;
  bool get isLoading => _isLoading;

  List<TurfModel> get featuredTurfs =>
      _turfs.where((t) => t.isFeatured).toList();

  List<TurfModel> get favoriteTurfs =>
      _turfs.where((t) => _favoriteIds.contains(t.id)).toList();

  TurfProvider() {
    _initTurfs();
  }

  Future<void> _initTurfs() async {
    _isLoading = true;
    notifyListeners();

    _turfs = List.from(AppConstants.sampleTurfs);
    _favoriteIds = await _prefService.getFavoriteTurfIds();

    _isLoading = false;
    notifyListeners();
  }

  TurfModel? getTurfById(String id) {
    try {
      return _turfs.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  bool isFavorite(String turfId) {
    return _favoriteIds.contains(turfId);
  }

  Future<void> toggleFavorite(String turfId) async {
    if (_favoriteIds.contains(turfId)) {
      _favoriteIds.remove(turfId);
    } else {
      _favoriteIds.add(turfId);
    }
    notifyListeners();
    await _prefService.saveFavoriteTurfIds(_favoriteIds);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedSport(String sport) {
    _selectedSport = sport;
    notifyListeners();
  }

  List<TurfModel> getFilteredTurfs({
    String? searchQuery,
    bool ignoreSearchQuery = false,
    List<String>? sports,
    RangeValues? priceRange,
    double? minRating,
    String? surfaceType,
    bool? floodlightsOnly,
  }) {
    final effectiveQuery = ignoreSearchQuery ? '' : (searchQuery ?? _searchQuery);

    return _turfs.where((turf) {
      // Comprehensive Multi-field & Multi-token Search check
      if (effectiveQuery.isNotEmpty) {
        final rawQuery = effectiveQuery.toLowerCase().trim();
        final keywords = rawQuery.split(RegExp(r'\s+')).where((k) => k.isNotEmpty).toList();

        final searchableContent = [
          turf.name,
          turf.location,
          turf.address,
          turf.sport,
          turf.surfaceType,
          turf.description,
          ...turf.amenities,
        ].join(' ').toLowerCase();

        final matchesAllKeywords = keywords.every((kw) => searchableContent.contains(kw));
        if (!matchesAllKeywords) return false;
      }

      // Filter screen sports check takes precedence if provided
      if (sports != null && sports.isNotEmpty && !sports.contains('All')) {
        if (!sports.contains(turf.sport)) return false;
      } else if (effectiveQuery.isEmpty) {
        // Home sport chip check: When 'All' is selected, show representative venues
        if (_selectedSport == 'All') {
          if (turf.id == 'turf_1' || turf.id == 'turf_2' || turf.id == 'turf_3' || turf.id == 'turf_4' || turf.id == 'turf_5' || turf.id == 'turf_6') return false;
          if (!turf.isFeatured && turf.id != 'turf_fb_1' && turf.id != 'turf_cr_3' && turf.id != 'turf_tn_4' && turf.id != 'turf_bd_5' && turf.id != 'turf_bk_5' && turf.id != 'turf_ch_1') return false;
        } else if (_selectedSport != 'All' && turf.sport != _selectedSport) {
          return false;
        }
      }

      // Price check
      if (priceRange != null) {
        if (turf.pricePerHour < priceRange.start ||
            turf.pricePerHour > priceRange.end) {
          return false;
        }
      }

      // Rating check
      if (minRating != null && minRating > 0) {
        if (turf.rating < minRating) return false;
      }

      // Surface type check
      if (surfaceType != null &&
          surfaceType != 'All Surfaces' &&
          surfaceType.isNotEmpty) {
        if (turf.surfaceType != surfaceType) return false;
      }

      // Floodlights check
      if (floodlightsOnly == true) {
        if (!turf.hasFloodlights) return false;
      }

      return true;
    }).toList();
  }
}
