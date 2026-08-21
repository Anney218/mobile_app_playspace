import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/shared_pref_service.dart';

class BookingProvider extends ChangeNotifier {
  final SharedPrefService _prefService = SharedPrefService();

  List<BookingModel> _bookings = [];
  bool _isLoading = true;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;

  List<BookingModel> get activeBookings =>
      _bookings.where((b) => !b.isPast && b.status == 'Confirmed').toList();

  List<BookingModel> get pastBookings =>
      _bookings.where((b) => b.isPast || b.status == 'Completed' || b.status == 'Cancelled').toList();

  BookingProvider() {
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    _isLoading = true;
    notifyListeners();

    _bookings = await _prefService.getBookings();

    // Sort by booking date descending
    _bookings.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createBooking(BookingModel booking) async {
    try {
      _bookings.insert(0, booking);
      notifyListeners();
      await _prefService.saveBookings(_bookings);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _bookings[index];
      _bookings[index] = BookingModel(
        id: old.id,
        turfId: old.turfId,
        turfName: old.turfName,
        turfLocation: old.turfLocation,
        turfImage: old.turfImage,
        bookingDate: old.bookingDate,
        timeSlot: old.timeSlot,
        durationHours: old.durationHours,
        playerCount: old.playerCount,
        teamName: old.teamName,
        contactNumber: old.contactNumber,
        totalAmount: old.totalAmount,
        createdAt: old.createdAt,
        status: 'Cancelled',
      );
      notifyListeners();
      await _prefService.saveBookings(_bookings);
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    _bookings.removeWhere((b) => b.id == bookingId);
    notifyListeners();
    await _prefService.saveBookings(_bookings);
  }

  Future<void> clearAllPastHistory() async {
    _bookings.removeWhere((b) => b.isPast || b.status == 'Completed' || b.status == 'Cancelled');
    notifyListeners();
    await _prefService.saveBookings(_bookings);
  }
}
