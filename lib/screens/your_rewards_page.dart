import 'package:flutter/material.dart';
import 'package:gifts/common_widgets/submit_button_widget.dart';

class YourRewardsPage extends StatefulWidget {
  const YourRewardsPage({super.key});

  @override
  State<YourRewardsPage> createState() => _YourRewardsPageState();
}

class _YourRewardsPageState extends State<YourRewardsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Rewards',
              style: textTheme.headlineSmall?.copyWith(fontSize: 22),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'See all the prizes you’ve won. Track their delivery status and keep winning more!',
              style: textTheme.titleMedium,
            ),
            const SizedBox(
              height: 28,
            ),
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Rewarded on 12/02/2024',
                          style: textTheme.labelMedium
                              ?.copyWith(color: colorScheme.onPrimaryFixed),
                        )),
                  ),
                ),
                Positioned(
                    top: -9,
                    child: Container(
                      height: 31,
                      width: 183,
                      decoration: BoxDecoration(
                          color: colorScheme.onPrimaryFixed,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12))),
                      child: Row(
                        children: [
                          Text(
                            'Sunglasses · ',
                            style: textTheme.titleSmall,
                          ),
                          Text('On The Way',
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.onError,
                              )),
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Rewarded on 12/02/2024',
                          style: textTheme.labelMedium
                              ?.copyWith(color: colorScheme.onPrimaryFixed),
                        )),
                  ),
                ),
                Positioned(
                    top: -9,
                    child: Container(
                      height: 31,
                      width: 183,
                      decoration: BoxDecoration(
                          color: colorScheme.onPrimaryFixed,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(12))),
                      child: Row(
                        children: [
                          Text(
                            'Smart Watch · ',
                            style: textTheme.titleSmall,
                          ),
                          Text('Received',
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.onError,
                              )),
                        ],
                      ),
                    ))
              ],
            ),
            const Spacer(),
            const Center(
                child: SubmitButtonWidget(
                    buttonHeight: 56,
                    buttonWidth: 220,
                    text: 'Return Home',
                    hasIcon: false,
                    buttonIconUrl: ' '))
          ],
        ),
      ),
    );
  }
}
