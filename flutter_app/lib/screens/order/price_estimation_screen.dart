import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../widgets/metaia_logo.dart';

class PriceEstimationScreen extends StatelessWidget {
  final String category;
  final String garment;
  final String orderType;
  final String tailorName;
  final String tailorShop;
  final String delivery;

  const PriceEstimationScreen({
    super.key,
    required this.category,
    required this.garment,
    required this.orderType,
    required this.tailorName,
    required this.tailorShop,
    required this.delivery,
  });

  int get _stitchingCost {
    final g = garment.toLowerCase();
    if (g.contains('lehenga') || g.contains('saree')) return 2500;
    if (g.contains('sherwani') || g.contains('suit')) return 2000;
    if (g.contains('blazer') || g.contains('jacket')) return 1800;
    if (g.contains('kurta')) return 1200;
    if (g.contains('shirt') || g.contains('blouse')) return 1500;
    if (g.contains('trouser') || g.contains('pant')) return 900;
    return 1500;
  }

  int get _pickup => 50;
  int get _deliveryCharge => 50;
  int get _subtotal => _stitchingCost + _pickup + _deliveryCharge;
  double get _tax => _subtotal * 0.18;
  double get _total => _subtotal + _tax;

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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Price Estimation',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Order Summary Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _SummaryRow(
                              label: 'Order Type',
                              value: orderType.replaceAll(' Stitching', ''),
                            ),
                            _SummaryRow(label: 'Tailor', value: tailorName),
                            _SummaryRow(
                              label: 'Delivery Time',
                              value: delivery,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                color: AppColors.divider,
                                height: 1,
                              ),
                            ),
                            _SummaryRow(
                              label: 'Stitching Cost',
                              value: '₹$_stitchingCost',
                            ),
                            const SizedBox(height: 6),
                            _SummaryRow(
                              label: 'Pickup Charge',
                              value: '₹$_pickup',
                            ),
                            const SizedBox(height: 6),
                            _SummaryRow(
                              label: 'Delivery Charge',
                              value: '₹$_deliveryCharge',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                color: AppColors.divider,
                                height: 1,
                              ),
                            ),
                            _SummaryRow(
                              label: 'Subtotal',
                              value: '₹$_subtotal',
                            ),
                            const SizedBox(height: 6),
                            _SummaryRow(
                              label: 'Tax (18% GST)',
                              value: '₹${_tax.toStringAsFixed(2)}',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                color: AppColors.divider,
                                height: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  '₹${_total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Note
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Text('⚡', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'This is an estimated price. Final amount may vary based on fabric quality and additional requirements.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Continue button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(
                              '/place-order?category=${Uri.encodeComponent(category)}'
                              '&garment=${Uri.encodeComponent(garment)}'
                              '&orderType=${Uri.encodeComponent(orderType)}'
                              '&tailorName=${Uri.encodeComponent(tailorName)}'
                              '&tailorShop=${Uri.encodeComponent(tailorShop)}'
                              '&delivery=${Uri.encodeComponent(delivery)}'
                              '&total=${_total.toStringAsFixed(2)}',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          child: const Text(
                            'Continue to Place Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
              '/select-tailor?category=${Uri.encodeComponent(category)}'
              '&garment=${Uri.encodeComponent(garment)}'
              '&orderType=${Uri.encodeComponent(orderType)}',
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
