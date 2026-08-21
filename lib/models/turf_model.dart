class TurfModel {
  final String id;
  final String name;
  final String sport; // e.g. Football, Cricket, Basketball, Badminton, Tennis
  final String location;
  final String address;
  final double pricePerHour;
  final double rating;
  final int reviewCount;
  final String surfaceType; // e.g. Synthetic Grass, Hybrid Turf, Hard Court
  final bool hasFloodlights;
  final List<String> amenities;
  final List<String> images;
  final int capacity;
  final String dimensions;
  final List<String> availableSlots;
  final bool isFeatured;
  final String description;

  const TurfModel({
    required this.id,
    required this.name,
    required this.sport,
    required this.location,
    required this.address,
    required this.pricePerHour,
    required this.rating,
    required this.reviewCount,
    required this.surfaceType,
    required this.hasFloodlights,
    required this.amenities,
    required this.images,
    required this.capacity,
    required this.dimensions,
    required this.availableSlots,
    this.isFeatured = false,
    required this.description,
  });

  factory TurfModel.fromJson(Map<String, dynamic> json) {
    return TurfModel(
      id: json['id'] as String,
      name: json['name'] as String,
      sport: json['sport'] as String,
      location: json['location'] as String,
      address: json['address'] as String,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      surfaceType: json['surfaceType'] as String,
      hasFloodlights: json['hasFloodlights'] as bool,
      amenities: List<String>.from(json['amenities'] as List),
      images: List<String>.from(json['images'] as List),
      capacity: json['capacity'] as int,
      dimensions: json['dimensions'] as String,
      availableSlots: List<String>.from(json['availableSlots'] as List),
      isFeatured: json['isFeatured'] as bool? ?? false,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sport': sport,
      'location': location,
      'address': address,
      'pricePerHour': pricePerHour,
      'rating': rating,
      'reviewCount': reviewCount,
      'surfaceType': surfaceType,
      'hasFloodlights': hasFloodlights,
      'amenities': amenities,
      'images': images,
      'capacity': capacity,
      'dimensions': dimensions,
      'availableSlots': availableSlots,
      'isFeatured': isFeatured,
      'description': description,
    };
  }
}
