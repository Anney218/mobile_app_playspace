import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/turf_provider.dart';
import '../utils/constants.dart';
import '../widgets/amenity_badge.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/slot_chip.dart';
import 'booking_screen.dart';

class TurfDetailScreen extends StatefulWidget {
  final String turfId;

  const TurfDetailScreen({super.key, required this.turfId});

  @override
  State<TurfDetailScreen> createState() => _TurfDetailScreenState();
}

class _TurfDetailScreenState extends State<TurfDetailScreen> {
  int _currentImageIndex = 0;
  String? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final turfProvider = Provider.of<TurfProvider>(context);
    final turf = turfProvider.getTurfById(widget.turfId);

    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    if (turf == null) {
      return const Scaffold(
        body: Center(child: Text('Venue not found')),
      );
    }

    final isFav = turfProvider.isFavorite(turf.id);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0F0E17),
                  const Color(0xFF1E1B2E),
                  const Color(0xFF13111C),
                ]
              : [
                  const Color(0xFFF8F9FE),
                  const Color(0xFFEDEEF7),
                  const Color(0xFFF1F2FC),
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: turf.name,
          showBackButton: true,
          actions: [
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : Colors.white,
              ),
              onPressed: () {
                turfProvider.toggleFavorite(turf.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFav ? 'Removed from favorites' : 'Added to favorites!',
                    ),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isDesktop = screenWidth > 750;

            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDesktop) ...[
                        // DESKTOP HERO CARD (Compact Image on Left, Details on Right)
                        GlassmorphicCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Side: Compact Photo Card
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  width: screenWidth * 0.36,
                                  height: 260,
                                  child: PageView.builder(
                                    itemCount: turf.images.length,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentImageIndex = index;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      final imgPath = turf.images[index];
                                      final isAsset = imgPath.startsWith('assets/');
                                      final imageProvider = isAsset
                                          ? AssetImage(imgPath) as ImageProvider
                                          : NetworkImage(imgPath);

                                      return Image(
                                        image: imageProvider,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: AppColors.primaryPurple.withOpacity(0.2),
                                          child: const Icon(
                                            Icons.sports_soccer,
                                            size: 60,
                                            color: AppColors.primaryPurple,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(width: 20),

                              // Right Side: Venue Title, Sport Tag, Rating & Stats Grid
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryPurple,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            turf.sport,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rounded, color: AppColors.goldAccent, size: 20),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${turf.rating}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: primaryTextColor,
                                              ),
                                            ),
                                            Text(
                                              ' (${turf.reviewCount} reviews)',
                                              style: TextStyle(fontSize: 12, color: secondaryTextColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Text(
                                      turf.name,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryTextColor,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 16, color: AppColors.accentTeal),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            turf.location,
                                            style: TextStyle(fontSize: 13, color: secondaryTextColor),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // Specifications Grid
                                    GlassmorphicCard(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          _buildStatItem(context, Icons.straighten, 'Dimensions', turf.dimensions),
                                          _buildStatItem(context, Icons.groups_outlined, 'Capacity', '${turf.capacity} Players'),
                                          _buildStatItem(context, Icons.grass, 'Surface', turf.surfaceType),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // MOBILE STACKED HERO BANNER
                        Container(
                          height: 240,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              itemCount: turf.images.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final imgPath = turf.images[index];
                                final isAsset = imgPath.startsWith('assets/');
                                final imageProvider = isAsset
                                    ? AssetImage(imgPath) as ImageProvider
                                    : NetworkImage(imgPath);

                                return Image(
                                  image: imageProvider,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                turf.sport,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, color: AppColors.goldAccent, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  '${turf.rating}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryTextColor),
                                ),
                                Text(
                                  ' (${turf.reviewCount} reviews)',
                                  style: TextStyle(fontSize: 12, color: secondaryTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          turf.name,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryTextColor),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: AppColors.accentTeal),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(turf.location, style: TextStyle(fontSize: 13, color: secondaryTextColor)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        GlassmorphicCard(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(context, Icons.straighten, 'Dimensions', turf.dimensions),
                              _buildStatItem(context, Icons.groups_outlined, 'Capacity', '${turf.capacity} Players'),
                              _buildStatItem(context, Icons.grass, 'Surface', turf.surfaceType),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // About Section
                      Text(
                        'About Venue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        turf.description,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: secondaryTextColor,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Amenities Section
                      Text(
                        'Amenities & Facilities',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: turf.amenities
                            .map<Widget>((a) => AmenityBadge(label: a))
                            .toList(),
                      ),

                      const SizedBox(height: 24),

                      // Available Time Slots Section
                      Text(
                        'Select Time Slot',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: turf.availableSlots.map<Widget>((slot) {
                          final isSelected = _selectedSlot == slot;
                          return SlotChip(
                            slot: slot,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedSlot = isSelected ? null : slot;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Bottom Floating Booking Action Bar
                Positioned(
                  bottom: 16,
                  left: 20,
                  right: 20,
                  child: GlassmorphicCard(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Price Rate',
                              style: TextStyle(fontSize: 11, color: secondaryTextColor),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '৳${turf.pricePerHour.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryPurple,
                                  ),
                                ),
                                const Text(
                                  ' / hr',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 46,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: AppColors.primaryPurple.withOpacity(0.5),
                            ),
                            icon: const Icon(Icons.flash_on_rounded),
                            label: const Text(
                              'Book Venue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookingScreen(
                                    turf: turf,
                                    initialTimeSlot: _selectedSlot,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(icon, color: AppColors.accentTeal, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
