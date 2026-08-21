class BookingModel {
  final String id;
  final String turfId;
  final String turfName;
  final String turfLocation;
  final String turfImage;
  final DateTime bookingDate;
  final String timeSlot;
  final int durationHours;
  final int playerCount;
  final String teamName;
  final String contactNumber;
  final double totalAmount;
  final DateTime createdAt;
  final String status; // 'Confirmed', 'Completed', 'Cancelled'

  BookingModel({
    required this.id,
    required this.turfId,
    required this.turfName,
    required this.turfLocation,
    required this.turfImage,
    required this.bookingDate,
    required this.timeSlot,
    required this.durationHours,
    required this.playerCount,
    required this.teamName,
    required this.contactNumber,
    required this.totalAmount,
    required this.createdAt,
    this.status = 'Confirmed',
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      turfId: json['turfId'] as String,
      turfName: json['turfName'] as String,
      turfLocation: json['turfLocation'] as String,
      turfImage: json['turfImage'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      timeSlot: json['timeSlot'] as String,
      durationHours: json['durationHours'] as int,
      playerCount: json['playerCount'] as int,
      teamName: json['teamName'] as String,
      contactNumber: json['contactNumber'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'Confirmed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turfId': turfId,
      'turfName': turfName,
      'turfLocation': turfLocation,
      'turfImage': turfImage,
      'bookingDate': bookingDate.toIso8601String(),
      'timeSlot': timeSlot,
      'durationHours': durationHours,
      'playerCount': playerCount,
      'teamName': teamName,
      'contactNumber': contactNumber,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  bool get isPast {
    final now = DateTime.now();
    return bookingDate.isBefore(DateTime(now.year, now.month, now.day));
  }
}
