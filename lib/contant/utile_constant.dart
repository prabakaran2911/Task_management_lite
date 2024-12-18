class AppConstants {
  // Colors
  static const int primaryColorValue = 0xFF2196F3;
  static const int secondaryColorValue = 0xFF1976D2;

  // Task Priorities
  static const List<String> taskPriorities = ['low', 'medium', 'high'];

  // Validation
  static const int minPasswordLength = 6;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';

  // Storage Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String userPreferencesKey = 'user_preferences';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String tasksCollection = 'tasks';
  static const String analyticsCollection = 'analytics';

  // Error Messages
  static const String generalError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String authError = 'Authentication failed. Please try again.';

  // Success Messages
  static const String taskCreated = 'Task created successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted successfully';

  // Navigation
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String taskDetailRoute = '/task-detail';
  static const String taskFormRoute = '/task-form';
}
