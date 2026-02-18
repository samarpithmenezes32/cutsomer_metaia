import 'package:flutter/material.dart';
import '../theme/colors.dart';

class MetaiaLogo extends StatelessWidget {
  final double size;
  final bool withText; // kept for API compat; PNG scales naturally

  const MetaiaLogo({super.key, this.size = 40, this.withText = true});

  @override
  Widget build(BuildContext context) {
    // Uses the real Metaia logo PNG from assets.
    // withText=true → logo at full height (includes text inside the PNG)
    // withText=false → logo icon only, constrained to [size]
    return Image.asset(
      'assets/logo/metaia_logo.png',
      height: withText ? size * 1.1 : size,
      fit: BoxFit.contain,
      errorBuilder: (ctx, err, st) => _Fallback(size: size, withText: withText),
    );
  }
}

// ── Fallback shown only when the PNG asset fails to load ──────────────────────
class _Fallback extends StatelessWidget {
  final double size;
  final bool withText;
  const _Fallback({required this.size, required this.withText});

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.gold,
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Center(
        child: Text(
          'M',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: size * 0.55,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    if (!withText) return circle;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle,
        const SizedBox(width: 8),
        Text(
          'METAIA',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: size * 0.75,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
