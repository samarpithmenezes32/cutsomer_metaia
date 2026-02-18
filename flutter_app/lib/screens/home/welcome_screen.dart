import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA — asset paths match assets/garments/{men|women|kids}/*.jpg
// ─────────────────────────────────────────────────────────────────────────────
class _GarmentItem {
  final String name;
  final String? assetPath;
  final IconData fallbackIcon;
  const _GarmentItem(this.name, {this.assetPath, required this.fallbackIcon});
}

const _menItems = [
  _GarmentItem(
    'Shirt',
    assetPath: 'assets/garments/men/shirt.jpg',
    fallbackIcon: Icons.dry_cleaning_outlined,
  ),
  _GarmentItem(
    'Kurta',
    assetPath: 'assets/garments/men/kurta.jpg',
    fallbackIcon: Icons.style_outlined,
  ),
  _GarmentItem(
    'Blazer',
    assetPath: 'assets/garments/men/blazer.jpg',
    fallbackIcon: Icons.work_outline,
  ),
  _GarmentItem(
    'Trouser / Pant',
    assetPath: 'assets/garments/men/trouser.jpg',
    fallbackIcon: Icons.straighten_outlined,
  ),
  _GarmentItem(
    'Kurta-Pyjama',
    assetPath: 'assets/garments/men/kurta_pyjama.jpg',
    fallbackIcon: Icons.style,
  ),
  _GarmentItem(
    'Pathani Suit',
    assetPath: 'assets/garments/men/pathani_suit.jpg',
    fallbackIcon: Icons.dry_cleaning,
  ),
  _GarmentItem(
    'Sherwani',
    assetPath: 'assets/garments/men/sherwani.jpg',
    fallbackIcon: Icons.diamond_outlined,
  ),
  _GarmentItem('Waistcoat', fallbackIcon: Icons.layers_outlined),
  _GarmentItem('Jacket', fallbackIcon: Icons.checkroom_outlined),
  _GarmentItem('2-Piece Suit', fallbackIcon: Icons.business_center_outlined),
];

const _womenItems = [
  _GarmentItem(
    'Blouse',
    assetPath: 'assets/garments/women/blouse.jpg',
    fallbackIcon: Icons.dry_cleaning_outlined,
  ),
  _GarmentItem(
    'Kurti',
    assetPath: 'assets/garments/women/kurti.jpg',
    fallbackIcon: Icons.style_outlined,
  ),
  _GarmentItem(
    'Salwar',
    assetPath: 'assets/garments/women/salwar.jpg',
    fallbackIcon: Icons.straighten_outlined,
  ),
  _GarmentItem(
    'Anarkali',
    assetPath: 'assets/garments/women/anarkali.jpg',
    fallbackIcon: Icons.diamond_outlined,
  ),
  _GarmentItem(
    'Lehenga Choli',
    assetPath: 'assets/garments/women/lehenga_choli.jpg',
    fallbackIcon: Icons.auto_awesome_outlined,
  ),
  _GarmentItem(
    'Dress',
    assetPath: 'assets/garments/women/dress.jpg',
    fallbackIcon: Icons.checkroom_outlined,
  ),
  _GarmentItem(
    'Gown',
    assetPath: 'assets/garments/women/gown.jpg',
    fallbackIcon: Icons.star_outline,
  ),
  _GarmentItem(
    'Tunic',
    assetPath: 'assets/garments/women/tunic.jpg',
    fallbackIcon: Icons.layers_outlined,
  ),
  _GarmentItem(
    'Shirt',
    assetPath: 'assets/garments/women/shirt.jpg',
    fallbackIcon: Icons.dry_cleaning,
  ),
  _GarmentItem(
    'Co-ord Set',
    assetPath: 'assets/garments/women/coord_set.jpg',
    fallbackIcon: Icons.grid_view_outlined,
  ),
  _GarmentItem(
    'Skirt',
    assetPath: 'assets/garments/women/skirt.jpg',
    fallbackIcon: Icons.style,
  ),
  _GarmentItem(
    'Jumpsuit',
    assetPath: 'assets/garments/women/jumpsuit.jpg',
    fallbackIcon: Icons.person_outline,
  ),
  _GarmentItem(
    'Suit',
    assetPath: 'assets/garments/women/suit.jpg',
    fallbackIcon: Icons.business_center_outlined,
  ),
  _GarmentItem(
    'Pants',
    assetPath: 'assets/garments/women/pants.jpg',
    fallbackIcon: Icons.straighten,
  ),
];

const _kidsItems = [
  _GarmentItem(
    'Shirt',
    assetPath: 'assets/garments/kids/shirt.jpg',
    fallbackIcon: Icons.dry_cleaning_outlined,
  ),
  _GarmentItem(
    'Kurta',
    assetPath: 'assets/garments/kids/kurta.jpg',
    fallbackIcon: Icons.style_outlined,
  ),
  _GarmentItem(
    'Dress',
    assetPath: 'assets/garments/kids/dress.jpg',
    fallbackIcon: Icons.checkroom_outlined,
  ),
  _GarmentItem(
    'Ethnic Set',
    assetPath: 'assets/garments/kids/ethnic_set.jpg',
    fallbackIcon: Icons.auto_awesome_outlined,
  ),
  _GarmentItem(
    'Pants',
    assetPath: 'assets/garments/kids/pants.jpg',
    fallbackIcon: Icons.straighten_outlined,
  ),
  _GarmentItem(
    'Shorts',
    assetPath: 'assets/garments/kids/shorts.jpg',
    fallbackIcon: Icons.straighten,
  ),
  _GarmentItem(
    'Gown',
    assetPath: 'assets/garments/kids/gown.jpg',
    fallbackIcon: Icons.star_outline,
  ),
  _GarmentItem(
    'Ghagra',
    assetPath: 'assets/garments/kids/ghagra.jpg',
    fallbackIcon: Icons.diamond_outlined,
  ),
  _GarmentItem(
    'Skirt',
    assetPath: 'assets/garments/kids/skirt.jpg',
    fallbackIcon: Icons.style,
  ),
  _GarmentItem(
    'Suit',
    assetPath: 'assets/garments/kids/suit.jpg',
    fallbackIcon: Icons.business_center_outlined,
  ),
];

const _categories = ['Men', 'Women', 'Kids'];

// ─────────────────────────────────────────────────────────────────────────────
// WELCOME SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _tabSlideCtrl;
  late Animation<double> _tabSlide;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  late AnimationController _drawerCtrl;
  late Animation<double> _drawerAnim;
  bool _drawerOpen = false;

  List<_GarmentItem> get _items {
    switch (_selectedIndex) {
      case 1:
        return _womenItems;
      case 2:
        return _kidsItems;
      default:
        return _menItems;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabSlideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _tabSlide = CurvedAnimation(
      parent: _tabSlideCtrl,
      curve: Curves.easeInOutCubic,
    );

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: 1.0,
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    _drawerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    );
    _drawerAnim = CurvedAnimation(
      parent: _drawerCtrl,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _tabSlideCtrl.dispose();
    _fadeCtrl.dispose();
    _drawerCtrl.dispose();
    super.dispose();
  }

  void _selectCategory(int i) {
    if (i == _selectedIndex) return;
    HapticFeedback.selectionClick();
    final target = i / (_categories.length - 1);
    _fadeCtrl.reverse().then((_) {
      if (!mounted) return;
      setState(() => _selectedIndex = i);
      _fadeCtrl.forward();
    });
    _tabSlideCtrl.animateTo(
      target,
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 360),
    );
  }

  void _openDrawer() {
    setState(() => _drawerOpen = true);
    _drawerCtrl.forward();
    HapticFeedback.lightImpact();
  }

  void _closeDrawer() {
    _drawerCtrl.reverse().then((_) {
      if (mounted) setState(() => _drawerOpen = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8EDD8),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFAF0DC),
                    Color(0xFFF0D898),
                    Color(0xFFD4A84B),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  _buildHeroBrand(),
                  const SizedBox(height: 12),
                  _buildTabBar(w),
                  const SizedBox(height: 12),
                  _buildCollectionHeader(),
                  const SizedBox(height: 8),
                  Expanded(child: _buildGrid()),
                ],
              ),
            ),
            // Drawer overlay
            if (_drawerOpen) ...[
              GestureDetector(
                onTap: _closeDrawer,
                child: AnimatedBuilder(
                  animation: _drawerAnim,
                  builder: (ctx, _) => Container(
                    color: Colors.black.withValues(
                      alpha: 0.5 * _drawerAnim.value,
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _drawerAnim,
                builder: (_, child) => Positioned(
                  left: -w * 0.84 * (1 - _drawerAnim.value),
                  top: 0,
                  bottom: 0,
                  width: w * 0.84,
                  child: child!,
                ),
                child: _LuxuryDrawer(onClose: _closeDrawer, navCtx: context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Top bar with Metaia logo PNG
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
      child: Row(
        children: [
          _AnimatedIconBtn(icon: Icons.menu_rounded, onTap: _openDrawer),
          const Spacer(),
          Hero(
            tag: 'metaia_logo',
            child: Image.asset(
              'assets/logo/metaia_logo.png',
              height: 36,
              errorBuilder: (ctx, err, st) => const _FallbackLogo(),
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _AnimatedIconBtn(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hero brand card
  Widget _buildHeroBrand() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.gold.withValues(alpha: 0.35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4A84B).withValues(alpha: 0.18),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFF8B6914)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.content_cut_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Royal Tailoring',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Crafted to perfection — your style, our artistry.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'PREMIUM',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sliding tab bar
  Widget _buildTabBar(double screenW) {
    final tabW = (screenW - 32) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.65),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _tabSlide,
              builder: (ctx, _) => Positioned(
                left: _tabSlide.value * 2 * tabW + 3,
                top: 3,
                bottom: 3,
                width: tabW - 6,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5A0F0F), Color(0xFF9E2020)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: List.generate(3, (i) {
                final sel = _selectedIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _selectCategory(i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          i == 0
                              ? Icons.person_rounded
                              : i == 1
                              ? Icons.face_retouching_natural
                              : Icons.child_care_rounded,
                          size: 15,
                          color: sel
                              ? Colors.white
                              : AppColors.primary.withValues(alpha: 0.7),
                        ),
                        const SizedBox(height: 2),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 180),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                            color: sel
                                ? Colors.white
                                : AppColors.primary.withValues(alpha: 0.7),
                          ),
                          child: Text(_categories[i]),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.12, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
            ),
            child: Text(
              "${_categories[_selectedIndex]}'s Collection",
              key: ValueKey(_selectedIndex),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: -0.3,
              ),
            ),
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Text(
              '${_items.length} styles',
              key: ValueKey(_selectedIndex),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final items = _items;
    return FadeTransition(
      opacity: _fadeAnim,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.72,
        ),
        itemCount: items.length + 1,
        itemBuilder: (ctx, idx) {
          if (idx == items.length) return _buildBanner(ctx);
          return _GarmentCard(
            item: items[idx],
            category: _categories[_selectedIndex],
            delay: Duration(milliseconds: (idx % 9) * 35),
          );
        },
      ),
    );
  }

  Widget _buildBanner(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        ctx.go(
          '/collections?category=${Uri.encodeComponent(_categories[_selectedIndex])}',
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A0808), Color(0xFF7A1F1F), Color(0xFF9E2020)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'EXCLUSIVE',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w800,
                color: AppColors.gold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'View All',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D2000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GARMENT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _GarmentCard extends StatefulWidget {
  final _GarmentItem item;
  final String category;
  final Duration delay;
  const _GarmentCard({
    required this.item,
    required this.category,
    required this.delay,
  });
  @override
  State<_GarmentCard> createState() => _GarmentCardState();
}

class _GarmentCardState extends State<_GarmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _scaleAnim = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutBack),
    );
    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    Future.delayed(widget.delay, () {
      if (mounted) _entranceCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            HapticFeedback.lightImpact();
            context.go(
              '/order-type'
              '?category=${Uri.encodeComponent(widget.category)}'
              '&garment=${Uri.encodeComponent(widget.item.name)}',
            );
          },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.91 : 1.0,
            duration: const Duration(milliseconds: 110),
            curve: Curves.easeOut,
            child: _buildCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _pressed
              ? AppColors.gold.withValues(alpha: 0.7)
              : Colors.white.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _pressed
                ? AppColors.primary.withValues(alpha: 0.16)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: _pressed ? 16 : 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 7,
            child: widget.item.assetPath != null
                ? Image.asset(
                    widget.item.assetPath!,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => _iconFallback(),
                  )
                : _iconFallback(),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Text(
              widget.item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconFallback() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFDF3E0), Color(0xFFEDD080)],
        ),
      ),
      child: Center(
        child: Icon(
          widget.item.fallbackIcon,
          color: AppColors.primary.withValues(alpha: 0.6),
          size: 36,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED ICON BUTTON (top bar)
// ─────────────────────────────────────────────────────────────────────────────
class _AnimatedIconBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _AnimatedIconBtn({required this.icon, required this.onTap});
  @override
  State<_AnimatedIconBtn> createState() => _AnimatedIconBtnState();
}

class _AnimatedIconBtnState extends State<_AnimatedIconBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(widget.icon, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FALLBACK LOGO TEXT WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.gold, Color(0xFF8B6914)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text(
              'M',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          'METAIA',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 15,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LUXURY SIDE DRAWER
// ─────────────────────────────────────────────────────────────────────────────
class _LuxuryDrawer extends StatelessWidget {
  final VoidCallback onClose;
  final BuildContext navCtx;
  const _LuxuryDrawer({required this.onClose, required this.navCtx});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAF0DC), Color(0xFFEDD69A)],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                child: Row(
                  children: [
                    Hero(
                      tag: 'metaia_logo_drawer',
                      child: Image.asset(
                        'assets/logo/metaia_logo.png',
                        height: 30,
                        errorBuilder: (ctx, err, st) => const _FallbackLogo(),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onClose,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Gold divider
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.gold.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Profile card
              _buildProfileCard(),
              const SizedBox(height: 10),
              // Contact card
              _buildContactCard(),
              const SizedBox(height: 10),
              // Orders card
              _buildOrdersCard(),
              const SizedBox(height: 14),
              // MENU label
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Menu items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      _DrawerItem(
                        icon: Icons.person_outline_rounded,
                        label: 'My Profile',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/profile'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.shopping_bag_outlined,
                        label: 'My Orders',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/orders'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.history_rounded,
                        label: 'Order History',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/order-history'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.star_border_rounded,
                        label: 'My Reviews',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/reviews'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/settings'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.help_outline_rounded,
                        label: 'Help & Support',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/help-support'),
                          );
                        },
                      ),
                      _DrawerItem(
                        icon: Icons.info_outline_rounded,
                        label: 'About METAIA',
                        onTap: () {
                          final router = GoRouter.of(navCtx);
                          onClose();
                          Future.delayed(
                            const Duration(milliseconds: 320),
                            () => router.go('/about'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Logout
              _buildLogoutBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.gold, Color(0xFF8B6914)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Priya Sharma',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Member since Jan 2024',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _ContactRow(icon: Icons.phone_outlined, text: '+91 98765 43210'),
            const Divider(height: 12, color: Color(0xFFE8DCC8)),
            _ContactRow(
              icon: Icons.email_outlined,
              text: 'priya.sharma@email.com',
            ),
            const Divider(height: 12, color: Color(0xFFE8DCC8)),
            _ContactRow(
              icon: Icons.location_on_outlined,
              text: '123 MG Road, Bangalore',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A0808), Color(0xFF7A1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Total Orders',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '12',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: AppColors.gold,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A0808), Color(0xFF7A1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.logout_rounded, color: Colors.white, size: 19),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _DrawerItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Color?> _bg;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _bg = ColorTween(
      begin: Colors.white.withValues(alpha: 0.65),
      end: AppColors.surfaceLight,
    ).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _bg,
        builder: (ctx, _) => Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _bg.value,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: AppColors.gold, size: 18),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
