import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home/welcome_screen.dart';
import 'screens/home/collections_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/home/orders_screen.dart';
import 'screens/home/order_history_screen.dart';
import 'screens/home/reviews_screen.dart';
import 'screens/home/settings_screen.dart';
import 'screens/home/about_screen.dart';
import 'screens/home/help_support_screen.dart';
import 'screens/order/select_order_type_screen.dart';
import 'screens/order/design_requirements_screen.dart';
import 'screens/order/measurements_screen.dart';
import 'screens/order/select_tailor_screen.dart';
import 'screens/order/price_estimation_screen.dart';
import 'screens/order/place_order_screen.dart';
import 'theme/colors.dart';

// Smooth slide+fade page transition used on every route
CustomTransitionPage<void> _slideFade(
  GoRouterState state,
  Widget child, {
  bool fromLeft = false,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );
      final slideAnim = Tween<Offset>(
        begin: fromLeft ? const Offset(-0.08, 0) : const Offset(0.08, 0),
        end: Offset.zero,
      ).animate(curve);
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
        child: SlideTransition(position: slideAnim, child: child),
      );
    },
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/welcome',
      routes: [
        GoRoute(
          path: '/welcome',
          pageBuilder: (context, state) =>
              _slideFade(state, const WelcomeScreen(), fromLeft: true),
        ),
        GoRoute(
          path: '/collections',
          pageBuilder: (context, state) {
            final category = state.uri.queryParameters['category'] ?? 'Men';
            return _slideFade(state, CollectionsScreen(category: category));
          },
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              _slideFade(state, const ProfileScreen()),
        ),
        GoRoute(
          path: '/order-type',
          pageBuilder: (context, state) {
            final category = state.uri.queryParameters['category'] ?? 'Men';
            final garment = state.uri.queryParameters['garment'] ?? 'Shirt';
            return _slideFade(
              state,
              SelectOrderTypeScreen(category: category, garment: garment),
            );
          },
        ),
        GoRoute(
          path: '/design-requirements',
          pageBuilder: (context, state) {
            final category = state.uri.queryParameters['category'] ?? 'Men';
            final garment = state.uri.queryParameters['garment'] ?? 'Shirt';
            final orderType =
                state.uri.queryParameters['orderType'] ?? 'Fresh Stitching';
            return _slideFade(
              state,
              DesignRequirementsScreen(
                category: category,
                garment: garment,
                orderType: orderType,
              ),
            );
          },
        ),
        GoRoute(
          path: '/measurements',
          pageBuilder: (context, state) {
            final category = state.uri.queryParameters['category'] ?? 'Men';
            final garment = state.uri.queryParameters['garment'] ?? 'Shirt';
            final orderType =
                state.uri.queryParameters['orderType'] ?? 'Fresh Stitching';
            final fitPreference =
                state.uri.queryParameters['fitPreference'] ?? 'Regular';
            return _slideFade(
              state,
              MeasurementsScreen(
                category: category,
                garment: garment,
                orderType: orderType,
                fitPreference: fitPreference,
              ),
            );
          },
        ),
        GoRoute(
          path: '/select-tailor',
          pageBuilder: (context, state) {
            final category = state.uri.queryParameters['category'] ?? 'Men';
            final garment = state.uri.queryParameters['garment'] ?? 'Shirt';
            final orderType =
                state.uri.queryParameters['orderType'] ?? 'Fresh Stitching';
            return _slideFade(
              state,
              SelectTailorScreen(
                category: category,
                garment: garment,
                orderType: orderType,
              ),
            );
          },
        ),
        GoRoute(
          path: '/price-estimation',
          pageBuilder: (context, state) {
            final p = state.uri.queryParameters;
            return _slideFade(
              state,
              PriceEstimationScreen(
                category: p['category'] ?? 'Men',
                garment: p['garment'] ?? 'Shirt',
                orderType: p['orderType'] ?? 'Fresh Stitching',
                tailorName: p['tailorName'] ?? '',
                tailorShop: p['tailorShop'] ?? '',
                delivery: p['delivery'] ?? '',
              ),
            );
          },
        ),
        GoRoute(
          path: '/place-order',
          pageBuilder: (context, state) {
            final p = state.uri.queryParameters;
            return _slideFade(
              state,
              PlaceOrderScreen(
                category: p['category'] ?? 'Men',
                garment: p['garment'] ?? 'Shirt',
                orderType: p['orderType'] ?? 'Fresh Stitching',
                tailorName: p['tailorName'] ?? '',
                tailorShop: p['tailorShop'] ?? '',
                delivery: p['delivery'] ?? '',
                total: p['total'] ?? '0.00',
              ),
            );
          },
        ),
        GoRoute(
          path: '/orders',
          pageBuilder: (context, state) =>
              _slideFade(state, const OrdersScreen()),
        ),
        GoRoute(
          path: '/order-history',
          pageBuilder: (context, state) =>
              _slideFade(state, const OrderHistoryScreen()),
        ),
        GoRoute(
          path: '/reviews',
          pageBuilder: (context, state) =>
              _slideFade(state, const ReviewsScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) =>
              _slideFade(state, const SettingsScreen()),
        ),
        GoRoute(
          path: '/help-support',
          pageBuilder: (context, state) =>
              _slideFade(state, const HelpSupportScreen()),
        ),
        GoRoute(
          path: '/about',
          pageBuilder: (context, state) =>
              _slideFade(state, const AboutScreen()),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'METAIA',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.gold,
        ),
        fontFamily: 'Roboto',
        splashFactory: InkRipple.splashFactory,
        highlightColor: AppColors.gold.withValues(alpha: 0.08),
        splashColor: AppColors.primary.withValues(alpha: 0.08),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
