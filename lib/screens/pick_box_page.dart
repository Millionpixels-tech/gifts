import 'dart:async';

import 'package:flutter/material.dart';

class PickBoxPage extends StatefulWidget {
  const PickBoxPage({super.key});

  @override
  State<PickBoxPage> createState() => _PickBoxPageState();
}

class _PickBoxPageState extends State<PickBoxPage> {
  int _countdown = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
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
                    height: 300,
                    color: colorScheme.primary
                  ),
                ),
                Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(child: Text('Pick your lucky box', style: textTheme.headlineLarge?.copyWith(color: colorScheme.onPrimaryFixed, fontSize: 28, fontWeight: FontWeight.w600),)),
                    SizedBox(height: 32,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You picked sunglasses',style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimaryFixed,)),
                        SizedBox(width: 12,),
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 90,),
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimaryFixed,
                        shape: BoxShape.circle
                      ),
                      child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 76,
                                width: 76,
                                child: CircularProgressIndicator(
                                  value: _countdown / 10,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.grey.shade300,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Text(
                                '$_countdown',
                                style: textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                    SizedBox(height: 48,),
                    Row(
                      children: [
                        
                      ],
                    )
                  ],
                ),
                )
              ],
            )
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
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.3, // Control point
      size.width, size.height * 0.7, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}