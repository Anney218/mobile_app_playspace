import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(
            title: 'My Bookings',
            showBackButton: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // Sleek Full-Width Tab Header
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark ? Colors.white.withOpacity(0.1) : Colors.black12,
                    ),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.primaryPurple,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryPurple.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    tabs: const [
                      Tab(text: 'Active Reservations'),
                      Tab(text: 'Past History'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _ActiveBookingsTab(),
                      _PastBookingsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActiveBookingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final activeList = bookingProvider.activeBookings;

    if (bookingProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeList.isEmpty) {
      return _EmptyBookingState(
        message: 'No Active Reservations Found 🎟️',
        subtext: 'You have no upcoming match bookings. Explore top turfs and book your slot now!',
        onActionPressed: () {
          Navigator.pushNamed(context, '/search');
        },
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: activeList.length,
      itemBuilder: (context, index) {
        return _BookingItemCard(booking: activeList[index]);
      },
    );
  }
}

class _PastBookingsTab extends StatelessWidget {
  void _confirmClearAll(BuildContext context, BookingProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_sweep_rounded, color: AppColors.warningRed),
            SizedBox(width: 8),
            Text('Clear All History?'),
          ],
        ),
        content: const Text(
          'Are you sure you want to permanently delete all past booking history records?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warningRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              await provider.clearAllPastHistory();
              if (ctx.mounted) Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All past booking history deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final pastList = bookingProvider.pastBookings;

    if (bookingProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (pastList.isEmpty) {
      return const _EmptyBookingState(
        message: 'No Past History Records 📜',
        subtext: 'Your completed or cancelled bookings will appear here.',
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${pastList.length} Saved Record${pastList.length > 1 ? "s" : ""}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.warningRed,
                ),
                icon: const Icon(Icons.delete_sweep_rounded, size: 18),
                label: const Text(
                  'Clear All History',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _confirmClearAll(context, bookingProvider),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            itemCount: pastList.length,
            itemBuilder: (context, index) {
              return _BookingItemCard(booking: pastList[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _BookingItemCard extends StatelessWidget {
  final BookingModel booking;

  const _BookingItemCard({required this.booking});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return AppColors.vibrantGreen;
      case 'Completed':
        return AppColors.primaryPurple;
      case 'Cancelled':
        return AppColors.warningRed;
      default:
        return Colors.grey;
    }
  }

  void _confirmDeleteSingle(BuildContext context, BookingProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_outline_rounded, color: AppColors.warningRed),
            SizedBox(width: 8),
            Text('Delete Record?'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${booking.turfName}" record from history?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warningRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              await provider.deleteBooking(booking.id);
              if (ctx.mounted) Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking history record deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final isPastOrCancelled = booking.isPast || booking.status == 'Cancelled' || booking.status == 'Completed';

    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassmorphicCard(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Name & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.sports_soccer_rounded, color: AppColors.primaryPurple, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          booking.turfName,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(booking.status).withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(booking.status),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Location
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 15, color: AppColors.accentTeal),
                const SizedBox(width: 6),
                Text(
                  booking.turfLocation,
                  style: TextStyle(fontSize: 13, color: secondaryTextColor),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
            const SizedBox(height: 14),

            // Booking Details Grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailCell(
                    context,
                    Icons.calendar_month_rounded,
                    'Date',
                    DateFormat('dd MMM yyyy').format(booking.bookingDate),
                    isDark,
                  ),
                ),
                Expanded(
                  child: _buildDetailCell(
                    context,
                    Icons.access_time_rounded,
                    'Slot Time',
                    booking.timeSlot,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDetailCell(
                    context,
                    Icons.groups_rounded,
                    'Team Name',
                    '${booking.teamName} (${booking.playerCount}P)',
                    isDark,
                  ),
                ),
                Expanded(
                  child: _buildDetailCell(
                    context,
                    Icons.phone_android_rounded,
                    'Contact',
                    booking.contactNumber,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
            const SizedBox(height: 14),

            // Bottom Footer: Total Paid & Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 11, color: secondaryTextColor),
                    ),
                    Text(
                      '৳${booking.totalAmount.toInt()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.goldAccent,
                      ),
                    ),
                  ],
                ),

                if (booking.status == 'Confirmed' && !booking.isPast)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warningRed.withOpacity(0.12),
                      foregroundColor: AppColors.warningRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.warningRed.withOpacity(0.4)),
                      ),
                    ),
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: const Text('Cancel Booking', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Cancel Reservation?'),
                          content: const Text('Are you sure you want to cancel this turf booking?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('No'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.warningRed,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Cancel Booking'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await bookingProvider.cancelBooking(booking.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking cancelled successfully'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  )
                else if (isPastOrCancelled)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.warningRed,
                      side: const BorderSide(color: AppColors.warningRed),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.delete_outline_rounded, size: 16),
                    label: const Text('Delete Record', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    onPressed: () => _confirmDeleteSingle(context, bookingProvider),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCell(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.accentTeal),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: secondaryTextColor),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyBookingState extends StatelessWidget {
  final String message;
  final String subtext;
  final VoidCallback? onActionPressed;

  const _EmptyBookingState({
    required this.message,
    required this.subtext,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryPurple.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.confirmation_number_outlined,
                size: 56,
                color: AppColors.primaryPurple,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: primaryTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtext,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: secondaryTextColor,
              ),
            ),
            if (onActionPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                icon: const Icon(Icons.search_rounded, size: 20),
                label: const Text(
                  'Explore Turfs & Book Now',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: onActionPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
