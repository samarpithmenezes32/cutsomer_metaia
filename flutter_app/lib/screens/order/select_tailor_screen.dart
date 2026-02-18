import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../widgets/metaia_logo.dart';

class SelectTailorScreen extends StatefulWidget {
  final String category;
  final String garment;
  final String orderType;

  const SelectTailorScreen({
    super.key,
    required this.category,
    required this.garment,
    required this.orderType,
  });

  @override
  State<SelectTailorScreen> createState() => _SelectTailorScreenState();
}

class _SelectTailorScreenState extends State<SelectTailorScreen> {
  int? _selectedTailor;

  final _tailors = [
    {
      'name': 'Rajesh Kumar',
      'shop': 'Royal Tailors',
      'experience': '15 yrs',
      'specialty': 'Men\'s Formal Wear',
      'rating': 4.8,
      'reviews': 248,
      'priceRange': '₹800 - ₹2000',
      'delivery': '3-5 days',
      'initial': 'R',
      'color': Color(0xFF5C6BC0),
    },
    {
      'name': 'Priya Sharma',
      'shop': 'Elegant Stitches',
      'experience': '12 yrs',
      'specialty': 'Bridal & Party Wear',
      'rating': 4.9,
      'reviews': 312,
      'priceRange': '₹1200 - ₹3000',
      'delivery': '5-7 days',
      'initial': 'P',
      'color': Color(0xFF8B6914),
    },
    {
      'name': 'Mohammed Ali',
      'shop': 'Premium Tailoring',
      'experience': '20 yrs',
      'specialty': 'Suits & Formal Wear',
      'rating': 4.7,
      'reviews': 195,
      'priceRange': '₹1000 - ₹2500',
      'delivery': '4-6 days',
      'initial': 'M',
      'color': Color(0xFF8B6914),
    },
    {
      'name': 'Sunita Devi',
      'shop': 'Ladies Fashion',
      'experience': '10 yrs',
      'specialty': 'Women\'s Ethnic Wear',
      'rating': 4.6,
      'reviews': 178,
      'priceRange': '₹700 - ₹1800',
      'delivery': '3-4 days',
      'initial': 'S',
      'color': Color(0xFF7A1F1F),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Select Tailor',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Choose from available tailors',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _tailors.length,
                          separatorBuilder: (ctx, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final t = _tailors[index];
                            return _TailorCard(
                              tailor: t,
                              isSelected: _selectedTailor == index,
                              onTap: () =>
                                  setState(() => _selectedTailor = index),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _selectedTailor == null
                              ? null
                              : () {
                                  final t = _tailors[_selectedTailor!];
                                  context.go(
                                    '/price-estimation?category=${Uri.encodeComponent(widget.category)}'
                                    '&garment=${Uri.encodeComponent(widget.garment)}'
                                    '&orderType=${Uri.encodeComponent(widget.orderType)}'
                                    '&tailorName=${Uri.encodeComponent(t['name'] as String)}'
                                    '&tailorShop=${Uri.encodeComponent(t['shop'] as String)}'
                                    '&delivery=${Uri.encodeComponent(t['delivery'] as String)}',
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTailor != null
                                ? AppColors.gold
                                : const Color(0xFFB0BEC5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: _selectedTailor != null ? 3 : 0,
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () => context.go(
              '/measurements?category=${Uri.encodeComponent(widget.category)}'
              '&garment=${Uri.encodeComponent(widget.garment)}'
              '&orderType=${Uri.encodeComponent(widget.orderType)}'
              '&fitPreference=Regular',
            ),
          ),
          const Spacer(),
          const MetaiaLogo(size: 36, withText: false),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _TailorCard extends StatelessWidget {
  final Map<String, dynamic> tailor;
  final bool isSelected;
  final VoidCallback onTap;

  const _TailorCard({
    required this.tailor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: tailor['color'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      tailor['initial'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tailor['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tailor['shop'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Experience and specialty
            Row(
              children: [
                _InfoChip(
                  icon: Icons.workspace_premium_outlined,
                  text: tailor['experience'] as String,
                ),
                const SizedBox(width: 8),
                const Text('•', style: TextStyle(color: AppColors.textLight)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tailor['specialty'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.gold, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${tailor['rating']}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${tailor['reviews']} reviews)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 10),
            // Price and delivery
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price Range',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tailor['priceRange'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tailor['delivery'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'View Sample Work >',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.gold),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
