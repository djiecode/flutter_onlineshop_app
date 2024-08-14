import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/data/models/requests/register_request.dart';
import 'package:flutter_onlineshop_app/persentation/auth/bloc/register/register_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _onRegisterButtonPressed() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    final registerRequest = RegisterRequest(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
    );

    context.read<RegisterBloc>().add(RegisterEvent.register(registerRequest));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loading: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registering...')),
                );
              },
              loaded: (data) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration Successful!')),
                );
                context.goNamed(RouteConstants.root);
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
            );
          },
          child: ListView(
            children: [
              const Text(
                'Register Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Hello, please complete the data below to register a new account',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(50.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.home.svg(),
                  ),
                ),
              ),
              const SpaceHeight(20.0),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.home.svg(),
                  ),
                ),
              ),
              const SpaceHeight(20.0),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.email.svg(),
                  ),
                ),
              ),
              const SpaceHeight(20.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.password.svg(),
                  ),
                ),
              ),
              const SpaceHeight(20.0),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Assets.icons.password.svg(),
                  ),
                ),
              ),
              const SpaceHeight(50.0),
              Button.filled(
                onPressed: () {
                  _onRegisterButtonPressed();
                  Future.delayed(const Duration(seconds: 9), () {
                    context.goNamed(RouteConstants.login);
                  });
                },
                label: 'Register',
              ),
              const SpaceHeight(50.0),
              const Row(
                children: [
                  Flexible(child: Divider()),
                  SizedBox(width: 14.0),
                  Text('OR'),
                  SizedBox(width: 14.0),
                  Flexible(child: Divider()),
                ],
              ),
              const SpaceHeight(50.0),
              Button.outlined(
                onPressed: () {},
                label: 'Register with Google',
                icon: Assets.images.google.image(height: 20.0),
              ),
              const SpaceHeight(50.0),
              InkWell(
                onTap: () {
                  context.goNamed(RouteConstants.login);
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already Account? ',
                        style: TextStyle(
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: 'Login Now',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
