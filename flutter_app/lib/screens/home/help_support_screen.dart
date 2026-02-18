import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../widgets/metaia_logo.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAF0DC), Color(0xFFEDD69A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded,
                          color: AppColors.primary),
                      onPressed: () => context.go('/welcome'),
                    ),
                    const Spacer(),
                    const MetaiaLogo(size: 32, withText: true),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFD4AF37)),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SupportCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Chat with Us',
                      subtitle: 'Get instant help from our support team',
                      onTap: () {},
                    ),
                    _SupportCard(
                      icon: Icons.email_outlined,
                      title: 'Email Support',
                      subtitle: 'support@metaia.com',
                      onTap: () {},
                    ),
                    _SupportCard(
                      icon: Icons.phone_outlined,
                      title: 'Call Us',
                      subtitle: '+91 98765 43210',
                      onTap: () {},
                    ),
                    _SupportCard(
                      icon: Icons.help_outline_rounded,
                      title: 'FAQs',
                      subtitle: 'Find answers to common questions',
                      onTap: () {},
                    ),
                    _SupportCard(
                      icon: Icons.policy_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'How we protect your data',
                      onTap: () {},
                    ),
                    _SupportCard(
                      icon: Icons.description_outlined,
                      title: 'Terms of Service',
                      subtitle: 'Our terms and conditions',
                      onTap: () {},
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

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD4AF37), Color(0xFFA0791A)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF7A1F1F),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 14, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }
}
