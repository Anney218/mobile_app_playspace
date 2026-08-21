class AppValidators {
  static String? validateTeamName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Team name is required';
    }
    if (value.trim().length < 2) {
      return 'Team name must be at least 2 characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Contact number is required';
    }
    final cleanPhone = value.trim();
    final phoneRegex = RegExp(r'^\d{11}$');
    if (!phoneRegex.hasMatch(cleanPhone)) {
      return 'Enter a valid 11-digit phone number (e.g., 017XXXXXXXX)';
    }
    return null;
  }

  static String? validatePlayerCount(int? count) {
    if (count == null) {
      return 'Select player count';
    }
    if (count < 2 || count > 22) {
      return 'Player count must be between 2 and 22';
    }
    return null;
  }

  static String? validateDate(DateTime? date) {
    if (date == null) {
      return 'Please select a booking date';
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final bookingDay = DateTime(date.year, date.month, date.day);
    
    if (bookingDay.isBefore(today)) {
      return 'Booking date cannot be in the past';
    }
    return null;
  }
}
