import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/analysis/view/analysis_history_screen.dart';
import 'package:how_much/analysis/view/product_analysis_screen.dart';
import 'package:how_much/auth/view/profile_screen.dart';
import 'package:how_much/common/component/error_snack_bar.dart';
import 'package:how_much/common/layout/default_layout.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listenError(context);

    return DefaultLayout(
      showAppBar: false,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(), // 스크롤 방지
            controller: _tabController,
            children: [
              const ProductAnalysisScreen(),
              const AnalysisHistoryScreen(),
              const ProfileScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) => _tabController.animateTo(index),
            backgroundColor: Colors.transparent,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: '홈',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.history),
                icon: Icon(Icons.history_outlined),
                label: '히스토리',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: '마이',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
