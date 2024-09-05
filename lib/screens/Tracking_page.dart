import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';
import 'package:go_router/go_router.dart';

class TrackingPage extends StatefulWidget {
  final int currentStep;
  const TrackingPage({super.key, required this.currentStep});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Track Your Sunglasses',
                style: textTheme.headlineSmall?.copyWith(fontSize: 22),
              ),
              SizedBox(height: 16),
              Text(
                'Check the status to see when you’ll receive your reward. From winning to delivery, we’ve got you covered every step of the way.',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 28),
              _buildStep(
                step: 1,
                title: "Preparing",
                description:
                    "Congrats! You've won your prize! We're prepping it for shipment. Stay tuned for updates!",
                isActive: widget.currentStep >= 1,
                iconUrl: 'assets/icons/gift_icon.svg',
              ),
              _buildStep(
                step: 2,
                title: "On The Way",
                description:
                    "Your prize is on the move!\nJehan Fernando\nNo.132/4, Araliya Street, Gampola.\n076 1234567",
                isActive: widget.currentStep >= 2,
                iconUrl: 'assets/icons/fast-delivery.svg',
              ),
              _buildStep(
                step: 3,
                title: "Prize Received",
                description: "Your prize has arrived, Enjoy your reward!",
                isActive: widget.currentStep == 3,
                iconUrl: 'assets/icons/prize_delivered.svg',
              ),
              SizedBox(
                height: 34,
              ),
              Center(
                child: SubmitButtonWidget(
                    buttonHeight: 56,
                    buttonWidth: 220,
                    text: 'Return Home',
                    hasIcon: false,
                    buttonIconUrl: '', onTapFunction: (){context.push('/home');},),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required int step,
    required String title,
    required String description,
    required bool isActive,
    required String iconUrl,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Icon and Dotted line

        // Step container
        Padding(
          padding: EdgeInsets.only(left: 50), // Offset content to the right
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: isActive ? colorScheme.primary : colorScheme.onTertiary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  iconUrl,
                  height: 52,
                  width: 52,
                ),
                SizedBox(width: 35),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleLarge?.copyWith(
                          color: isActive
                              ? colorScheme.onPrimaryFixed
                              : colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isActive
                              ? colorScheme.onPrimaryFixed
                              : colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 25,
          top: 20,
          child: Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: colorScheme.onPrimaryFixed, shape: BoxShape.circle),
                child: Icon(
                  isActive ? Icons.check_circle : Icons.radio_button_unchecked,
                  color:
                      isActive ? colorScheme.primary : colorScheme.onTertiary,
                  size: 30,
                ),
              ),
              if (step != 3)
                CustomPaint(
                  size: Size(2, 100),
                  painter: DottedLinePainter(isActive: isActive),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final bool isActive;

  DottedLinePainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 4, startY = 0;
    final paint = Paint()
      ..color = isActive ? Colors.pinkAccent : Colors.grey
      ..strokeWidth = 2;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
