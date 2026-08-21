import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/booking_provider.dart';
import 'providers/filter_provider.dart';
import 'providers/student_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/turf_provider.dart';
import 'screens/booking_history_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/app_drawer.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PlaySpaceApp());
}

class PlaySpaceApp extends StatelessWidget {
  const PlaySpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TurfProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.lightBg,
              primaryColor: AppColors.primaryPurple,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryPurple,
                brightness: Brightness.light,
                primary: AppColors.primaryPurple,
                secondary: AppColors.accentTeal,
              ),
              textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.darkBg,
              primaryColor: AppColors.primaryPurple,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryPurple,
                brightness: Brightness.dark,
                primary: AppColors.primaryPurple,
                secondary: AppColors.accentTeal,
              ),
              textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
            ),
            // Named Routes Setup
            initialRoute: '/',
            routes: {
              '/': (context) => const MainNavigationWrapper(),
              '/search': (context) => const SearchScreen(),
              '/favorites': (context) => const FavoritesScreen(),
              '/history': (context) => const BookingHistoryScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;
  bool _isDrawerOpen = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> screens = [
      HomeScreen(onNavigateTab: _onTabTapped),
      const SearchScreen(),
      const FavoritesScreen(),
      const BookingHistoryScreen(),
    ];

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
        onDrawerChanged: (isOpen) {
          setState(() {
            _isDrawerOpen = isOpen;
          });
        },
        drawer: AppDrawer(
          onNavigateTab: _onTabTapped,
          activeRoute: _currentIndex == 0
              ? '/'
              : _currentIndex == 1
                  ? '/search'
                  : _currentIndex == 2
                      ? '/favorites'
                      : '/history',
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        extendBody: true,

        // Glassmorphism Bottom Navigation Bar (Hidden when side drawer is open)
        bottomNavigationBar: _isDrawerOpen
            ? null
            : ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.12),
                          Colors.white.withOpacity(0.04),
                        ]
                      : [
                          Colors.white.withOpacity(0.85),
                          Colors.white.withOpacity(0.65),
                        ],
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.18)
                      : Colors.white.withOpacity(0.8),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.5)
                        : AppColors.primaryPurple.withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_rounded, 'Home'),
                  _buildNavItem(1, Icons.search_rounded, 'Search'),
                  _buildNavItem(2, Icons.favorite_rounded, 'Favorites'),
                  _buildNavItem(3, Icons.confirmation_number_rounded, 'Bookings'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.18),
                borderRadius: BorderRadius.circular(18),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? AppColors.primaryPurple
                  : isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
