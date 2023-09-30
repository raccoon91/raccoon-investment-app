import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/widget/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcom Back !',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.status.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return const LoginForm();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
