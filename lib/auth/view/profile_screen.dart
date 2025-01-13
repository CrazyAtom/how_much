import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/auth/provider/auth_provider.dart';
import 'package:how_much/common/component/card/custom_card.dart';
import 'package:how_much/common/layout/default_layout.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return DefaultLayout(
      child: authState.when(
        data: (user) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              CustomCard(
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          user?.displayName.substring(0, 1).toUpperCase() ??
                              'A',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.displayName ?? '게스트',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (user?.isAnonymous ?? false)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '게스트 계정',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomCard(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('계정 정보'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: 계정 정보 화면으로 이동
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('알림 설정'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: 알림 설정 화면으로 이동
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('앱 정보'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: 앱 정보 화면으로 이동
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
        error: (error, _) => Center(
          child: Text(
            '오류가 발생했습니다: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
