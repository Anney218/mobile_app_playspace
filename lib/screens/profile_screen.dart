import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/booking_provider.dart';
import '../providers/student_provider.dart';
import '../providers/turf_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showUpdateAvatarModal(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
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
                  const Row(
                    children: [
                      Icon(Icons.camera_alt_rounded, color: AppColors.goldAccent, size: 26),
                      SizedBox(width: 10),
                      Text(
                        'Update Profile Picture 📸',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.photo_camera_rounded, color: AppColors.primaryPurple, size: 22),
                ),
                title: const Text('Take Photo with Camera', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Use camera to capture new profile photo'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('📸 Profile photo captured from Camera!'),
                      backgroundColor: AppColors.vibrantGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accentTeal.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: AppColors.accentTeal, size: 22),
                ),
                title: const Text('Choose from Photo Gallery', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Select existing photo from device storage'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🖼️ Profile picture selected from Gallery!'),
                      backgroundColor: AppColors.vibrantGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.face_rounded, color: AppColors.goldAccent, size: 22),
                ),
                title: const Text('Select AI Avatar Preset', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Choose pre-made AI sports profile photo'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✨ AI Sports Avatar preset applied!'),
                      backgroundColor: AppColors.vibrantGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditProfileModal(BuildContext context, StudentProvider studentProvider) {
    final nameController = TextEditingController(text: studentProvider.studentName);
    final phoneController = TextEditingController(text: studentProvider.phone);
    final locationController = TextEditingController(text: studentProvider.location);
    String selectedSport = studentProvider.primarySport;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24.0),
          child: StatefulBuilder(
            builder: (context, setModalState) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.edit_note_rounded, color: AppColors.primaryPurple, size: 26),
                          SizedBox(width: 10),
                          Text(
                            'Edit Profile Info',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Full Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.primaryPurple),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Phone Field
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone_android_rounded, color: AppColors.goldAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Location Field
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'City / Location',
                      prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.accentTeal),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Primary Sport Preference
                  DropdownButtonFormField<String>(
                    value: ['Football', 'Cricket', 'Badminton', 'Basketball', 'Tennis', 'Chess'].contains(selectedSport)
                        ? selectedSport
                        : 'Football',
                    decoration: InputDecoration(
                      labelText: 'Primary Sport Preference',
                      prefixIcon: const Icon(Icons.sports_soccer_rounded, color: AppColors.primaryPurple),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    dropdownColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                    items: ['Football', 'Cricket', 'Badminton', 'Basketball', 'Tennis', 'Chess']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          selectedSport = val;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        final newName = nameController.text.trim();
                        if (newName.isNotEmpty) {
                          studentProvider.saveProfile(
                            newName,
                            'USR-2026-88',
                            phoneNum: phoneController.text.trim(),
                            userLoc: locationController.text.trim(),
                            sport: selectedSport,
                          );
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🎉 Profile updated successfully!'),
                              backgroundColor: AppColors.vibrantGreen,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studentProvider = context.watch<StudentProvider>();
    final turfProvider = context.watch<TurfProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

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
          title: 'My Profile',
          showBackButton: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Settings',
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            child: Column(
              children: [
                // 1. Centered Hero Profile Block with AI Female Avatar
                Center(
                  child: Column(
                    children: [
                      // Avatar with Edit Badge
                      GestureDetector(
                        onTap: () => _showUpdateAvatarModal(context, isDark),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [AppColors.goldAccent, AppColors.accentTeal],
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 46,
                                backgroundColor: isDark ? AppColors.darkBg : AppColors.primaryPurple,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(46),
                                  child: Image.asset(
                                    'assets/images/user_avatar.jpg',
                                    width: 92,
                                    height: 92,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, stack) => const Icon(
                                      Icons.person_rounded,
                                      color: Colors.white,
                                      size: 52,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.goldAccent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                                  width: 2.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // User Name
                      Text(
                        studentProvider.studentName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: primaryTextColor,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 3),

                      // User Email
                      Text(
                        studentProvider.studentEmail,
                        style: TextStyle(
                          fontSize: 13,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 2. Quick Activity Stats Grid (2 Pillars: Favorites & Bookings)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/favorites'),
                        child: GlassmorphicCard(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            children: [
                              const Icon(Icons.favorite_rounded, color: AppColors.warningRed, size: 22),
                              const SizedBox(height: 4),
                              Text(
                                '${turfProvider.favoriteIds.length}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                              ),
                              Text(
                                'Favorites',
                                style: TextStyle(fontSize: 11, color: secondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/history'),
                        child: GlassmorphicCard(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            children: [
                              const Icon(Icons.confirmation_number_rounded, color: AppColors.primaryPurple, size: 22),
                              const SizedBox(height: 4),
                              Text(
                                '${bookingProvider.bookings.length}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                              ),
                              Text(
                                'Bookings',
                                style: TextStyle(fontSize: 11, color: secondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // 3. Grouped Sleek Navigation Tile Container
                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      // Tile 1: Edit Profile Information
                      _buildProfileTile(
                        context: context,
                        icon: Icons.person_outline_rounded,
                        iconColor: AppColors.goldAccent,
                        title: 'Edit Profile Information',
                        subtitle: 'Name, phone, city & preferred sport (${studentProvider.primarySport})',
                        isDark: isDark,
                        onTap: () => _openEditProfileModal(context, studentProvider),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                      ),

                      // Tile 2: Update Profile Picture
                      _buildProfileTile(
                        context: context,
                        icon: Icons.camera_alt_outlined,
                        iconColor: AppColors.accentTeal,
                        title: 'Update Profile Picture',
                        subtitle: 'Camera photo, gallery image or AI sports preset',
                        isDark: isDark,
                        onTap: () => _showUpdateAvatarModal(context, isDark),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                      ),

                      // Tile 3: My Bookings History
                      _buildProfileTile(
                        context: context,
                        icon: Icons.confirmation_number_outlined,
                        iconColor: AppColors.primaryPurple,
                        title: 'My Bookings History',
                        subtitle: 'Upcoming & past venue reservations (${bookingProvider.bookings.length})',
                        isDark: isDark,
                        onTap: () => Navigator.pushNamed(context, '/history'),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                      ),

                      // Tile 4: Saved Favorites
                      _buildProfileTile(
                        context: context,
                        icon: Icons.favorite_border_rounded,
                        iconColor: AppColors.warningRed,
                        title: 'Saved Favorites',
                        subtitle: 'View bookmarked venue spaces (${turfProvider.favoriteIds.length})',
                        isDark: isDark,
                        onTap: () => Navigator.pushNamed(context, '/favorites'),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                      ),

                      // Tile 5: App Settings
                      _buildProfileTile(
                        context: context,
                        icon: Icons.settings_outlined,
                        iconColor: AppColors.accentTeal,
                        title: 'App Settings',
                        subtitle: 'Notifications & slot preferences',
                        isDark: isDark,
                        onTap: () => Navigator.pushNamed(context, '/settings'),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
                      ),

                      // Tile 6: Help & Support
                      _buildProfileTile(
                        context: context,
                        icon: Icons.help_outline_rounded,
                        iconColor: AppColors.goldAccent,
                        title: 'Help & Support',
                        subtitle: '24/7 PlaySpace venue booking helpline',
                        isDark: isDark,
                        onTap: () => _showHelpSupportModal(context, isDark),
                      ),
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

  Widget _buildProfileTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: secondaryTextColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 22),
      onTap: onTap,
    );
  }
}
