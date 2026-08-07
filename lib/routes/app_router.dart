import 'package:go_router/go_router.dart';

// Splash
import '../features/qr_detection/presentation/screens/qr_detection_page.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

// Dashboard
import '../features/dashboard/presentation/screens/dashboard_screen.dart';

// URL Detection
import '../features/url_detection/presentation/screens/url_detection_screen.dart';

// QR Detection
import '../features/qr_detection/presentation/screens/qr_detection_screen.dart';

// Image Detection
import '../features/image_detection/presentation/screens/image_result_page.dart';

// History
import '../features/history/presentation/screens/history_screen.dart';

// Profile
import '../features/profile/presentation/screens/profile_screen.dart';

// Settings
import '../features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      /// Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      /// Dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      /// URL Detection
      GoRoute(
        path: '/url-detection',
        name: 'urlDetection',
        builder: (context, state) =>const UrlDetectionPage(),
      ),

      /// QR Detection
      GoRoute(
        path: '/qr-detection',
        name: 'qrDetection',
        builder: (context, state) => const QrDetectionPage(),
      ),

      /// Image Detection

      /// History
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),

      /// Profile
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      /// Settings
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}