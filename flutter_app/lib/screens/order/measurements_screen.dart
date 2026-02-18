import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../widgets/metaia_logo.dart';

class MeasurementsScreen extends StatefulWidget {
  final String category;
  final String garment;
  final String orderType;
  final String fitPreference;

  const MeasurementsScreen({
    super.key,
    required this.category,
    required this.garment,
    required this.orderType,
    required this.fitPreference,
  });

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  bool _tailorAssistance = false;
  String _fitPreference = 'Regular';
  final _controllers = <String, TextEditingController>{};

  List<Map<String, dynamic>> get _requiredFields {
    // Fields depend on garment type
    final garment = widget.garment.toLowerCase();
    if (garment.contains('shirt') ||
        garment.contains('kurta') ||
        garment.contains('blazer') ||
        garment.contains('jacket')) {
      return [
        {'name': 'Chest (inches)', 'key': 'chest'},
        {'name': 'Waist (inches)', 'key': 'waist'},
        {'name': 'Shoulder (inches)', 'key': 'shoulder'},
        {'name': 'Sleeve Length (inches)', 'key': 'sleeve_length'},
        {'name': 'Armhole (inches)', 'key': 'armhole'},
        {'name': 'Shirt Length (inches)', 'key': 'shirt_length'},
        {'name': 'Neck (inches)', 'key': 'neck'},
      ];
    } else if (garment.contains('trouser') ||
        garment.contains('pant') ||
        garment.contains('jeans')) {
      return [
        {'name': 'Waist (inches)', 'key': 'waist'},
        {'name': 'Hip (inches)', 'key': 'hip'},
        {'name': 'Thigh (inches)', 'key': 'thigh'},
        {'name': 'Inseam (inches)', 'key': 'inseam'},
        {'name': 'Length (inches)', 'key': 'length'},
      ];
    }
    return [
      {'name': 'Chest (inches)', 'key': 'chest'},
      {'name': 'Waist (inches)', 'key': 'waist'},
      {'name': 'Shoulder (inches)', 'key': 'shoulder'},
      {'name': 'Length (inches)', 'key': 'length'},
    ];
  }

  final _optionalFields = [
    {'name': 'Bicep (inches)', 'key': 'bicep'},
    {'name': 'Cuff Opening (inches)', 'key': 'cuff'},
  ];

  TextEditingController _getController(String key) {
    _controllers.putIfAbsent(key, () => TextEditingController());
    return _controllers[key]!;
  }

  @override
  void initState() {
    super.initState();
    _fitPreference = widget.fitPreference.isNotEmpty
        ? widget.fitPreference
        : 'Regular';
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final required = _requiredFields;
    final optional = _optionalFields;
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
                        'Measurements',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.category} - ${widget.garment}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Fields count chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.straighten,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${required.length} required + ${optional.length} optional fields',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Measurement Source
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: '+ Add New Measurements',
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primary,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: '+ Add New Measurements',
                                child: Text(
                                  '+ Add New Measurements',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Divider with label
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.border)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'MEASUREMENT FIELDS',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textLight,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Required measurements
                      const Text(
                        '• Required Measurements',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMeasurementGrid(required),
                      const SizedBox(height: 20),
                      // Optional measurements
                      const Text(
                        '• Optional Measurements',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMeasurementGrid(optional),
                      const SizedBox(height: 16),
                      // Fit preference
                      const Text(
                        'Fit Preference',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _fitPreference,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primary,
                            ),
                            items: ['Slim', 'Regular', 'Loose']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _fitPreference = v!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tailor assistance toggle
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Request Tailor Assistance',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Tailor will take measurements at pickup',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _tailorAssistance,
                              onChanged: (v) =>
                                  setState(() => _tailorAssistance = v),
                              activeThumbColor: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Info box
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('⚡', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Your measurements will be saved for future orders. You can update them anytime from your profile.',
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
                      const SizedBox(height: 20),
                      // Save button (outlined)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.save_outlined,
                            color: AppColors.primary,
                          ),
                          label: const Text(
                            'Save for Future Use',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Continue button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(
                              '/select-tailor?category=${Uri.encodeComponent(widget.category)}'
                              '&garment=${Uri.encodeComponent(widget.garment)}'
                              '&orderType=${Uri.encodeComponent(widget.orderType)}',
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
                            'Continue',
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

  Widget _buildMeasurementGrid(List<Map<String, dynamic>> fields) {
    final rows = <Widget>[];
    for (int i = 0; i < fields.length; i += 2) {
      final left = fields[i];
      final right = i + 1 < fields.length ? fields[i + 1] : null;
      rows.add(
        Row(
          children: [
            Expanded(
              child: _MeasurementField(
                label: left['name'] as String,
                controller: _getController(left['key'] as String),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: right != null
                  ? _MeasurementField(
                      label: right['name'] as String,
                      controller: _getController(right['key'] as String),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 10));
    }
    return Column(children: rows);
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () => context.go(
              '/design-requirements?category=${Uri.encodeComponent(widget.category)}'
              '&garment=${Uri.encodeComponent(widget.garment)}'
              '&orderType=${Uri.encodeComponent(widget.orderType)}'
              '&fitPreference=${Uri.encodeComponent(_fitPreference)}',
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

class _MeasurementField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _MeasurementField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.straighten,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(color: AppColors.textLight),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
