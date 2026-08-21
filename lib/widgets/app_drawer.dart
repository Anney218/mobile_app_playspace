import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';

class AppDrawer extends StatelessWidget {
  final Function(int)? onNavigateTab;
  final String activeRoute;

  const AppDrawer({
    super.key,
    this.onNavigateTab,
    this.activeRoute = '/',
  });

  void _showHelpSupportModal(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.accentTeal.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.help_outline_rounded, color: AppColors.accentTeal, size: 26),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Help & Support 💬',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'PlaySpace 24/7 Helpline',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.phone_rounded, color: AppColors.primaryPurple),
                title: const Text('+880 1700-PLAYSPACE'),
                subtitle: const Text('Toll-free venue booking helpline'),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined, color: AppColors.accentTeal),
                title: const Text('support@playspace.app'),
                subtitle: const Text('Send queries & refund requests'),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined, color: AppColors.goldAccent),
                title: const Text('Sylhet Sports Hub'),
                subtitle: const Text('Zindabazar & Rikabi Bazar HQ'),
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.warningRed),
            SizedBox(width: 10),
            Text('Logout Session?'),
          ],
        ),
        content: const Text('Are you sure you want to sign out from PlaySpace app?'),
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
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // Close drawer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully. Default profile active.'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.primaryPurple,
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);

    final bgDrawerColor = isDark ? const Color(0xFF13121A) : const Color(0xFFFAFAFE);
    final primaryTextColor = isDark ? Colors.white : const Color(0xFF1E1B2E);
    final secondaryTextColor = isDark ? Colors.white60 : Colors.black54;

    return Drawer(
      backgroundColor: bgDrawerColor,
      elevation: 16,
      width: 295,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // 1. Top App Logo Header Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.goldAccent, AppColors.accentTeal],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isDark ? const Color(0xFF1E1B2E) : AppColors.primaryPurple,
                      child: const Icon(
                        Icons.sports_soccer_rounded,
                        color: AppColors.goldAccent,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLAYSPACE',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: isDark ? AppColors.goldAccent : AppColors.primaryPurple,
                          ),
                        ),
                        Text(
                          'Turf & Sports Venue Booking',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
            ),
            const SizedBox(height: 16),

            // 3. Drawer Items List
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  // Discover
                  _buildNavItem(
                    context: context,
                    icon: Icons.explore_rounded,
                    label: 'Discover',
                    isActive: activeRoute == '/',
                    highlighted: true,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      if (onNavigateTab != null) {
                        onNavigateTab!(0);
                      } else {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                  ),

                  const SizedBox(height: 4),

                  // Saved Favorites
                  _buildNavItem(
                    context: context,
                    icon: Icons.favorite_border_rounded,
                    label: 'Saved Favorites',
                    isActive: activeRoute == '/favorites',
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      if (onNavigateTab != null) {
                        onNavigateTab!(2);
                      } else {
                        Navigator.pushNamed(context, '/favorites');
                      }
                    },
                  ),

                  // My Bookings
                  _buildNavItem(
                    context: context,
                    icon: Icons.confirmation_number_outlined,
                    label: 'My Bookings',
                    isActive: activeRoute == '/history',
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      if (onNavigateTab != null) {
                        onNavigateTab!(3);
                      } else {
                        Navigator.pushNamed(context, '/history');
                      }
                    },
                  ),

                  // Profile
                  _buildNavItem(
                    context: context,
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    isActive: activeRoute == '/profile',
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),

                  // Settings
                  _buildNavItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    isActive: activeRoute == '/settings',
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),

                  // Offers & Promos Item (NEW)
                  _buildNavItemWithBadge(
                    context: context,
                    icon: Icons.local_offer_outlined,
                    label: 'Offers & Promos',
                    badgeText: '15% OFF',
                    badgeColor: AppColors.vibrantGreen,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('🎉 Student Special 15% OFF discount is active!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.vibrantGreen,
                        ),
                      );
                    },
                  ),

                  // Sports Tournaments Item (NEW)
                  _buildNavItemWithBadge(
                    context: context,
                    icon: Icons.emoji_events_outlined,
                    label: 'Tournaments',
                    badgeText: 'HOT',
                    badgeColor: AppColors.goldAccent,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('⚽ Sylhet Inter-Turf Football Championship 2026 coming soon!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.primaryPurple,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                  const SizedBox(height: 10),

                  // Appearance / Theme Toggle
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              themeProvider.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                              color: themeProvider.isDarkMode ? AppColors.goldAccent : AppColors.primaryPurple,
                              size: 22,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Appearance',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 0.85,
                          child: Switch(
                            value: themeProvider.isDarkMode,
                            activeColor: isDark ? AppColors.goldAccent : AppColors.primaryPurple,
                            activeTrackColor: (isDark ? AppColors.goldAccent : AppColors.primaryPurple).withOpacity(0.3),
                            inactiveThumbColor: Colors.grey,
                            onChanged: (val) {
                              themeProvider.toggleTheme(val);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Help & Support
                  _buildNavItem(
                    context: context,
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    isActive: false,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      _showHelpSupportModal(context, isDark);
                    },
                  ),

                  // About PlaySpace
                  _buildNavItem(
                    context: context,
                    icon: Icons.info_outline_rounded,
                    label: 'About PlaySpace',
                    isActive: false,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pop(context);
                      showAboutDialog(
                        context: context,
                        applicationName: 'PlaySpace App',
                        applicationVersion: 'v1.0.0',
                        applicationIcon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 28),
                        ),
                        applicationLegalese: '© 2026 PlaySpace App. All Rights Reserved.',
                        children: const [
                          SizedBox(height: 12),
                          Text('PlaySpace is a premier turf and sports venue booking platform built for Sylhet sports enthusiasts.'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Bottom Divider & Logout Sticky Item
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => _showLogoutConfirmDialog(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  decoration: BoxDecoration(
                    color: AppColors.warningRed.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.logout_rounded, color: AppColors.warningRed, size: 20),
                      SizedBox(width: 14),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.warningRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isDark,
    required VoidCallback onTap,
    bool highlighted = false,
  }) {
    final textColor = isDark ? Colors.white : const Color(0xFF1E1B2E);

    if (highlighted) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2A281E)
              : AppColors.primaryPurple.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? AppColors.goldAccent.withOpacity(0.4)
                : AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.goldAccent.withOpacity(0.2)
                  : AppColors.primaryPurple.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDark ? AppColors.goldAccent : AppColors.primaryPurple,
              size: 20,
            ),
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.goldAccent : AppColors.primaryPurple,
            ),
          ),
          trailing: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isDark ? AppColors.goldAccent : AppColors.primaryPurple,
              shape: BoxShape.circle,
            ),
          ),
          onTap: onTap,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(
          icon,
          color: isActive
              ? (isDark ? Colors.white : AppColors.primaryPurple)
              : (isDark ? Colors.white70 : Colors.black54),
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? textColor : textColor.withOpacity(0.85),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildNavItemWithBadge({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String badgeText,
    required Color badgeColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final textColor = isDark ? Colors.white : const Color(0xFF1E1B2E);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Icon(
          icon,
          color: isDark ? Colors.white70 : Colors.black54,
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor.withOpacity(0.85),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: badgeColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: badgeColor.withOpacity(0.5), width: 1),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: badgeColor == AppColors.goldAccent ? (isDark ? AppColors.goldAccent : Colors.orange.shade800) : badgeColor,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
