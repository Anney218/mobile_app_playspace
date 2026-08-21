class UserPreferences {
  final bool isDarkMode;
  final List<String> favoriteTurfIds;

  const UserPreferences({
    this.isDarkMode = false,
    this.favoriteTurfIds = const [],
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      favoriteTurfIds: json['favoriteTurfIds'] != null
          ? List<String>.from(json['favoriteTurfIds'] as List)
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'favoriteTurfIds': favoriteTurfIds,
    };
  }

  UserPreferences copyWith({
    bool? isDarkMode,
    List<String>? favoriteTurfIds,
  }) {
    return UserPreferences(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      favoriteTurfIds: favoriteTurfIds ?? this.favoriteTurfIds,
    );
  }
}
