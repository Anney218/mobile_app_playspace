import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/turf_provider.dart';
import '../utils/constants.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/sport_category_chip.dart';
import '../widgets/turf_card.dart';
import '../widgets/app_drawer.dart';
import '../widgets/featured_banner_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const HomeScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final turfProvider = Provider.of<TurfProvider>(context);
    final featuredTurfs = turfProvider.featuredTurfs;
    final filteredTurfs = turfProvider.getFilteredTurfs(ignoreSearchQuery: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header with Drawer Trigger & Avatar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Drawer Open Button
                          IconButton(
                            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryPurple, size: 28),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sports_soccer_rounded,
                                        color: AppColors.accentTeal,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        AppConstants.appName,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Book sports venues near you',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Search Bar Box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GlassmorphicCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        onTap: () {
                          if (onNavigateTab != null) {
                            onNavigateTab!(1); // Navigate to Search tab
                          } else {
                            Navigator.pushNamed(context, '/search');
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: AppColors.primaryPurple,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Search venue, location, or sport...',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.tune_rounded,
                                size: 18,
                                color: AppColors.primaryPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Featured Carousel Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured Turfs 🔥',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            '${featuredTurfs.length} Venues',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Responsive Horizontal Featured List
                    SizedBox(
                      height: 315,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final screenWidth = MediaQuery.of(context).size.width;
                          final double cardWidth = screenWidth > 900
                              ? ((screenWidth - 40 - (featuredTurfs.length - 1) * 16) / featuredTurfs.length)
                                  .clamp(180.0, 320.0)
                              : 260.0;

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            itemCount: featuredTurfs.length,
                            itemBuilder: (context, index) {
                              return TurfCard(
                                turf: featuredTurfs[index],
                                isHorizontal: true,
                                width: cardWidth,
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sports Categories Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Sports Category Horizontal Chips
                    SizedBox(
                      height: 44,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: AppConstants.sportsCategories.length,
                        itemBuilder: (context, index) {
                          final sport = AppConstants.sportsCategories[index];
                          final isSelected = turfProvider.selectedSport == sport;
                          return SportCategoryChip(
                            label: sport,
                            isSelected: isSelected,
                            onTap: () {
                              turfProvider.setSelectedSport(sport);
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // All/Recommended Turfs List Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            turfProvider.selectedSport == 'All'
                                ? 'Recommended Venues'
                                : '${turfProvider.selectedSport} Venues',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            '${filteredTurfs.length} Found',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Recommended / All Turfs Vertical List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: filteredTurfs.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 48,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No venues found for this category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 700) {
                                  final crossAxisCount = constraints.maxWidth > 1100 ? 3 : 2;
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      mainAxisExtent: 420,
                                    ),
                                    itemCount: filteredTurfs.length,
                                    itemBuilder: (context, index) {
                                      return TurfCard(
                                        turf: filteredTurfs[index],
                                        isHorizontal: false,
                                      );
                                    },
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredTurfs.length,
                                  itemBuilder: (context, index) {
                                    return TurfCard(
                                      turf: filteredTurfs[index],
                                      isHorizontal: false,
                                    );
                                  },
                                );
                              },
                            ),
                    ),

                    const SizedBox(height: 28),

                      // 1. WHY CHOOSE PLAYSPACE SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Why Choose PlaySpace? ✨',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    isDark,
                                    Icons.flash_on_rounded,
                                    AppColors.goldAccent,
                                    'Instant Booking',
                                    'Real-time slot reservation in Sylhet',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    isDark,
                                    Icons.verified_user_rounded,
                                    AppColors.accentTeal,
                                    'Best Price',
                                    'No hidden fees & student offers',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    isDark,
                                    Icons.verified_rounded,
                                    AppColors.primaryPurple,
                                    'Verified Venues',
                                    'Quality pitches with lights & parking',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 2. SYLHET TOURNAMENT PROMO BANNER
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [AppColors.primaryPurple, AppColors.deepPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.goldAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '🏆 SYLHET LEAGUE 2026',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Host or Join Tournaments!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Register your team for upcoming football & cricket cups in Sylhet.',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentTeal,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: const Row(
                                        children: [
                                          Text('🏆 Sylhet Turf League 2026'),
                                        ],
                                      ),
                                      content: const Text(
                                        'Tournament registrations for Sylhet District Football & SUST Cricket Inter-Department Cup are opening next week! Stay tuned.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: const Text('Got it!'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Explore',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 3. PLAYER REVIEWS SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'What Sylhet Players Say 💬',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          children: [
                            _buildReviewCard(
                              isDark,
                              'Tanvir Hasan',
                              'Shahi Eidgah Mini Stadium',
                              'Booking Shahi Eidgah stadium slot was super fast! Instant confirmation and great turf.',
                              5.0,
                            ),
                            _buildReviewCard(
                              isDark,
                              'Sakib Ahmed',
                              'MC College Ground',
                              'MC College ground night slot with floodlights was awesome. Easy payment!',
                              5.0,
                            ),
                            _buildReviewCard(
                              isDark,
                              'Fahim Rahman',
                              'Sports Heaven Sylhet',
                              'Sports Heaven tennis court booking process was very smooth and hassle-free.',
                              4.9,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 4. STUDENT SPECIAL PROMO DISCOUNT BANNER
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              colors: isDark
                                  ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                                  : [const Color(0xFFEEF2FF), const Color(0xFFE0E7FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: AppColors.primaryPurple.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryPurple.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.school_rounded,
                                  color: AppColors.primaryPurple,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Student Special Offer 🎓',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? AppColors.darkTextPrimary
                                                : AppColors.lightTextPrimary,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.accentTeal,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            '15% OFF',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'SUST & MC College students get 15% off using code PLAYSTUDENT15',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 5. FREQUENTLY ASKED QUESTIONS (FAQ ACCORDION)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frequently Asked Questions ❓',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildFaqItem(
                              isDark,
                              'How do I book a court or pitch?',
                              'Tap any venue card from the home dashboard or search list, select your preferred date & time slot, and tap Confirm Booking.',
                            ),
                            _buildFaqItem(
                              isDark,
                              'Are night slots with floodlights available?',
                              'Yes! Venues like Shahi Eidgah Mini Stadium, MC College Ground, and SUST Field feature full night floodlight facilities.',
                            ),
                            _buildFaqItem(
                              isDark,
                              'Can I cancel or reschedule my booking?',
                              'You can view and manage all active bookings under the "My Bookings" tab at any time.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 6. APP FOOTER
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.sports_soccer, color: AppColors.accentTeal, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  AppConstants.appName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Sylhet Sports Booking System • Bangladesh',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '© 2026 PlaySpace App. All Rights Reserved.',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.darkTextSecondary.withOpacity(0.6)
                                    : AppColors.lightTextSecondary.withOpacity(0.6),
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
        );
      }

  Widget _buildFeatureCard(
    BuildContext context,
    bool isDark,
    IconData icon,
    Color color,
    String title,
    String desc,
  ) {
    return GlassmorphicCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    bool isDark,
    String name,
    String venue,
    String comment,
    double rating,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 14),
      child: GlassmorphicCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      venue,
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.goldAccent, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      '$rating',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '"$comment"',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(bool isDark, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.06),
        ),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          iconColor: AppColors.primaryPurple,
          collapsedIconColor: AppColors.primaryPurple,
          trailing: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryPurple,
            size: 24,
          ),
          title: Row(
            children: [
              const Icon(
                Icons.help_outline_rounded,
                size: 18,
                color: AppColors.primaryPurple,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 20,
                  color: AppColors.accentTeal,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
