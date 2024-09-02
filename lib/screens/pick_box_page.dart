import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:gifts/utils/constants.dart';

class PickBoxPage extends StatefulWidget {
  const PickBoxPage({super.key});

  @override
  State<PickBoxPage> createState() => _PickBoxPageState();
}

class _PickBoxPageState extends State<PickBoxPage> {
  int _countdown = 10;
  late Timer _timer;
  bool? isFound = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
                  child: Container(height: 300, color: colorScheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        isFound == null
                            ? 'Pick your lucky box'
                            : isFound!
                                ? 'You Found it!'
                                : 'Better Luck Next Time!',
                        style: textTheme.headlineLarge?.copyWith(
                            color: colorScheme.onPrimaryFixed,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You picked sunglasses',
                              style: textTheme.titleLarge?.copyWith(
                                color: colorScheme.onPrimaryFixed,
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: 26,
                            width: 26,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: colorScheme.onPrimaryFixed,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 76,
                                width: 76,
                                child: CircularProgressIndicator(
                                  value: isFound == null ? _countdown / 10 : 0,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.grey.shade300,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Text(
                                isFound == null ? '$_countdown' : '00',
                                style: textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      if (isFound == null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/gift_icon.svg',
                              height: 118,
                              width: 112,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            SvgPicture.asset(
                              'assets/icons/gift_icon.svg',
                              height: 118,
                              width: 112,
                            ),
                          ],
                        ),
                      ] else if (isFound == true) ...[
                        SvgPicture.asset(
                          'assets/icons/found_box.svg',
                          height: 184,
                          width: 166,
                        ),
                      ] else if (isFound == false) ...[
                        SvgPicture.asset(
                          'assets/icons/failed_box.svg',
                          height: 185,
                          width: 166,
                        ),
                      ],
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Box',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' 1 ',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary),
                          ),
                          Text(
                            'of 20',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: colorScheme.onTertiary,
                        ),
                        child: const Center(
                          child: Text('Test Ad'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (isFound == null) ...[
                        Container(
                          height: 48,
                          width: 133,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorScheme.onTertiary,
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: colorScheme.tertiary),
                            ),
                          ),
                        )
                      ] else if (isFound == true) ...[
                        const SubmitButtonWidget(
                            buttonHeight: 48,
                            buttonWidth: 133,
                            text: 'Next',
                            hasIcon: false,
                            buttonIconUrl: ''),
                      ] else if (isFound == false) ...[
                        Container(
                          height: 48,
                          width: 133,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: LightThemeAppColors.starColour,
                          ),
                          child: Center(
                            child: Text(
                              'Retry',
                              style: textTheme.headlineMedium
                                  ?.copyWith(color: colorScheme.onPrimaryFixed),
                            ),
                          ),
                        )
                      ],
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Generate dots
                          for (int i = 0; i < 19; i++)
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: i == 0
                                    ? colorScheme
                                        .primary // Fully pink for the first dot
                                    : colorScheme.primary
                                        .withOpacity(0.3), // Adjust opacity
                                shape: BoxShape.circle,
                              ),
                            ),
                          // Add gift icon at the end
                          Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/gift_small.svg',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
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
