import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/widget/base/bottom_navigation.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const SettingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 38,
          horizontal: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final email = state.user?.email;

                return Text(
                  'User Email: $email',
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context.read<AuthBloc>().add(PostSignOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
