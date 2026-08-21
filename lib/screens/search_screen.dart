import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filter_provider.dart';
import '../providers/turf_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/turf_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final turfProvider = Provider.of<TurfProvider>(context);
    final filterProvider = Provider.of<FilterProvider>(context);

    final results = turfProvider.getFilteredTurfs(
      sports: filterProvider.selectedSports,
      priceRange: filterProvider.priceRange,
      minRating: filterProvider.minRating,
      surfaceType: filterProvider.surfaceType,
      floodlightsOnly: filterProvider.floodlightsOnly,
    );

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
          title: 'Search & Filter',
          showBackButton: true,
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Search Input Row + Filter Icon Button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.12)
                              : Colors.black.withOpacity(0.08),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          turfProvider.setSearchQuery(val);
                        },
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search turf name or location...',
                          hintStyle: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.primaryPurple,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    turfProvider.setSearchQuery('');
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Filter Button
                  GestureDetector(
                    onTap: () => _openFilterBottomSheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: filterProvider.isFilterActive
                            ? const LinearGradient(
                                colors: [AppColors.primaryPurple, AppColors.deepPurple],
                              )
                            : null,
                        color: filterProvider.isFilterActive
                            ? null
                            : isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: filterProvider.isFilterActive
                              ? AppColors.accentTeal
                              : isDark
                                  ? Colors.white.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.08),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            color: filterProvider.isFilterActive
                                ? Colors.white
                                : AppColors.primaryPurple,
                          ),
                          if (filterProvider.isFilterActive)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppColors.accentTeal,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Filter Status Bar (Reset Filter button if active)
              if (filterProvider.isFilterActive) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters Applied',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => filterProvider.resetFilters(),
                      child: const Text(
                        'Reset All',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.warningRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Results Count
              Text(
                '${results.length} Turf Venues Found',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),

              const SizedBox(height: 12),

              // Results List
              Expanded(
                child: results.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: isDark
                                  ? AppColors.darkTextSecondary.withOpacity(0.5)
                                  : AppColors.lightTextSecondary.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No matching turfs found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search query or filters',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 700) {
                            final crossAxisCount = constraints.maxWidth > 1100 ? 3 : 2;
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 100),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 420,
                              ),
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                return TurfCard(
                                  turf: results[index],
                                  isHorizontal: false,
                                );
                              },
                            );
                          }
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return TurfCard(
                                turf: results[index],
                                isHorizontal: false,
                              );
                            },
                          );
                        },
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

// Filter Bottom Sheet Widget
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filterProvider = Provider.of<FilterProvider>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return GlassmorphicCard(
          padding: const EdgeInsets.all(20),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: ListView(
            controller: scrollController,
            children: [
              // Bottom Sheet Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white30 : Colors.black26,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Title & Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Venues',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => filterProvider.resetFilters(),
                    child: const Text('Reset'),
                  ),
                ],
              ),

              const Divider(),

              // 1. Sport Type (Multi-select)
              const SizedBox(height: 10),
              const Text(
                'Sport Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: AppConstants.sportsCategories.map((sport) {
                  final isSelected = filterProvider.selectedSports.contains(sport);
                  return FilterChip(
                    label: Text(sport),
                    selected: isSelected,
                    selectedColor: AppColors.primaryPurple,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) {
                      filterProvider.toggleSport(sport);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // 2. Price Range Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price Range (Hourly)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '৳${filterProvider.priceRange.start.round()} - ৳${filterProvider.priceRange.end.round()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentTeal,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: filterProvider.priceRange,
                min: 200,
                max: 3500,
                divisions: 33,
                activeColor: AppColors.primaryPurple,
                labels: RangeLabels(
                  '৳${filterProvider.priceRange.start.round()}',
                  '৳${filterProvider.priceRange.end.round()}',
                ),
                onChanged: (values) {
                  filterProvider.setPriceRange(values);
                },
              ),

              const SizedBox(height: 20),

              // 3. Minimum Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Minimum Rating',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.goldAccent, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        filterProvider.minRating == 0.0
                            ? 'Any'
                            : '${filterProvider.minRating}+ Stars',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Slider(
                value: filterProvider.minRating,
                min: 0.0,
                max: 5.0,
                divisions: 10,
                activeColor: AppColors.goldAccent,
                label: '${filterProvider.minRating}',
                onChanged: (val) {
                  filterProvider.setMinRating(val);
                },
              ),

              const SizedBox(height: 20),

              // 4. Surface Type Dropdown
              const Text(
                'Surface Type',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? Colors.white.withOpacity(0.12) : Colors.black12,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: filterProvider.surfaceType,
                    isExpanded: true,
                    items: AppConstants.surfaceTypes.map((surface) {
                      return DropdownMenuItem<String>(
                        value: surface,
                        child: Text(surface),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        filterProvider.setSurfaceType(val);
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 5. Floodlight Switch
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.wb_sunny_rounded, color: AppColors.goldAccent),
                        SizedBox(width: 10),
                        Text(
                          'Floodlights Available',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Switch(
                      value: filterProvider.floodlightsOnly,
                      activeColor: AppColors.primaryPurple,
                      onChanged: (val) {
                        filterProvider.setFloodlightsOnly(val);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Apply Filters Action Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
