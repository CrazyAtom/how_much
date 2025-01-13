import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/auth/provider/auth_provider.dart';
import 'package:how_much/common/component/error_snack_bar.dart';
import 'package:how_much/common/layout/default_layout.dart';

class LoginScreen extends ConsumerWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenError(context);

    return DefaultLayout(
      showAppBar: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const _WelcomeSection(),
              const Spacer(),
              const _LoginButtons(),
              const SizedBox(height: 32),
              const _TermsAndPolicy(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'asset/images/logo/logo.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 24),
        Text(
          '하머',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '얼마까지 알아 보셨어요?',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}

class _LoginButtons extends ConsumerWidget {
  const _LoginButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SocialLoginButton(
          onPressed: () {
            // Google 로그인 구현 예정
          },
          icon: Icons.g_mobiledata,
          label: 'Google로 계속하기',
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          borderColor: Colors.grey[300]!,
        ),
        if (Platform.isIOS || Platform.isMacOS) ...[
          const SizedBox(height: 12),
          _SocialLoginButton(
            onPressed: () {
              // Apple 로그인 구현 예정
            },
            icon: Icons.apple,
            label: 'Apple로 계속하기',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          ),
        ],
        const SizedBox(height: 12),
        _SocialLoginButton(
          onPressed: () {
            ref.read(authProvider.notifier).signInAnonymously();
          },
          icon: Icons.person_outline,
          label: '게스트로 시작하기',
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const _SocialLoginButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsAndPolicy extends StatelessWidget {
  const _TermsAndPolicy();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        );
    final linkStyle = textStyle?.copyWith(
      decoration: TextDecoration.underline,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: [
        Text('로그인함으로써', style: textStyle),
        Text('서비스 이용약관', style: linkStyle),
        Text('및', style: textStyle),
        Text('개인정보 처리방침', style: linkStyle),
        Text('에 동의합니다', style: textStyle),
      ],
    );
  }
}
