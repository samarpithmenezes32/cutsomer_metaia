import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String selectedCategory = 'Men';

  final List<String> categories = ['Men', 'Women', 'Kids'];

  final Map<String, List<StyleItem>> styleData = {
    'Men': [
      StyleItem(
        name: 'Shirt',
        category: 'Top Wear',
        image:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500',
      ),
      StyleItem(
        name: 'Kurta',
        category: 'Traditional',
        image:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      ),
      StyleItem(
        name: 'Suit',
        category: 'Formal',
        image:
            'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=500',
      ),
    ],
    'Women': [
      StyleItem(
        name: 'Dress',
        category: 'Full Body',
        image:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      ),
      StyleItem(
        name: 'Lehenga',
        category: 'Traditional',
        image:
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=500',
      ),
      StyleItem(
        name: 'Gown',
        category: 'Formal',
        image:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      ),
    ],
    'Kids': [
      StyleItem(
        name: 'Shirt',
        category: 'Formal',
        image:
            'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=500',
      ),
      StyleItem(
        name: 'Dress',
        category: 'Full Body',
        image:
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=500',
      ),
      StyleItem(
        name: 'Kurta',
        category: 'Traditional',
        image:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.goldLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero section with gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.goldLight, AppColors.gold],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'METAIA Tailor',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.maroon,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Icon(Icons.star, color: AppColors.maroon, size: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Crafted fits. Effortless ordering.',
                      style: TextStyle(fontSize: 16, color: AppColors.muted),
                    ),
                    const SizedBox(height: 20),
                    // Primary CTA button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to OrderFlow
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.maroon,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          shadowColor: AppColors.black.withValues(alpha: 0.2),
                        ),
                        child: const Text(
                          'Start an Order',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Choose Category section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.maroon,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: categories.map((category) {
                        final isActive = selectedCategory == category;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.maroon
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isActive
                                        ? AppColors.maroon
                                        : AppColors.borderGold,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  category,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isActive
                                        ? AppColors.white
                                        : AppColors.maroon,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Popular Styles section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        'Popular Styles',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.maroon,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: styleData[selectedCategory]?.length ?? 0,
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        itemBuilder: (context, index) {
                          final item = styleData[selectedCategory]![index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to OrderFlow with category and style
                            },
                            child: Container(
                              width: 200,
                              margin: EdgeInsets.only(
                                right:
                                    index <
                                        (styleData[selectedCategory]!.length -
                                            1)
                                    ? 16
                                    : 0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(alpha: 0.12),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                    child: Image.network(
                                      item.image,
                                      width: 200,
                                      height: 140,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 200,
                                              height: 140,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.image),
                                            );
                                          },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.maroon,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.category,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Why METAIA section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Why METAIA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.maroon,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precision tailoring on demand',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.maroon,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Share your measurements, choose your design, and get stitched by vetted experts.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyleItem {
  final String name;
  final String category;
  final String image;

  StyleItem({required this.name, required this.category, required this.image});
}
