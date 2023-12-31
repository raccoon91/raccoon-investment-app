import 'package:flutter/material.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';

class Layout extends StatelessWidget {
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget child;

  const Layout({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}
