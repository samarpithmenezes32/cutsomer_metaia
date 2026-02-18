import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';

class CollectionsScreen extends StatelessWidget {
  final String category;

  const CollectionsScreen({super.key, required this.category});

  List<Map<String, String>> _getCollectionItems() {
    switch (category) {
      case 'Men':
        return const [
          {'name': 'Shirt', 'image': 'assets/mens/shirt.jpg'},
          {'name': 'T-Shirt', 'image': 'assets/mens/tshirt.jpg'},
          {'name': 'Kurta', 'image': 'assets/mens/kurta.jpg'},
          {'name': 'Jacket', 'image': 'assets/mens/jacket.jpg'},
          {'name': 'Blazer', 'image': 'assets/mens/blazer.jpg'},
          {'name': 'Waistcoat', 'image': 'assets/mens/waistcoat.jpg'},
          {'name': 'Trouser / Pant', 'image': 'assets/mens/trouser.jpg'},
          {'name': 'Jeans', 'image': 'assets/mens/jeans.jpg'},
          {'name': 'Kurta-Pyjama', 'image': 'assets/mens/kurta_pyjama.jpg'},
        ];
      case 'Women':
        return const [
          {'name': 'Blouse', 'image': 'assets/womens/blouse.jpg'},
          {'name': 'Kurti', 'image': 'assets/womens/kurti.jpg'},
          {'name': 'Top', 'image': 'assets/womens/top.jpg'},
          {'name': 'Tunic', 'image': 'assets/womens/tunic.jpg'},
          {'name': 'Shirt', 'image': 'assets/womens/shirt.jpg'},
          {'name': 'Jacket', 'image': 'assets/womens/jacket.jpg'},
          {'name': 'Leggings', 'image': 'assets/womens/leggings.jpg'},
          {'name': 'Pants', 'image': 'assets/womens/pants.jpg'},
          {'name': 'Palazzo', 'image': 'assets/womens/palazzo.jpg'},
          {'name': 'Skirt', 'image': 'assets/womens/skirt.jpg'},
          {'name': 'Salwar', 'image': 'assets/womens/salwar.jpg'},
          {'name': 'Salwar Kameez', 'image': 'assets/womens/salwar_kameez.jpg'},
          {'name': 'Anarkali', 'image': 'assets/womens/anarkali.jpg'},
          {'name': 'Lehenga Choli', 'image': 'assets/womens/lehenga_choli.jpg'},
          {'name': 'Dress', 'image': 'assets/womens/dress.jpg'},
        ];
      case 'Kids':
        return const [
          {'name': 'Shirt', 'image': 'assets/kids/shirt.jpg'},
          {'name': 'T-Shirt', 'image': 'assets/kids/tshirt.jpg'},
          {'name': 'Kurta', 'image': 'assets/kids/kurta.jpg'},
          {'name': 'Top', 'image': 'assets/kids/top.jpg'},
          {'name': 'Pants', 'image': 'assets/kids/pants.jpg'},
          {'name': 'Shorts', 'image': 'assets/kids/shorts.jpg'},
          {'name': 'Ethnic Set', 'image': 'assets/kids/ethnic_set.jpg'},
          {'name': 'Sherwani', 'image': 'assets/kids/sherwani.jpg'},
          {'name': 'Lehenga', 'image': 'assets/kids/lehenga.jpg'},
          {'name': 'Ghagra', 'image': 'assets/kids/ghagra.jpg'},
          {'name': 'Suit', 'image': 'assets/kids/suit.jpg'},
          {'name': 'Dress', 'image': 'assets/kids/dress.jpg'},
          {'name': 'Gown', 'image': 'assets/kids/gown.jpg'},
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _getCollectionItems();

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
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primary,
                      ),
                      onPressed: () => context.go('/welcome'),
                    ),
                    const Spacer(),
                    Text(
                      "$category's Collection",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: AppColors.gold,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(
                      name: items[index]['name']!,
                      imagePath: items[index]['image']!,
                      category: category,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String category;

  const _ProductCard({
    required this.name,
    required this.imagePath,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
          '/order-type?category=$category&garment=${Uri.encodeComponent(name)}',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: AppColors.textLight,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
