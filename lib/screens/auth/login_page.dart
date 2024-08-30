import 'package:flutter/material.dart';
import 'package:gifts/common_widgets/input_text_box_widget.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
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
                Padding(padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80,),
                    Center(child: Text('Logo', style: textTheme.headlineMedium?.copyWith(color: colorScheme.onPrimaryFixed),)),
                    SizedBox(height: 115,),
                    Text('Create an account', style: textTheme.headlineLarge,),
                    SizedBox(height: 28,),
                    Text('Create an account to receive your price', style: textTheme.titleMedium,),
                    SizedBox(height: 20,),
                    InputTextbox(hintText: 'Username',),
                    SizedBox(height: 16,),
                    InputTextbox(hintText: 'Password',isPassword: true,),
                    SizedBox(height: 16,),
                    InputTextbox(hintText: 'Confirm Password',isPassword: true,),
                    SizedBox(height: 48,),
                    Center(child: SubmitButtonWidget(buttonHeight: 56, buttonWidth: 181, text: "Continue", hasIcon: false, buttonIconUrl: '')),
                    SizedBox(height: 48,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Log in', style: textTheme.titleLarge?.copyWith(color: colorScheme.primary, decoration: TextDecoration.underline),),
                        Text(', if you already have an account', style: textTheme.titleLarge,)
                      ],
                    ),
                    SizedBox(height: 70,),
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
                        Text('Your prize is waiting...', style: textTheme.headlineSmall,)
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