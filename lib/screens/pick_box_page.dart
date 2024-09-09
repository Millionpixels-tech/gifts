import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:gifts/screens/congratulations_page.dart';
import 'package:gifts/utils/constants.dart';
import 'package:go_router/go_router.dart';

class PickBoxPage extends StatefulWidget {
  final String itemName;
  final int currentBox;
  final String itemImageUrl;
  const PickBoxPage(
      {super.key,
      required this.itemName,
      required this.currentBox,
      required this.itemImageUrl});

  @override
  State<PickBoxPage> createState() => _PickBoxPageState();
}

class _PickBoxPageState extends State<PickBoxPage> {
  int _countdown = 10;
  late Timer _timer;
  bool? isFound;
  int prizeBox = Random().nextInt(2); // Randomize the prize box (0 or 1)
  bool isTimerFinished = false; // To track if the timer has finished

  @override
  void initState() {
    super.initState();
    _startCountdown();
    print(prizeBox);
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer.cancel();
        setState(() {
          isTimerFinished = true; // Mark timer as finished
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onBoxSelected(int boxIndex) {
    if (boxIndex == prizeBox) {
      setState(() {
        isFound = true;
      });
    } else {
      setState(() {
        isFound = false;
      });
    }
  }

  void _onNextPressed() {
    if (!isTimerFinished) return; // Disable button if timer not finished
    if (isFound == true) {
      if (widget.currentBox < 19) {
        // Navigate to the next set of boxes
        context.push(
          '/pickbox',
          extra: {
            'itemName': widget.itemName,
            'currentBox': widget.currentBox + 2,
            'itemImageUrl': widget.itemImageUrl
          },
        );
      } else {
        // Navigate to the congratulations page
        context.push('/congratulationspage', extra: {
          'itemImageUrl': widget.itemImageUrl,
        });
      }
    } else {
      // Restart the game
      setState(() {
        _countdown = 10; // Reset countdown
        isFound = null; // Reset found status
        prizeBox = Random().nextInt(2); // Randomize the prize box
        isTimerFinished = false; // Reset timer finished status
      });

      // Navigate to the same page with reset state
      context.push(
        '/pickbox',
        extra: {
          'itemName': widget.itemName,
          'currentBox': 2,
          'itemImageUrl': widget.itemImageUrl
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    Color progressColor;

    if (_countdown <= 3) {
      progressColor = colorScheme.primary;
    } else if (_countdown <= 5) {
      progressColor = LightThemeAppColors.starColour;
    } else {
      progressColor = Colors.greenAccent;
    }

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
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You picked ${widget.itemName}',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.onPrimaryFixed,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 26,
                            width: 26,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                widget.itemImageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 90),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimaryFixed,
                          shape: BoxShape.circle,
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
                                  color: progressColor,
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
                      const SizedBox(height: 48),
                      if (isFound == null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _onBoxSelected(0),
                              child: SvgPicture.asset(
                                'assets/icons/gift_icon.svg',
                                height: 118,
                                width: 112,
                              ),
                            ),
                            const SizedBox(width: 50),
                            GestureDetector(
                              onTap: () => _onBoxSelected(1),
                              child: SvgPicture.asset(
                                'assets/icons/gift_icon.svg',
                                height: 118,
                                width: 112,
                              ),
                            ),
                          ],
                        ),
                      ] else if (isFound == true) ...[
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/found_box.svg',
                              height: 184,
                              width: 166,
                            ),
                            Positioned(
                              top: -4,
                              left: -4,
                              child: Container(
                              width: 87,
                              height: 87,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                              child: Image.network(
                                widget.itemImageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            ))
                          ],
                        ),
                      ] else if (isFound == false) ...[
                        SvgPicture.asset(
                          'assets/icons/failed_box.svg',
                          height: 185,
                          width: 166,
                        ),
                      ],
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Box',
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' ${widget.currentBox} ',
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            'of 20',
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: colorScheme.onTertiary,
                        ),
                        child: const Center(child: Text('Test Ad')),
                      ),
                      const SizedBox(height: 16),
                      if (isFound == null)
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
                              style: textTheme.headlineMedium?.copyWith(
                                color: colorScheme.tertiary,
                              ),
                            ),
                          ),
                        )
                      else
                        SubmitButtonWidget(
                          buttonHeight: 48,
                          buttonWidth: 133,
                          text: isTimerFinished
                              ? (isFound! ? 'Next' : 'Retry')
                              : (isFound! ? 'Next' : 'Retry'),
                          hasIcon: false,
                          buttonIconUrl: '',
                          onTapFunction:
                              isTimerFinished ? _onNextPressed : null,
                          buttonColor:
                              isTimerFinished ? null : colorScheme.onTertiary,
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 9; i++)
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: i == (widget.currentBox ~/ 2 - 1)
                                    ? colorScheme.primary
                                    : colorScheme.primary.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/gift_small.svg',
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
