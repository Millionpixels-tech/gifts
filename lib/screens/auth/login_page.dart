import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifts/blocs/auth/auth_bloc.dart';
import 'package:gifts/common_widgets/input_text_box_widget.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
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
                      color: colorScheme.primary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                            child: Text(
                          'Logo',
                          style: textTheme.headlineMedium
                              ?.copyWith(color: colorScheme.onPrimaryFixed),
                        )),
                        SizedBox(
                          height: 115,
                        ),
                        Text(
                          'Log in to your account',
                          style: textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Log in to your account to receive your price',
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputTextbox(
                          hintText: 'Username',
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextbox(
                          hintText: 'Password',
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Center(
                            child: SubmitButtonWidget(
                          buttonHeight: 56,
                          buttonWidth: 181,
                          text: "Continue",
                          hasIcon: false,
                          buttonIconUrl: '',
                          onTapFunction: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                          },
                        )),
                        SizedBox(
                          height: 48,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                GoRouter.of(context).pushNamed('register');
                              },
                              child: Text(
                                'Sign up',
                                style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.primary,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Text(
                              ", if you don't have an account",
                              style: textTheme.titleLarge,
                            )
                          ],
                        ),
                        SizedBox(
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
                            SizedBox(width: 12),
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
