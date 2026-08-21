import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/booking_model.dart';
import '../models/turf_model.dart';
import '../providers/booking_provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/slot_chip.dart';

class BookingScreen extends StatefulWidget {
  final TurfModel turf;
  final String? initialTimeSlot;

  const BookingScreen({
    super.key,
    required this.turf,
    this.initialTimeSlot,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;
  late String _selectedTimeSlot;
  int _durationHours = 1;
  int _playerCount = 10;
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Default to tomorrow or today
    _selectedDate = DateTime.now().add(const Duration(days: 1));
    _selectedTimeSlot = widget.initialTimeSlot ??
        (widget.turf.availableSlots.isNotEmpty
            ? widget.turf.availableSlots.first
            : '06:00 PM - 07:30 PM');
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double get _totalPrice => widget.turf.pricePerHour * _durationHours;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isBefore(today) ? today : _selectedDate,
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryPurple,
              primary: AppColors.primaryPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Show Confirmation Modal Dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.assignment_turned_in_rounded, color: AppColors.primaryPurple),
              SizedBox(width: 10),
              Text('Confirm Reservation'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Venue: ${widget.turf.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Date: ${DateFormat('EEE, dd MMM yyyy').format(_selectedDate)}'),
              Text('Time Slot: $_selectedTimeSlot'),
              Text('Duration: $_durationHours Hour(s)'),
              Text('Team: ${_teamNameController.text.trim()}'),
              Text('Contact: ${_phoneController.text.trim()}'),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '৳${_totalPrice.toInt()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Edit'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    setState(() {
      _isSubmitting = true;
    });

    final newBooking = BookingModel(
      id: 'BK_${DateTime.now().millisecondsSinceEpoch}',
      turfId: widget.turf.id,
      turfName: widget.turf.name,
      turfLocation: widget.turf.location,
      turfImage: widget.turf.images.first,
      bookingDate: _selectedDate,
      timeSlot: _selectedTimeSlot,
      durationHours: _durationHours,
      playerCount: _playerCount,
      teamName: _teamNameController.text.toString().trim(),
      contactNumber: _phoneController.text.trim(),
      totalAmount: _totalPrice,
      createdAt: DateTime.now(),
      status: 'Confirmed',
    );

    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final success = await bookingProvider.createBooking(newBooking);

    setState(() {
      _isSubmitting = false;
    });

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Booking confirmed successfully!'),
            backgroundColor: AppColors.vibrantGreen,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save booking'),
            backgroundColor: AppColors.warningRed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: 'Book Venue',
          showBackButton: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // Venue Summary Header Card
                GlassmorphicCard(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          widget.turf.images.first,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: AppColors.primaryPurple,
                            child: const Icon(Icons.sports_soccer, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.turf.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.turf.location,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '৳${widget.turf.pricePerHour.toInt()} / hr',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 1. Date Picker
                const Text(
                  '1. Select Booking Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GlassmorphicCard(
                  onTap: () => _selectDate(context),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, color: AppColors.primaryPurple),
                          const SizedBox(width: 12),
                          Text(
                            DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.edit_calendar_rounded, color: AppColors.accentTeal, size: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 2. Select Time Slot
                const Text(
                  '2. Select Time Slot',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: widget.turf.availableSlots.map((slot) {
                    final isSelected = _selectedTimeSlot == slot;
                    return SlotChip(
                      slot: slot,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedTimeSlot = slot;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // 3. Duration & Player Count Row
                Row(
                  children: [
                    // Duration Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Duration',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.12)
                                    : Colors.black12,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _durationHours,
                                isExpanded: true,
                                items: [1, 2, 3, 4].map((hrs) {
                                  return DropdownMenuItem<int>(
                                    value: hrs,
                                    child: Text('$hrs ${hrs == 1 ? 'Hour' : 'Hours'}'),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _durationHours = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Player Count Slider/Picker
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Players: $_playerCount',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            value: _playerCount.toDouble(),
                            min: 2,
                            max: 22,
                            divisions: 20,
                            activeColor: AppColors.accentTeal,
                            label: '$_playerCount Players',
                            onChanged: (val) {
                              setState(() {
                                _playerCount = val.toInt();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 4. Team Name Field
                const Text(
                  'Team Name',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _teamNameController,
                  validator: AppValidators.validateTeamName,
                  decoration: InputDecoration(
                    hintText: 'e.g. Dhaka Strikers FC',
                    prefixIcon: const Icon(Icons.groups_rounded, color: AppColors.primaryPurple),
                    filled: true,
                    fillColor: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white.withOpacity(0.12) : Colors.black12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 5. Contact Phone Field
                const Text(
                  'Contact Phone Number (11 Digits)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.validatePhone,
                  decoration: InputDecoration(
                    hintText: '017XXXXXXXX',
                    prefixIcon: const Icon(Icons.phone_android_rounded, color: AppColors.primaryPurple),
                    filled: true,
                    fillColor: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: isDark ? Colors.white.withOpacity(0.12) : Colors.black12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Total Summary Card
                GlassmorphicCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            '৳${_totalPrice.toInt()}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isSubmitting ? null : _submitBooking,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Confirm & Book',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
