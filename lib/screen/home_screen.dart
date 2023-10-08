import 'package:flutter/material.dart';
import 'package:raccoon_investment/widget/base/layout.dart';
import 'package:raccoon_investment/widget/home/group_list.dart';
import 'package:raccoon_investment/widget/home/stock_list.dart';
import 'package:raccoon_investment/widget/home/total.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Total(),
          SizedBox(height: 12),
          StockList(),
          GroupList(),
        ],
      ),
    );
  }
}
