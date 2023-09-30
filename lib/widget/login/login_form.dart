import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/widget/base/input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isOpen = false;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        isOpen = true;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(0, isOpen ? 0 : 300, 0),
      padding: const EdgeInsets.only(top: 42, right: 32, bottom: 32, left: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Form(
        onChanged: () {
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            setState(() {
              isValid = true;
            });
          } else {
            setState(() {
              isValid = false;
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Input(
              type: 'email',
              label: 'Email',
              icon: Icons.person,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            Input(
              type: 'password',
              label: 'password',
              icon: Icons.lock,
              controller: passwordController,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: isValid
                    ? () {
                        context.read<AuthBloc>().add(
                              PostSignIn(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  disabledBackgroundColor:
                      Theme.of(context).colorScheme.outline,
                  disabledForegroundColor:
                      Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
