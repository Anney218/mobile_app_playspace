import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Preferences State
  bool _pushNotifications = true;
  bool _emailConfirmations = true;
  bool _smsReminders = true;
  bool _promoAlerts = false;

  String _selectedLanguage = 'English (US)';
  String _selectedCurrency = 'BDT (৳)';
  String _selectedPaymentMethod = 'bKash Instant';
  String _defaultDuration = '60 Mins';

  void _showChangePasswordDialog(BuildContext context) {
    final passController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.lock_outline_rounded, color: AppColors.primaryPurple),
            SizedBox(width: 10),
            Text('Change Account Password'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: const Icon(Icons.lock_clock_outlined, color: AppColors.primaryPurple),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.key_rounded, color: AppColors.accentTeal),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎉 Password updated successfully!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.vibrantGreen,
                ),
              );
            },
            child: const Text('Update Password'),
          ),
        ],
      ),
    );
  }

  void _clearCache(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧹 App cache & local photo storage cleared (48.2 MB freed)!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.accentTeal,
      ),
    );
  }

  void _showReportIssueModal(BuildContext context, bool isDark) {
    final issueController = TextEditingController();
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
              const Row(
                children: [
                  Icon(Icons.bug_report_outlined, color: AppColors.warningRed, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Report Booking Issue ⚠️',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: issueController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Describe the issue with your turf booking or payment...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('📩 Ticket submitted! Support team will contact you shortly.'),
                        backgroundColor: AppColors.vibrantGreen,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Submit Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivacyPolicyModal(BuildContext context, bool isDark) {
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
              const Row(
                children: [
                  Icon(Icons.privacy_tip_outlined, color: AppColors.primaryPurple, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Privacy Policy & Legal 📜',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'PlaySpace Venue Booking App guarantees full data protection under Bangladesh ICT regulations. Payments made via bKash/Nagad are processed via SSL Commerz encrypted gateways.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Close'),
                ),
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
        appBar: const CustomAppBar(
          title: 'App Settings',
          showBackButton: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SECTION 1: ACCOUNT & SECURITY
                _buildSectionHeader('Account & Security 🔒', primaryTextColor),
                const SizedBox(height: 10),

                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      ListTile(
                        leading: _buildIconBadge(Icons.person_outline_rounded, AppColors.goldAccent),
                        title: Text('Edit Profile Details', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('${studentProvider.studentName} • ${studentProvider.studentEmail}', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Navigator.pushNamed(context, '/profile'),
                      ),
                      _buildDivider(isDark),
                      ListTile(
                        leading: _buildIconBadge(Icons.lock_outline_rounded, AppColors.primaryPurple),
                        title: Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Update login password & security PIN', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showChangePasswordDialog(context),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SECTION 2: BOOKING PREFERENCES
                _buildSectionHeader('Booking Preferences 🎟️', primaryTextColor),
                const SizedBox(height: 10),

                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      // Member Special Discount Switch
                      SwitchListTile(
                        secondary: _buildIconBadge(Icons.local_offer_rounded, AppColors.goldAccent),
                        title: Text(
                          'Member Special Discount (15% Off)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryTextColor),
                        ),
                        subtitle: Text(
                          'Applies student member pricing automatically',
                          style: TextStyle(fontSize: 12, color: secondaryTextColor),
                        ),
                        value: studentProvider.isStudentDiscountApplied,
                        activeColor: AppColors.primaryPurple,
                        onChanged: (val) {
                          studentProvider.toggleStudentDiscount(val);
                        },
                      ),

                      _buildDivider(isDark),

                      // Compact Sleek Dropdown 1: Default Duration
                      _buildDropdownTile(
                        context: context,
                        icon: Icons.timer_outlined,
                        iconColor: AppColors.primaryPurple,
                        title: 'Default Slot Match Duration',
                        value: _defaultDuration,
                        items: ['60 Mins', '90 Mins', '120 Mins (2 Hours)', '180 Mins (Half Day)'],
                        isDark: isDark,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _defaultDuration = val;
                            });
                          }
                        },
                      ),

                      _buildDivider(isDark),

                      // Compact Sleek Dropdown 2: Default Payment Option
                      _buildDropdownTile(
                        context: context,
                        icon: Icons.payment_rounded,
                        iconColor: AppColors.accentTeal,
                        title: 'Default Payment Option',
                        value: _selectedPaymentMethod,
                        items: ['bKash Instant', 'Nagad Direct', 'Credit/Debit Card', 'Pay at Venue (Cash)'],
                        isDark: isDark,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedPaymentMethod = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SECTION 3: NOTIFICATIONS & ALERTS
                _buildSectionHeader('Notifications & Alerts 🔔', primaryTextColor),
                const SizedBox(height: 10),

                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: _buildIconBadge(Icons.notifications_active_outlined, AppColors.primaryPurple),
                        title: Text('In-App Push Notifications', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Instant alerts for slot confirmation & status', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        value: _pushNotifications,
                        activeColor: AppColors.primaryPurple,
                        onChanged: (val) {
                          setState(() {
                            _pushNotifications = val;
                          });
                        },
                      ),
                      _buildDivider(isDark),
                      SwitchListTile(
                        secondary: _buildIconBadge(Icons.email_outlined, AppColors.accentTeal),
                        title: Text('Email Invoices & Confirmations', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Send digital PDF receipts via email', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        value: _emailConfirmations,
                        activeColor: AppColors.primaryPurple,
                        onChanged: (val) {
                          setState(() {
                            _emailConfirmations = val;
                          });
                        },
                      ),
                      _buildDivider(isDark),
                      SwitchListTile(
                        secondary: _buildIconBadge(Icons.sms_outlined, AppColors.goldAccent),
                        title: Text('SMS Match Reminders', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Get SMS 2 hours before match kickoff', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        value: _smsReminders,
                        activeColor: AppColors.primaryPurple,
                        onChanged: (val) {
                          setState(() {
                            _smsReminders = val;
                          });
                        },
                      ),
                      _buildDivider(isDark),
                      SwitchListTile(
                        secondary: _buildIconBadge(Icons.discount_outlined, AppColors.vibrantGreen),
                        title: Text('Promotional Discount Alerts', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Notifications for weekend flash deals & cashback', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        value: _promoAlerts,
                        activeColor: AppColors.primaryPurple,
                        onChanged: (val) {
                          setState(() {
                            _promoAlerts = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SECTION 4: LANGUAGE & REGION
                _buildSectionHeader('Language & Region 🌐', primaryTextColor),
                const SizedBox(height: 10),

                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      // Compact Sleek Dropdown 3: Language
                      _buildDropdownTile(
                        context: context,
                        icon: Icons.language_rounded,
                        iconColor: AppColors.accentTeal,
                        title: 'App Language',
                        value: _selectedLanguage,
                        items: ['English (US)', 'বাংলা (Bangla)'],
                        isDark: isDark,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedLanguage = val;
                            });
                          }
                        },
                      ),
                      _buildDivider(isDark),

                      // Compact Sleek Dropdown 4: Currency
                      _buildDropdownTile(
                        context: context,
                        icon: Icons.attach_money_rounded,
                        iconColor: AppColors.goldAccent,
                        title: 'Price & Currency Unit',
                        value: _selectedCurrency,
                        items: ['BDT (৳)', 'USD (\$)'],
                        isDark: isDark,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedCurrency = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // SECTION 5: STORAGE & SUPPORT
                _buildSectionHeader('Storage, Support & Legal ℹ️', primaryTextColor),
                const SizedBox(height: 10),

                GlassmorphicCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      ListTile(
                        leading: _buildIconBadge(Icons.cleaning_services_rounded, AppColors.accentTeal),
                        title: Text('Clear Storage & Cache', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Frees up local image memory (48.2 MB available)', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _clearCache(context),
                      ),
                      _buildDivider(isDark),
                      ListTile(
                        leading: _buildIconBadge(Icons.bug_report_outlined, AppColors.warningRed),
                        title: Text('Report a Booking Issue', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Submit support ticket to helpline team', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showReportIssueModal(context, isDark),
                      ),
                      _buildDivider(isDark),
                      ListTile(
                        leading: _buildIconBadge(Icons.privacy_tip_outlined, AppColors.goldAccent),
                        title: Text('Privacy Policy & Terms of Service', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('Read user terms, payment & refund policy', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showPrivacyPolicyModal(context, isDark),
                      ),
                      _buildDivider(isDark),
                      ListTile(
                        leading: _buildIconBadge(Icons.sports_soccer_rounded, AppColors.primaryPurple),
                        title: Text('PlaySpace App Version', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        subtitle: Text('v1.0.0 Production Academic Build', style: TextStyle(fontSize: 12, color: secondaryTextColor)),
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

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12, height: 1),
    );
  }

  Widget _buildDropdownTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
  }) {
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: _buildIconBadge(icon, iconColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.08) : AppColors.primaryPurple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white24 : AppColors.primaryPurple.withOpacity(0.2),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
            dropdownColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
