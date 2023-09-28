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
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 38,
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Total(),
            SizedBox(height: 30),
            Flexible(
              child: StockList(),
            ),
          ],
        ),
      ),
    );
  }
}
