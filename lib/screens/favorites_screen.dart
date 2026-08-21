import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/turf_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/turf_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final turfProvider = Provider.of<TurfProvider>(context);
    final favTurfs = turfProvider.favoriteTurfs;

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
          title: 'Favorite Turfs (${favTurfs.length})',
          showBackButton: true,
        ),
        body: SafeArea(
          child: favTurfs.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.warningRed.withOpacity(0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.warningRed.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            size: 56,
                            color: AppColors.warningRed,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No Favorites Saved Yet ❤️',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tap the heart icon on any venue to save it here for quick 1-click booking!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: secondaryTextColor,
                          ),
                        ),
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
                            'Explore Venues & Add Favorites',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/search'),
                        ),
                      ],
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final isWide = screenWidth > 650;
                    final isExtraWide = screenWidth > 1100;
                    final crossAxisCount = isExtraWide ? 3 : (isWide ? 2 : 1);

                    if (isWide) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          childAspectRatio: isExtraWide ? 0.92 : 0.88,
                        ),
                        itemCount: favTurfs.length,
                        itemBuilder: (context, index) {
                          return TurfCard(
                            turf: favTurfs[index],
                            isHorizontal: false,
                          );
                        },
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                      itemCount: favTurfs.length,
                      itemBuilder: (context, index) {
                        return TurfCard(
                          turf: favTurfs[index],
                          isHorizontal: false,
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
