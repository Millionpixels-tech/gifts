import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:gifts/utils/constants.dart';
import 'package:go_router/go_router.dart';

class CongratulationsPage extends StatefulWidget {
  final String itemImageUrl;
  const CongratulationsPage({super.key, required this.itemImageUrl});

  @override
  State<CongratulationsPage> createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  @override
  void initState() {
    super.initState();
    _confettiController
        .play(); // Start confetti animation when the page is opened
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Confetti Background
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive, // Blast in all directions
              shouldLoop: true, // Loop confetti animation
              colors: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.purple
              ], // Confetti colors
              numberOfParticles:
                  30, // Adjust the number of particles for effect
              gravity: 0.1, // Gravity of confetti pieces
            ),
          ),
          // Main Content
          Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: TopCircleClipper1(),
                    child: Container(
                      height: 300,
                      color: Color(0xFFFFD233),
                    ),
                  ),
                  ClipPath(
                    clipper: TopCircleClipper2(),
                    child: Container(
                      height: 250,
                      color: Color(0xFFFFBB1B),
                    ),
                  ),
                  ClipPath(
                    clipper: TopCircleClipper3(),
                    child: Container(
                      height: 200,
                      color: Color(0xFFFFAF0E),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Congratulations!',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimaryFixed),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'You Won',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimaryFixed),
                          ),
                        ),
                        SizedBox(height: 73),
                        Container(
                          height: 230,
                          width: 230,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24),
                            border:
                                Border.all(width: 3, color: Color(0xFFFFD233)),
                          ),
                          child: Image.network(
                          widget.itemImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          
                        ),
                        ),
                        //SizedBox(height: 209,),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    context.push('/addressdetails');
                  },
                  child: Container(
                    height: 64,
                    width: 222,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: LightThemeAppColors.starColour,
                    ),
                    child: Center(
                      child: Text(
                        'Redeem',
                        style: textTheme.headlineMedium
                            ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TopCircleClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.3, // Control point
      size.width, size.height * 0.6, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopCircleClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.3, // Control point
      size.width, size.height * 0.4, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopCircleClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.1);
    path.quadraticBezierTo(
      size.width / 2, size.height * 1.3, // Control point
      size.width, size.height * 0.1, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
