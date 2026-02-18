import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';
import '../../services/api.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final Function() onNavigateToLogin;

  const ForgotPasswordScreen({super.key, required this.onNavigateToLogin});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();

  String _error = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (_phoneController.text.trim().isEmpty ||
        _otpController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      setState(() {
        _error = 'All fields are required';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      await AuthAPI.resetPassword({
        'phone': _phoneController.text.trim(),
        'otp': _otpController.text.trim(),
        'newPassword': _passwordController.text,
      });

      if (mounted) {
        widget.onNavigateToLogin();
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.goldLight,
              const Color(0xFFEDD9B8),
              AppColors.gold,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.maroon,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your phone, OTP, and new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: AppColors.muted),
                ),
                const SizedBox(height: 40),
                _buildInput(
                  controller: _phoneController,
                  placeholder: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                _buildInput(
                  controller: _otpController,
                  placeholder: 'OTP Code',
                  icon: Icons.verified_user_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildInput(
                  controller: _passwordController,
                  placeholder: 'New Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                if (_error.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    _error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.danger, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 32),
                PrimaryButton(
                  label: _isLoading ? 'Resetting...' : 'Reset Password',
                  onPress: _handleReset,
                  loading: _isLoading,
                  disabled: _isLoading,
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: widget.onNavigateToLogin,
                  child: Text(
                    'Back to Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.maroon,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderGold, width: 2),
        color: AppColors.surface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.maroon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 16, color: AppColors.maroon),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(color: AppColors.mutedLight),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
