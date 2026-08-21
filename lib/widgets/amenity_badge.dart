import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AmenityBadge extends StatelessWidget {
  final String label;

  const AmenityBadge({
    super.key,
    required this.label,
  });

  IconData _getAmenityIcon(String amenity) {
    final lower = amenity.toLowerCase();
    if (lower.contains('locker')) return Icons.door_sliding_outlined;
    if (lower.contains('parking')) return Icons.local_parking_rounded;
    if (lower.contains('shower')) return Icons.shower_outlined;
    if (lower.contains('cafe')) return Icons.local_cafe_outlined;
    if (lower.contains('water')) return Icons.water_drop_outlined;
    if (lower.contains('gear') || lower.contains('equipment')) return Icons.sports_tennis_outlined;
    if (lower.contains('wifi')) return Icons.wifi_rounded;
    if (lower.contains('first aid')) return Icons.medical_services_outlined;
    if (lower.contains('air')) return Icons.ac_unit_rounded;
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primaryPurple.withOpacity(0.18)
            : AppColors.primaryPurple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryPurple.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getAmenityIcon(label),
            size: 14,
            color: AppColors.primaryPurple,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
