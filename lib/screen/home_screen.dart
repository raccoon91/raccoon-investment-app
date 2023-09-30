import 'package:flutter/material.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';
import 'package:raccoon_investment/widget/home/stock_list.dart';
import 'package:raccoon_investment/widget/home/total.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Total(),
            SizedBox(height: 12),
            StockList(),
          ],
        ),
      ),
    );
  }
}
