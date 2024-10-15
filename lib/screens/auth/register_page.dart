import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifts/blocs/auth/auth_bloc.dart';
import 'package:gifts/common_widgets/input_text_box_widget.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  String? validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  void validateAndSubmit() {
    final emailError = validateEmail(_emailController.text);
    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailError)),
      );
      return;
    }

    final passwordError = validatePassword(_passwordController.text);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordError)),
      );
      return;
    }

    final confirmPasswordError = validateConfirmPassword(
        _passwordController.text, _confirmPassword.text);
    if (confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(confirmPasswordError)),
      );
      return;
    }

    // If all validations pass, trigger the registration event
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        _emailController.text,
        _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          GoRouter.of(context).pushNamed('addressdetails');
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: TopCircleClipper(),
                    child: Container(
                      height: 200,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Center(
                            child: Text(
                          'Logo',
                          style: textTheme.headlineMedium
                              ?.copyWith(color: colorScheme.onPrimaryFixed),
                        )),
                        const SizedBox(
                          height: 115,
                        ),
                        Text(
                          'Create an account',
                          style: textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Create an account to receive your price',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputTextbox(
                          hintText: 'Username',
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputTextbox(
                          hintText: 'Password',
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InputTextbox(
                          hintText: 'Confirm Password',
                          isPassword: true,
                          controller: _confirmPassword,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Center(child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return const CircularProgressIndicator();
                            } else {
                              return SubmitButtonWidget(
                                buttonHeight: 56,
                                buttonWidth: 181,
                                text: "Continue",
                                hasIcon: false,
                                buttonIconUrl: '',
                                onTapFunction: validateAndSubmit,
                              );
                            }
                          },
                        )),
                        const SizedBox(
                          height: 48,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).pushNamed('login');
                              },
                              child: Text(
                                'Log in',
                                style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.primary,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Text(
                              ', if you already have an account',
                              style: textTheme.titleLarge,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Your prize is waiting...',
                              style: textTheme.headlineSmall,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.4, // Control point
      size.width, size.height * 0.6, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
