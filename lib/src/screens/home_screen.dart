import 'package:flutter/material.dart';
import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/src/schemes/trade_scheme.dart';
import 'package:raccoon_investment/src/utils/trade_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  List<Trade> trades = [];

  @override
  void initState() {
    super.initState();

    _getGroups();
  }

  Future<void> _getGroups() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Trade> trades = await supabase.from("trades").select("*");

      getTotalStock(trades);

      setState(() {
        trades = trades;
      });
    } on PostgrestException catch (error) {
      if (!mounted) return;

      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      if (!mounted) return;

      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 12,
              ),
              children: trades.map((e) => Text(e.text ?? "")).toList(),
            ),
    );
  }
}
