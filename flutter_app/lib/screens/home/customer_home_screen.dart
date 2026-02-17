import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String selectedCategory = 'Men';

  final categories = ['Men', 'Women', 'Kids'];

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
      body: Container(
        color: const Color(0xFFF5E6D3), // goldLight
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF5E6D3), // goldLight
                        Color(0xFFD4AF37), // gold
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'METAIA Tailor',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7A1F1F), // maroon
                              letterSpacing: 0.5,
                            ),
                          ),
                          Icon(
                            FeatherIcons.star,
                            color: const Color(0xFF7A1F1F), // maroon
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Crafted fits. Effortless ordering.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B6B6B), // muted
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to order flow
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7A1F1F), // maroon
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Start an Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Choose Category Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7A1F1F), // maroon
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: categories.map((category) {
                          bool isSelected = selectedCategory == category;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF7A1F1F)
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF7A1F1F)
                                          : const Color(0xFFE8D4A8),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF7A1F1F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
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

                const SizedBox(height: 28),

                // Popular Styles Section
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Popular Styles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7A1F1F), // maroon
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: styleData[selectedCategory]?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = styleData[selectedCategory]![index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
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
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF7A1F1F), // maroon
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.category,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B6B6B), // muted
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

                const SizedBox(height: 28),

                // Why METAIA Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why METAIA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7A1F1F), // maroon
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Precision tailoring on demand',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7A1F1F), // maroon
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Share your measurements, choose your design, and get stitched by vetted experts.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B6B6B), // muted
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
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
