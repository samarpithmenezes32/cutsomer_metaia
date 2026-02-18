import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../services/api.dart';

class SplashScreen extends StatefulWidget {
  final Function() onNavigateToAuth;
  final Function() onNavigateToMain;

  const SplashScreen({
    super.key,
    required this.onNavigateToAuth,
    required this.onNavigateToMain,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _dotController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _dotController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    _scaleController.forward();

    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await AuthAPI.initAuthToken();
    final user = await AuthAPI.getCurrentUser();

    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    if (user != null) {
      widget.onNavigateToMain();
    } else {
      widget.onNavigateToAuth();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDark],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with decorative stars
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.maroon,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.3),
                                offset: const Offset(0, 8),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 72,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -8,
                          right: -6,
                          child: Icon(
                            Icons.star,
                            color: AppColors.maroon,
                            size: 24,
                          ),
                        ),
                        Positioned(
                          bottom: -6,
                          left: -4,
                          child: Icon(
                            Icons.star,
                            color: AppColors.maroon,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Title
                    Text(
                      'METAIA',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: AppColors.maroon,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Subtitle
                    Text(
                      'Your Perfect Fit Awaits',
                      style: TextStyle(fontSize: 20, color: AppColors.muted),
                    ),
                    const SizedBox(height: 60),
                    // Loading dots animation
                    AnimatedBuilder(
                      animation: _dotController,
                      builder: (context, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            final delay = index * 0.2;
                            final value = (_dotController.value - delay).clamp(
                              0.0,
                              1.0,
                            );
                            final scale = (value < 0.5
                                ? value * 2
                                : 2 - value * 2);

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.maroon.withValues(alpha: 
                                  0.3 + scale * 0.7,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                    // Trust indicators
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTrustIndicator('10K+', 'Happy\nCustomers'),
                          Container(
                            width: 1,
                            height: 40,
                            color: AppColors.muted.withValues(alpha: 0.3),
                          ),
                          _buildTrustIndicator('500+', 'Expert\nTailors'),
                          Container(
                            width: 1,
                            height: 40,
                            color: AppColors.muted.withValues(alpha: 0.3),
                          ),
                          _buildTrustIndicator('4.8★', 'Rating'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrustIndicator(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.maroon,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: AppColors.muted),
        ),
      ],
    );
  }
}
