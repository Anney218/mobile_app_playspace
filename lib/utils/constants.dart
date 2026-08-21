import 'package:flutter/material.dart';
import '../models/turf_model.dart';

class AppColors {
  // Primary Palette
  static const Color primaryPurple = Color(0xFF6C5CE7);
  static const Color deepPurple = Color(0xFF4834D4);
  static const Color accentTeal = Color(0xFF00CEC9);
  static const Color brightTeal = Color(0xFF0984E3);
  static const Color goldAccent = Color(0xFFFDCB6E);
  static const Color vibrantGreen = Color(0xFF00B894);
  static const Color warningRed = Color(0xFFFF7675);

  // Light Theme Colors
  static const Color lightBg = Color(0xFFF8F9FE);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF2D3436);
  static const Color lightTextSecondary = Color(0xFF636E72);

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF0F0E17);
  static const Color darkCardBg = Color(0xFF1E1B2E);
  static const Color darkTextPrimary = Color(0xFFFFFFFE);
  static const Color darkTextSecondary = Color(0xFFA7A9BE);

  // Glassmorphism Effects
  static Color glassLight = Colors.white.withOpacity(0.25);
  static Color glassDark = const Color(0xFF1E1B2E).withOpacity(0.65);
  static Color glassBorderLight = Colors.white.withOpacity(0.4);
  static Color glassBorderDark = Colors.white.withOpacity(0.12);
}

class AppConstants {
  static const String appName = "PlaySpace";
  
  static const List<String> sportsCategories = [
    'All',
    'Football',
    'Cricket',
    'Tennis',
    'Badminton',
    'Basketball',
    'Chess',
  ];

  static const List<String> surfaceTypes = [
    'All Surfaces',
    'Synthetic Grass',
    'Hybrid Turf',
    'Natural Grass',
    'Hard Court',
    'Indoor Mat',
    'Wooden Table',
  ];

  static const List<String> allAmenities = [
    'Locker Room',
    'Free Parking',
    'Shower',
    'Cafe Bar',
    'Mineral Water',
    'Gear Rental',
    'High-Speed WiFi',
    'First Aid Kit',
    'Air Conditioned',
  ];

  // Sample Turfs Dataset
  static final List<TurfModel> sampleTurfs = [
    // 1. FOOTBALL (Featured)
    TurfModel(
      id: 'turf_1',
      name: 'Sylhet District Stadium',
      sport: 'Football',
      location: 'Rikabi Bazar, Sylhet',
      address: 'Rikabi Bazar (Lamabazar Road), Sylhet, Bangladesh',
      pricePerHour: 2000.0,
      rating: 4.9,
      reviewCount: 350,
      surfaceType: 'Natural Grass',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Free Parking', 'Shower', 'Cafe Bar', 'Mineral Water', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_stadium.jpg',
        'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 15000,
      dimensions: '145m x 135m (15-acre)',
      availableSlots: [
        '06:00 AM - 07:30 AM',
        '08:00 AM - 09:30 AM',
        '04:00 PM - 05:30 PM',
        '06:00 PM - 07:30 PM',
        '08:00 PM - 09:30 PM',
      ],
      isFeatured: true,
      description: 'The main football venue in the city is the Sylhet District Stadium, located in Rikabi Bazar, Sylhet, with a seating capacity of 15,000 people. Opened in early 1960s on a 15-acre area (145m x 135m), it serves as a primary sports hub hosting FIFA Tier-1 international matches such as Bangladesh versus Mongolia.',
    ),

    // 1.1. FOOTBALL RECOMMENDED MAIN VENUE
    TurfModel(
      id: 'turf_fb_1',
      name: 'Greater Shahi Eidgah Mini Stadium',
      sport: 'Football',
      location: 'Shahi Eidgah, Sylhet',
      address: 'WV4P+XQ7, Boro Bazar Rd, Shahi Eidgah, Sylhet',
      pricePerHour: 1500.0,
      rating: 4.1,
      reviewCount: 30,
      surfaceType: 'Mini Turf / Grass',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Mineral Water', 'Parking', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_shahi_eidgah.jpg',
        'assets/images/sylhet_stadium.jpg',
      ],
      capacity: 14,
      dimensions: '40m x 25m',
      availableSlots: [
        '06:00 AM - 08:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Greater Shahi Eidgah Mini Stadium, Sylhet. Rating: 4.1(30). Located at WV4P+XQ7 Shahi Eidgah. Popular playground for local mini football matches and athletic coaching.',
    ),

    // 2. CRICKET (Featured)
    TurfModel(
      id: 'turf_2',
      name: 'Sylhet Int. Cricket Stadium',
      sport: 'Cricket',
      location: 'Lakkatura Tea Garden, Sylhet',
      address: 'Lakkatura Tea Estate, Sylhet 3100, Bangladesh',
      pricePerHour: 2500.0,
      rating: 4.9,
      reviewCount: 420,
      surfaceType: 'Green Gallery Turf',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Free Parking', 'Gear Rental', 'Cafe Bar', 'First Aid Kit', 'High-Speed WiFi'],
      images: [
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1531415074968-036ba1b575da?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 18000,
      dimensions: 'Standard Oval Pitch',
      availableSlots: [
        '07:00 AM - 08:30 AM',
        '09:00 AM - 10:30 AM',
        '05:00 PM - 06:30 PM',
        '07:00 PM - 08:30 PM',
        '09:00 PM - 10:30 PM',
      ],
      isFeatured: true,
      description: 'The Sylhet International Cricket Stadium is a stunning international venue located inside the Lakkatura Tea Garden in Sylhet. Surrounded by lush green hills and tea plantations, it is famous for being the only cricket stadium in Bangladesh with a natural grass gallery, holding 18,000 spectators and hosting 2014 ICC World T20 & BPL matches.',
    ),

    // 2.1. CRICKET RECOMMENDED MAIN VENUE
    TurfModel(
      id: 'turf_cr_3',
      name: 'MC College Central Playground',
      sport: 'Cricket',
      location: 'Tilagarh, Sylhet',
      address: 'M.C College Playground, 40 Tilagarh - Ambarkhana Road, Sylhet',
      pricePerHour: 1200.0,
      rating: 4.5,
      reviewCount: 389,
      surfaceType: 'Open Grass Field',
      hasFloodlights: false,
      amenities: ['Free Parking', 'Mineral Water', 'Spectator Pavilion'],
      images: [
        'assets/images/sylhet_mc_college_playground.jpg',
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 1000,
      dimensions: 'Massive Open Athletic Field',
      availableSlots: [
        '06:00 AM - 09:00 AM',
        '03:30 PM - 06:00 PM',
      ],
      isFeatured: false,
      description: 'MC College Central Playground. Rating: 4.5(389). Located on historic Murari Chand College Campus, 40 Tilagarh-Ambarkhana Road. Massive open athletic field hosting competitive grassroots cricket initiatives like GNC School Cricket Tournament.',
    ),

    // 3. TENNIS (Featured)
    TurfModel(
      id: 'turf_3',
      name: 'Sylhet Tennis Club',
      sport: 'Tennis',
      location: 'Circuit House Rd, Sylhet',
      address: 'Circuit House Road (VVQC+F3C), Sylhet 3100, Bangladesh',
      pricePerHour: 1500.0,
      rating: 4.8,
      reviewCount: 180,
      surfaceType: 'Hard Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Free Parking', 'Shower', 'Gear Rental', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_tennis.jpg',
        'https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 4,
      dimensions: '23.77m x 10.97m',
      availableSlots: [
        '05:00 PM - 06:00 PM',
        '06:00 PM - 07:00 PM',
        '07:00 PM - 08:00 PM',
        '08:00 PM - 09:00 PM',
        '09:00 PM - 10:00 PM',
      ],
      isFeatured: true,
      description: 'Sylhet Tennis Club is located on Circuit House Road (VVQC+F3C) in Sylhet, near the Circuit House area. Open 5:00 PM – 10:00 PM (Monday – Sunday). Contact: +880 1773-183704. Offerings include professional tennis courts, expert coaching sessions, and local tennis tournaments.',
    ),

    // 3.1. TENNIS RECOMMENDED VENUE 1
    TurfModel(
      id: 'turf_tn_1',
      name: 'Sylhet Club Limited',
      sport: 'Tennis',
      location: 'Borshala, Airport Bypass, Sylhet',
      address: 'Borshala, Airport Bypass Road, Sylhet 3100',
      pricePerHour: 1800.0,
      rating: 4.4,
      reviewCount: 330,
      surfaceType: 'Hard Court',
      hasFloodlights: true,
      amenities: ['Swimming Pool', 'Gym', 'Dining Facilities', 'Locker Room', 'Parking'],
      images: [
        'assets/images/sylhet_club_limited.jpg',
        'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 4,
      dimensions: '23.77m x 8.23m',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet Club Limited. Rating: 4.4(330). Location: Borshala, Airport Bypass, Sylhet. An exclusive recreational club featuring a well-maintained tennis court alongside swimming pools, gym, and fine dining facilities.',
    ),

    // 3.2. TENNIS RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_tn_2',
      name: 'AMA Muhit Lawn Tennis Court',
      sport: 'Tennis',
      location: 'Masimpur Rd, Sylhet',
      address: 'VVMH+GGF, Masimpur Rd, Sylhet',
      pricePerHour: 1400.0,
      rating: 4.4,
      reviewCount: 5,
      surfaceType: 'Lawn Tennis Clay Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Tennis Coaching', 'Gear Rental', 'Mineral Water'],
      images: [
        'assets/images/sylhet_ama_muhit_tennis.jpg',
        'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 4,
      dimensions: 'Standard Tennis Court',
      availableSlots: [
        '06:30 AM - 08:30 AM',
        '04:30 PM - 06:30 PM',
      ],
      isFeatured: false,
      description: 'Abul Maal Abdul Muhit Lawn Tennis Court. Rating: 4.4(5). Location: VVMH+GGF Masimpur Rd, Sylhet. Highly praised as one of the premier venues explicitly dedicated to learning and practicing lawn tennis with expert coaching.',
    ),

    // 3.3. TENNIS RECOMMENDED VENUE 3
    TurfModel(
      id: 'turf_tn_3',
      name: 'Free Kick Indoor Sports',
      sport: 'Tennis',
      location: 'VVWW+Q8F, Sylhet',
      address: 'VVWW+Q8F, Sylhet',
      pricePerHour: 1600.0,
      rating: 4.3,
      reviewCount: 162,
      surfaceType: 'Indoor Artificial Turf',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Air Conditioned', 'Mineral Water', 'Parking'],
      images: [
        'assets/images/sylhet_free_kick.jpg',
        'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 10,
      dimensions: 'Indoor Multi-court',
      availableSlots: [
        '08:00 AM - 10:00 AM',
        '05:00 PM - 07:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'Free Kick. Rating: 4.3(162). Location: VVWW+Q8F Sylhet. An indoor stadium with artificial turf highly popular for tennis ball cricket, tape tennis, and racket sports.',
    ),

    // 3.4. TENNIS RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_tn_4',
      name: 'Sports Heaven Sylhet',
      sport: 'Tennis',
      location: 'Technical Rd, Sylhet',
      address: 'Technical Rd, Sylhet 3100',
      pricePerHour: 1500.0,
      rating: 4.4,
      reviewCount: 281,
      surfaceType: 'Multi-purpose Indoor Ground',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Free Parking', 'Cafe Bar', 'Equipment Rental'],
      images: [
        'assets/images/sylhet_sports_heaven.jpg',
        'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 12,
      dimensions: '3 Expansive Indoor Grounds',
      availableSlots: [
        '09:00 AM - 11:00 AM',
        '04:00 PM - 06:00 PM',
        '08:00 PM - 10:00 PM',
      ],
      isFeatured: false,
      description: 'Sports Heaven, Sylhet. Rating: 4.4(281). Location: Technical Rd, Sylhet. Offers three expansive indoor grounds accommodating racket sports, tennis ball matches, cricket, and football.',
    ),

    // 3.5. TENNIS RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_tn_5',
      name: 'Green Hill Tennis Complex',
      sport: 'Tennis',
      location: 'Zindabazar, Sylhet',
      address: 'Near Khasiya Hills Road, Zindabazar, Sylhet 3100',
      pricePerHour: 1650.0,
      rating: 4.6,
      reviewCount: 95,
      surfaceType: 'Professional Lawn Net Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Pro Shop', 'Mineral Water', 'Spectator Seating'],
      images: [
        'assets/images/sylhet_green_hill_tennis.jpg',
        'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 4,
      dimensions: 'Standard Tennis Net Court',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '03:30 PM - 05:30 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Green Hill Tennis Complex. Rating: 4.6(95). Located near Khasiya Hills Road, Zindabazar, Sylhet. A premier tennis facility featuring professional net courts, evening floodlight playing sessions, and equipment rentals.',
    ),

    // 4. BADMINTON (Featured)
    TurfModel(
      id: 'turf_4',
      name: 'Bhatipara Badminton Court',
      sport: 'Badminton',
      location: 'Kumarpara Rd, Sylhet',
      address: 'Bhatipara House, 35/2 Kumarpara Road, Sylhet 3100',
      pricePerHour: 400.0,
      rating: 4.8,
      reviewCount: 289,
      surfaceType: 'Indoor Mat',
      hasFloodlights: true,
      amenities: ['Air Conditioned', 'Gear Rental', 'Shower', 'High-Speed WiFi', 'Mineral Water'],
      images: [
        'assets/images/sylhet_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 8,
      dimensions: '13.4m x 6.1m',
      availableSlots: [
        '08:00 AM - 09:00 AM',
        '10:00 AM - 11:00 AM',
        '03:00 PM - 04:00 PM',
        '05:00 PM - 06:00 PM',
        '08:00 PM - 09:00 PM',
      ],
      isFeatured: true,
      description: 'Located at 35/2 Kumarpara Road, Bhatipara House, Sylhet 3100 (OpenAd Bangla Media area). It features dedicated indoor badminton courts rented at affordable hourly rates (around 400 BDT per hour) with professional synthetic green mat flooring and gear rental.',
    ),

    // 4.1. BADMINTON RECOMMENDED VENUE 1
    TurfModel(
      id: 'turf_bd_1',
      name: 'Shuttle Sports BD',
      sport: 'Badminton',
      location: 'Sylhet City Area',
      address: 'Sylhet City Area, Bangladesh',
      pricePerHour: 299.0,
      rating: 4.5,
      reviewCount: 140,
      surfaceType: 'Indoor Wooden/Synthetic Court',
      hasFloodlights: true,
      amenities: ['8-Ball Pool', 'Cafe Lounge', 'Locker Room', 'Air Conditioned', 'Free WiFi'],
      images: [
        'assets/images/sylhet_shuttle_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 8,
      dimensions: '13.4m x 6.1m',
      availableSlots: [
        '08:00 AM - 10:00 AM',
        '04:00 PM - 06:00 PM',
        '07:00 PM - 09:00 PM',
        '09:00 PM - 11:00 PM',
      ],
      isFeatured: false,
      description: 'Shuttle Sports BD, Sylhet. Rating: 4.5(140). A trendy hangout destination designed specifically for indoor badminton and 8-ball pool, complete with an attached café lounge. Exceptionally budget-friendly rates starting at BDT 299/hr.',
    ),

    // 4.2. BADMINTON RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_bd_2',
      name: 'Sports Heaven Badminton Arena',
      sport: 'Badminton',
      location: 'Technical Road, Sylhet',
      address: 'Technical Road, Sylhet 3100',
      pricePerHour: 1200.0,
      rating: 4.4,
      reviewCount: 281,
      surfaceType: 'Indoor Synthetic Court',
      hasFloodlights: true,
      amenities: ['Seating Area', 'Food Corner', 'Changing Rooms', 'Locker Room', 'Parking'],
      images: [
        'assets/images/sylhet_sports_heaven_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 12,
      dimensions: '3 Expansive Indoor Grounds',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '05:00 PM - 07:00 PM',
        '08:00 PM - 10:00 PM',
      ],
      isFeatured: false,
      description: 'Sports Heaven, Technical Road, Sylhet. Rating: 4.4(281). A massive multi-sport indoor facility featuring 3 expansive grounds supporting badminton, cricket, and football with on-site seating area, food corner, and dedicated changing rooms.',
    ),

    // 4.3. BADMINTON RECOMMENDED VENUE 3
    TurfModel(
      id: 'turf_bd_3',
      name: 'AMA Muhit Indoor Badminton',
      sport: 'Badminton',
      location: 'Masimpur / Tilagarh, Sylhet',
      address: 'VVMH+GGF, Masimpur Rd / Eco Park Rd, Sylhet',
      pricePerHour: 1000.0,
      rating: 4.6,
      reviewCount: 410,
      surfaceType: 'Professional Wooden Court',
      hasFloodlights: true,
      amenities: ['Swimming Pool', 'Gymnastic Center', 'Locker Room', 'Tournament Seating'],
      images: [
        'assets/images/sylhet_ama_muhit_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 16,
      dimensions: 'Multi-court Badminton Complex',
      availableSlots: [
        '06:00 AM - 08:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Abul Maal Abdul Muhit Sports Complex Indoor Badminton, Sylhet. Rating: 4.6(410). A large-scale public sports complex that houses dedicated indoor badminton courts alongside swimming, gymnastic, and tournament facilities.',
    ),

    // 4.4. BADMINTON RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_bd_4',
      name: 'Sylhet District Sports Complex',
      sport: 'Badminton',
      location: 'Rikabi Bazar, Sylhet',
      address: 'Stadium Road, Rikabi Bazar, Sylhet',
      pricePerHour: 1100.0,
      rating: 4.7,
      reviewCount: 290,
      surfaceType: 'Indoor Wooden Stadium Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Shower', 'High-Speed WiFi', 'Coaching Staff', 'Parking'],
      images: [
        'assets/images/sylhet_district_sports_complex_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 500,
      dimensions: 'Full-sized Indoor Stadium',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '03:00 PM - 05:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet District Sports Complex (Indoor Stadium), Stadium Road, Rikabi Bazar, Sylhet. Rating: 4.7(290). A classic public multi-purpose complex featuring a full-sized indoor stadium explicitly tailored for high-quality badminton and basketball training.',
    ),

    // 4.5. BADMINTON RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_bd_5',
      name: 'Sports\' Garden',
      sport: 'Badminton',
      location: 'South Surma, Sylhet',
      address: 'Sheikh Mokon Miah Complex, South Surma, Sylhet',
      pricePerHour: 1300.0,
      rating: 4.5,
      reviewCount: 175,
      surfaceType: 'Multi-sport Indoor Synthetic Turf',
      hasFloodlights: true,
      amenities: ['Volleyball/Kabaddi Ground', 'Locker Room', 'Free Parking', 'Snack Bar'],
      images: [
        'assets/images/sylhet_sports_garden_badminton.jpg',
        'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 20,
      dimensions: 'Massive Multi-sports Indoor Venue',
      availableSlots: [
        '08:00 AM - 10:00 AM',
        '04:00 PM - 06:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'Sports\' Garden, Sheikh Mokon Miah Complex, South Surma, Sylhet. Rating: 4.5(175). A massive indoor multi-sports venue hosting various events including badminton, football, volleyball, and kabaddi.',
    ),

    // 5. BASKETBALL (Featured)
    TurfModel(
      id: 'turf_5',
      name: 'Sylhet Stadium Basketball Court',
      sport: 'Basketball',
      location: 'Lamabazar Rd, Sylhet',
      address: 'Sylhet District Sports Complex, Lamabazar Road, Sylhet 3100',
      pricePerHour: 1200.0,
      rating: 4.8,
      reviewCount: 215,
      surfaceType: 'Hard Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'High-Speed WiFi', 'Shower', 'Mineral Water', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_basketball.jpg',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 10,
      dimensions: '28m x 15m (FIBA Standard)',
      availableSlots: [
        '07:00 AM - 08:30 AM',
        '09:00 AM - 10:30 AM',
        '04:00 PM - 05:30 PM',
        '06:00 PM - 07:30 PM',
        '07:30 PM - 09:00 PM',
      ],
      isFeatured: true,
      description: 'The Basketball Court at Sylhet Stadium is a dedicated sports facility located on Lamabazar Road, Sylhet. Positioned within the main sports precinct near Rikabi Bazar, it serves as a central hub for local basketball training, tournaments, and coaching sessions daily from 7:00 AM to 9:00 PM.',
    ),

    // 5.1. BASKETBALL RECOMMENDED VENUE 1
    TurfModel(
      id: 'turf_bk_1',
      name: 'Basketball Field SUST',
      sport: 'Basketball',
      location: 'SUST Campus, Sylhet',
      address: 'Shahjalal University of Science and Technology Campus, Kumargaon, Sylhet',
      pricePerHour: 800.0,
      rating: 4.4,
      reviewCount: 41,
      surfaceType: 'Open-air Hard Court',
      hasFloodlights: false,
      amenities: ['Campus Environment', '24/7 Access', 'Free Parking', 'Water Station'],
      images: [
        'assets/images/sylhet_sust_basketball.jpg',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 10,
      dimensions: '28m x 15m',
      availableSlots: [
        '06:00 AM - 08:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Basketball Field SUST, Sylhet. Rating: 4.4(41). Located inside the Shahjalal University of Science and Technology campus, this is a highly popular open-air court. Open 24 hours (Sun-Thu) for pickup games.',
    ),

    // 5.2. BASKETBALL RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_bk_2',
      name: 'M. C. College Basketball Ground',
      sport: 'Basketball',
      location: 'Tilagarh, Sylhet',
      address: 'VWX2+GMH, M.C. College Campus, Tilagarh, Sylhet',
      pricePerHour: 600.0,
      rating: 3.3,
      reviewCount: 3,
      surfaceType: 'Outdoor Campus Hard Court',
      hasFloodlights: false,
      amenities: ['24/7 Access', 'Campus Parking', 'Shaded Seating'],
      images: [
        'assets/images/sylhet_mc_college_basketball.jpg',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 10,
      dimensions: 'Standard Outdoor Court',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '04:00 PM - 06:00 PM',
      ],
      isFeatured: false,
      description: 'M. C. College Basketball Ground. Rating: 3.3(3). Location: VWX2+GMH, Tilagarh, Sylhet. An outdoor campus court located at historic Murari Chand College. Accessible 24/7 for students and local residents.',
    ),

    // 5.3. BASKETBALL RECOMMENDED VENUE 3
    TurfModel(
      id: 'turf_bk_3',
      name: 'Sylhet District Stadium Court',
      sport: 'Basketball',
      location: 'Rikabi Bazar, Sylhet',
      address: 'Stadium Road, Rikabi Bazar, Sylhet',
      pricePerHour: 1200.0,
      rating: 4.3,
      reviewCount: 3400,
      surfaceType: 'Dedicated Indoor Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Shower', 'High-Speed WiFi', 'Coaching Staff', 'Parking'],
      images: [
        'assets/images/sylhet_district_stadium_basketball.jpg',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 20,
      dimensions: '28m x 15m Indoor Court',
      availableSlots: [
        '06:00 AM - 08:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet District Stadium Basketball Court. Rating: 4.3(3.4K). Positioned on Sylhet Stadium Road, Rikabi Bazar. Multi-purpose facility featuring dedicated indoor courts for high-quality basketball and badminton training (6:00 AM - 8:00 PM).',
    ),

    // 5.4. BASKETBALL RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_bk_4',
      name: 'BigSix Indoor Leisure Centre',
      sport: 'Basketball',
      location: 'South Surma, Sylhet',
      address: 'Chondipul, South Surma, Sylhet',
      pricePerHour: 1500.0,
      rating: 3.7,
      reviewCount: 10,
      surfaceType: 'Indoor Multi-sport Synthetic Ground',
      hasFloodlights: true,
      amenities: ['Futsal & Cricket Pitch', 'Locker Room', 'Food Court', 'Free Parking'],
      images: [
        'assets/images/sylhet_big_six_basketball.jpg',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 12,
      dimensions: 'Multi-sport Indoor Centre',
      availableSlots: [
        '09:00 AM - 11:00 AM',
        '03:00 PM - 05:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'BigSix Indoor Leisure Centre. Rating: 3.7(10). Operating out of Chondipul (South Surma), Sylhet. Hosts multiple indoor sports under one roof including basketball, futsal, cricket, and badminton.',
    ),

    // 5.5. BASKETBALL RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_bk_5',
      name: 'Sylhet Basketball Academy',
      sport: 'Basketball',
      location: 'Cadet College Rd, Sylhet',
      address: 'Cadet College Road, Ambarkhana - Airport Rd, Sylhet 3100',
      pricePerHour: 1400.0,
      rating: 4.6,
      reviewCount: 112,
      surfaceType: 'Indoor Wooden Hardwood Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Air Conditioned', 'Scoreboard', 'Equipment Rental', 'Shower'],
      images: [
        'assets/images/sylhet_basketball_academy.png',
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 15,
      dimensions: 'FIBA Standard Hardwood Court',
      availableSlots: [
        '08:00 AM - 10:00 AM',
        '04:00 PM - 06:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet Basketball Academy. Rating: 4.6(112). Located on Cadet College Road, Sylhet. A state-of-the-art indoor basketball facility featuring FIBA standard wooden hardwood flooring, electronic scoreboard, and certified youth & adult training programs.',
    ),

    // 6. CHESS (Featured)
    TurfModel(
      id: 'turf_6',
      name: 'Sylhet Chess Academy',
      sport: 'Chess',
      location: 'Ambarkhana, Sylhet',
      address: 'Boro Bazar R/A Road (near Electric Supply Road), Ambarkhana, Sylhet',
      pricePerHour: 500.0,
      rating: 4.9,
      reviewCount: 290,
      surfaceType: 'Wooden Table',
      hasFloodlights: true,
      amenities: ['Air Conditioned', 'High-Speed WiFi', 'Mineral Water', 'Cafe Bar', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 4,
      dimensions: 'Tournament Chess Board',
      availableSlots: [
        '10:00 AM - 12:00 PM',
        '02:00 PM - 04:00 PM',
        '05:00 PM - 07:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: true,
      description: 'Sylhet Chess Academy (সিলেট দাবা একাডেমী) is located at Boro Bazar R/A Road (near Electric Supply Road / Ambarkhana area), Sylhet. Contact: +880 1715-928628. It offers professional chess coaching, digital clocks, DGT electronic boards, and hosts regular local tournaments & training sessions.',
    ),

    // 6.1. CHESS RECOMMENDED VENUE 1
    TurfModel(
      id: 'turf_ch_1',
      name: 'Brainstorm Chess Academy',
      sport: 'Chess',
      location: 'Sagardighi Rd, Sylhet',
      address: 'The Bornamala Point, 79 Sagardighi Rd, Sylhet 3100',
      pricePerHour: 500.0,
      rating: 5.0,
      reviewCount: 3,
      surfaceType: 'Wooden Table',
      hasFloodlights: true,
      amenities: ['Air Conditioned', 'Digital Clocks', 'Master Coaching', 'Free WiFi'],
      images: [
        'assets/images/sylhet_brainstorm_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 20,
      dimensions: 'Professional Chess Training Hub',
      availableSlots: [
        '10:00 AM - 12:00 PM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Brainstorm Chess Academy, The Bornamala Point, 79 Sagardighi Rd, Sylhet 3100. Rating: 5.0(3). Led by international rated player Santana Zahid, this academy provides targeted lessons in tactical calculations, opening theory, and endgame strategies.',
    ),

    // 6.2. CHESS RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_ch_2',
      name: 'Sylhet Chess Club',
      sport: 'Chess',
      location: 'Rikabi Bazar, Sylhet',
      address: 'District Stadium, Rikabi Bazar, Sylhet',
      pricePerHour: 400.0,
      rating: 4.6,
      reviewCount: 45,
      surfaceType: 'Standard Tournament Table',
      hasFloodlights: true,
      amenities: ['FIDE Boards', 'Tournament Seating', 'Coaching Staff', 'Parking'],
      images: [
        'assets/images/sylhet_district_stadium_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 50,
      dimensions: 'Regional Championship Hall',
      availableSlots: [
        '09:00 AM - 11:00 AM',
        '03:00 PM - 05:00 PM',
        '05:00 PM - 07:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet Chess Club, District Stadium, Rikabi Bazar, Sylhet. Rating: 4.6(45). A core regional sports and recreation establishment focused on competitive coaching, learning facilities, and division-wide chess championships.',
    ),

    // 6.3. CHESS RECOMMENDED VENUE 3
    TurfModel(
      id: 'turf_ch_3',
      name: 'SUST Chess Club',
      sport: 'Chess',
      location: 'SUST Campus, Sylhet',
      address: 'Shahjalal University of Science and Technology, Sylhet',
      pricePerHour: 300.0,
      rating: 4.8,
      reviewCount: 85,
      surfaceType: 'Campus Lounge Table',
      hasFloodlights: true,
      amenities: ['Lichess Arena Access', 'Campus WiFi', 'Student Lounge', 'Free Coffee'],
      images: [
        'assets/images/sylhet_sust_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 40,
      dimensions: 'Collegiate Chess Hub',
      availableSlots: [
        '11:00 AM - 01:00 PM',
        '04:00 PM - 06:00 PM',
      ],
      isFeatured: false,
      description: 'SUST Chess Club, Shahjalal University of Science and Technology, Sylhet. Rating: 4.8(85). A highly active collegiate club hosting rapid-fire online arenas, inter-university team battles, and campus-wide community events.',
    ),

    // 6.4. CHESS RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_ch_4',
      name: 'Association of Chess Players Sylhet (ACPS)',
      sport: 'Chess',
      location: 'Zindabazar, Sylhet',
      address: 'ACPS Center, Zindabazar Sports Precinct, Sylhet',
      pricePerHour: 450.0,
      rating: 4.7,
      reviewCount: 32,
      surfaceType: 'FIDE Rated Board',
      hasFloodlights: true,
      amenities: ['FIDE Ratings Center', 'National Selection Trials', 'Pro Coaching'],
      images: [
        'assets/images/sylhet_acps_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 30,
      dimensions: 'Official Tournament Arena',
      availableSlots: [
        '10:00 AM - 12:00 PM',
        '05:00 PM - 07:00 PM',
      ],
      isFeatured: false,
      description: 'Association of Chess Players Sylhet (ACPS). Rating: 4.7(32). A localized branch connecting rated competitive players, managing selection trials for national tournaments, and providing community networking.',
    ),

    // 6.5. CHESS RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_ch_5',
      name: 'Sylhet Club Limited Chess Lounge',
      sport: 'Chess',
      location: 'Borshala, Airport Bypass, Sylhet',
      address: 'Sylhet Club Limited, Borshala, Airport Bypass, Sylhet 3100',
      pricePerHour: 600.0,
      rating: 4.5,
      reviewCount: 150,
      surfaceType: 'Luxury Wooden Board Table',
      hasFloodlights: true,
      amenities: ['Fine Dining', 'Pool Lounge', 'Air Conditioned', 'Valet Parking', 'Free WiFi'],
      images: [
        'assets/images/sylhet_club_limited_chess.jpg',
        'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 16,
      dimensions: 'VIP Games Room',
      availableSlots: [
        '11:00 AM - 01:00 PM',
        '04:00 PM - 06:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'Sylhet Club Limited Chess Lounge, Borshala, Airport Bypass, Sylhet 3100. Rating: 4.5(150). An upscale social and recreational club featuring a dedicated indoor games area where members gather for casual board games like chess and pool.',
    ),

    // 8. FOOTBALL RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_fb_2',
      name: 'Goal Indoor Sports Centre',
      sport: 'Football',
      location: 'Kumarpara Rd, Sylhet',
      address: 'Ad Bangla Media, Bhatipara House, 35/2 Kumarpara Rd, Sylhet',
      pricePerHour: 1800.0,
      rating: 4.3,
      reviewCount: 289,
      surfaceType: 'Indoor Artificial Turf',
      hasFloodlights: true,
      amenities: ['Air Conditioned', 'Locker Room', 'Shower', 'High-Speed WiFi', 'Mineral Water'],
      images: [
        'assets/images/sylhet_goal_indoor.jpg',
        'assets/images/sylhet_badminton.jpg',
      ],
      capacity: 12,
      dimensions: '35m x 20m',
      availableSlots: [
        '08:00 AM - 10:00 AM',
        '03:00 PM - 05:00 PM',
        '07:00 PM - 09:00 PM',
      ],
      isFeatured: false,
      description: 'Goal Indoor Sports Centre, Sylhet. Rating: 4.3(289). "Best turf football field in the centre of Sylhet city." Located at Bhatipara House, 35/2 Kumarpara Road.',
    ),

    // 9. FOOTBALL RECOMMENDED VENUE 3
    TurfModel(
      id: 'turf_fb_3',
      name: 'Soccer Zone Indoor Sports Centre',
      sport: 'Football',
      location: 'Shahjalal Road, Sylhet',
      address: '31/E (beside Shahjalal Servicing Center), Sylhet',
      pricePerHour: 1600.0,
      rating: 3.9,
      reviewCount: 213,
      surfaceType: 'Indoor Turf',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Shower', 'Mineral Water', 'Parking'],
      images: [
        'assets/images/sylhet_soccer_zone.jpg',
        'assets/images/sylhet_stadium.jpg',
      ],
      capacity: 12,
      dimensions: '35m x 20m',
      availableSlots: [
        '09:00 AM - 11:00 AM',
        '04:00 PM - 06:00 PM',
        '08:00 PM - 10:00 PM',
      ],
      isFeatured: false,
      description: 'Soccer Zone Indoor Sports Centre, Sylhet. Rating: 3.9(213). "Awesome indoor stadium.. love to play there." Located at 31/E beside Shahjalal Servicing Center.',
    ),

    // 10. FOOTBALL RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_fb_4',
      name: 'Crossbar Indoor Football',
      sport: 'Football',
      location: 'Sheikh Akram Ullah Rd, Sylhet',
      address: 'Sheikh Akram Ullah Rd, Sylhet',
      pricePerHour: 1700.0,
      rating: 4.2,
      reviewCount: 36,
      surfaceType: 'Futsal Court',
      hasFloodlights: true,
      amenities: ['Locker Room', 'High-Speed WiFi', 'Mineral Water', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_crossbar_indoor.jpg',
        'assets/images/sylhet_stadium.jpg',
      ],
      capacity: 10,
      dimensions: '30m x 18m',
      availableSlots: [
        '10:00 AM - 12:00 PM',
        '05:00 PM - 07:00 PM',
        '09:00 PM - 11:00 PM',
      ],
      isFeatured: false,
      description: 'Crossbar Indoor Football. Rating: 4.2(36). "Overall, a great place to play and enjoy football." Located at Sheikh Akram Ullah Rd, Sylhet.',
    ),

    // 11. FOOTBALL RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_fb_5',
      name: 'Abul Maal Abdul Muhith Sports Complex',
      sport: 'Football',
      location: 'Tilagarh, Sylhet',
      address: 'Tilagarh - Eco Park Rd, MC College Area, Sylhet 3100',
      pricePerHour: 1650.0,
      rating: 4.6,
      reviewCount: 410,
      surfaceType: 'Synthetic Turf',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Shower', 'High-Speed WiFi', 'Mineral Water', 'Parking', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_ama_muhith.jpg',
        'assets/images/sylhet_stadium.jpg',
      ],
      capacity: 16,
      dimensions: '50m x 30m',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
        '08:00 PM - 10:00 PM',
      ],
      isFeatured: false,
      description: 'Abul Maal Abdul Muhith Sports Complex (আবুল মাল আব্দুল মুহিত ক্রীড়া কমপ্লেক্স), Tilagarh, Sylhet. Rating: 4.6(410). A premier sports complex featuring professional floodlit synthetic turf football pitch, spectator seating, and modern amenities.',
    ),

    // 12. CRICKET RECOMMENDED VENUE 1
    TurfModel(
      id: 'turf_cr_1',
      name: 'Shahjalal University Cricket Ground',
      sport: 'Cricket',
      location: 'Kumargaon, Sylhet',
      address: 'SUST Central Playground, Kumargaon, Sylhet 3114',
      pricePerHour: 2200.0,
      rating: 4.4,
      reviewCount: 87,
      surfaceType: 'Professional Grass Pitch',
      hasFloodlights: true,
      amenities: ['Locker Room', 'Gear Rental', 'Free Parking', 'Cafe Bar', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_cricket_ground2.jpg',
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 5000,
      dimensions: 'Standard Oval Pitch',
      availableSlots: [
        '07:00 AM - 09:30 AM',
        '10:00 AM - 12:30 PM',
        '03:00 PM - 05:30 PM',
      ],
      isFeatured: false,
      description: 'Shahjalal University Cricket Ground, Kumargaon, Sylhet. Rating: 4.4(87). A premier collegiate cricket ground situated inside Shahjalal University campus featuring professional turf pitch, net practice facilities, and tournament hosting.',
    ),

    // 13. CRICKET RECOMMENDED VENUE 2
    TurfModel(
      id: 'turf_cr_2',
      name: 'Green Sylhet Cricket Academy',
      sport: 'Cricket',
      location: 'Airport Rd, Sylhet',
      address: 'VVX7+79G, Airport Rd / Electric Supply Rd Area, Sylhet',
      pricePerHour: 1800.0,
      rating: 4.5,
      reviewCount: 19,
      surfaceType: 'Net Practice & Turf Pitch',
      hasFloodlights: true,
      amenities: ['Gear Rental', 'Locker Room', 'Mineral Water', 'Coaching Staff'],
      images: [
        'assets/images/sylhet_green_cricket_academy.jpg',
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 22,
      dimensions: '22 Yards Net Pitches',
      availableSlots: [
        '06:30 AM - 08:30 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Green Sylhet Cricket Academy. Rating: 4.5(19). Specialized training institute and practice ground equipped with proper cricket pitches, net facilities, and qualified coaching for junior and senior cricket athletes.',
    ),

    // 15. CRICKET RECOMMENDED VENUE 4
    TurfModel(
      id: 'turf_cr_4',
      name: 'Chatol Cricket Ground',
      sport: 'Cricket',
      location: 'Airport Road, Sylhet',
      address: 'Chatol, Airport Road, Sylhet',
      pricePerHour: 1400.0,
      rating: 4.6,
      reviewCount: 10,
      surfaceType: 'Open Air Field',
      hasFloodlights: true,
      amenities: ['Free Parking', 'Mineral Water', 'First Aid Kit'],
      images: [
        'assets/images/sylhet_chatol_cricket_ground.jpg',
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 50,
      dimensions: 'Open Air Cricket Field',
      availableSlots: [
        '07:00 AM - 09:00 AM',
        '04:00 PM - 06:00 PM',
        '06:00 PM - 08:00 PM',
      ],
      isFeatured: false,
      description: 'Chatol Cricket Ground. Rating: 4.6(10). Situated along Airport Road near Chatol area. Open-air local field favored by amateur cricket clubs and community tape-tennis teams for unrestricted daytime matches.',
    ),

    // 16. CRICKET RECOMMENDED VENUE 5
    TurfModel(
      id: 'turf_cr_5',
      name: 'Jaintapur Border Area Ground',
      sport: 'Cricket',
      location: 'Jaintapur, Sylhet',
      address: 'Rural Outskirts, Jaintapur Border Zone, Sylhet',
      pricePerHour: 1100.0,
      rating: 4.3,
      reviewCount: 24,
      surfaceType: 'Natural Grass Space',
      hasFloodlights: false,
      amenities: ['Free Parking', 'Mineral Water', 'Scenic Boundary'],
      images: [
        'assets/images/sylhet_jaintapur_border_ground.jpg',
        'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1200&q=80',
      ],
      capacity: 200,
      dimensions: 'Open Rural Cricket Ground',
      availableSlots: [
        '08:00 AM - 11:00 AM',
        '02:00 PM - 05:00 PM',
      ],
      isFeatured: false,
      description: 'Jaintapur Border Area Ground, Sylhet. Rating: 4.3(24). Situated in the rural outskirts of the Jaintapur border zone, this open grass space is popular among traveling sports clubs for its picturesque natural scenery and casual weekend tournament matches.',
    ),
  ];
}
