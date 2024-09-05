import 'package:flutter/material.dart';
import 'package:gifts/screens/pick_box_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
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
              Stack(
                children: [
                  Container(
                    height: 122,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                        topRight: Radius.circular(
                            22), // Maintain the overall rounded shape
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Welcome to the Ultimate Challenge!',
                        style: textTheme.headlineLarge?.copyWith(
                            color: colorScheme.onPrimaryFixed,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: TopRightCutOutClipper(),
                      child: Container(
                        color: Colors.white, // The color of the cut-out
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.help,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Your Smartwatch is on the way',
                              style: textTheme.titleSmall
                                  ?.copyWith(color: colorScheme.onPrimaryFixed),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: colorScheme.primary, shape: BoxShape.circle),
                    child: Icon(
                      Icons.play_arrow,
                      color: colorScheme.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Choose an item you'd like to win",
                style: textTheme.headlineSmall?.copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'The journey ahead will test your luck and skill. Select wisely, and keep your eye on the prize!',
                style: textTheme.titleMedium?.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 22,
              ),
              ItemContainer(
                item1Name: "Sunglasses",
                item2Name: "Necklace Set",
                onTapItem1: () {
                  _showPopupDialog(context,'Sunglasses');
                },
                onTapItem2: () {
                  _showPopupDialog(context, 'Necklace Set');
                },
              ),
              ItemContainer(
                  item1Name: "SmartWatch",
                  item2Name: "Ring",
                  onTapItem1: () {
                    _showPopupDialog(context,'SmartWatch');
                  },
                  onTapItem2: () {
                    _showPopupDialog(context,'Ring');
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('First Things First',
                    style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 24),
                Text('Enter your name to continue',
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text('This is for the first time only.',
                    style: textTheme.labelLarge),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.onTertiary,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextField(
                    controller: _nameController,
                    cursorColor: colorScheme.onPrimary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text.trim();
                    if (name.isNotEmpty) {
                      await _saveNameToSharedPreferences(name);
                      Navigator.of(context).pop();
                     context.push(
                          '/pickbox',
                          extra: {
                            'itemName': itemName,
                            'currentBox': 2,
                          },
                        );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a name.')),
                      );
                    }
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible:
          true, // Allow dismissing by tapping outside the dialog
    );
  }
Future<void> _saveNameToSharedPreferences(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }
}

// Custom Clipper for the top right cut-out
class TopRightCutOutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ItemContainer extends StatelessWidget {
  final String item1Name;
  //final String item1ImageUrl
  final String item2Name;
  //final String item2ImageUrl
  final VoidCallback onTapItem1;
  final VoidCallback onTapItem2;
  const ItemContainer({
    super.key,
    required this.item1Name,
    required this.item2Name,
    required this.onTapItem1,
    required this.onTapItem2,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTapItem1,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.black,
                  ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: Text(
                          item1Name,
                          style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onPrimaryFixed,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: InkWell(
                onTap: onTapItem2,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.black,
                  ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: Text(
                          item2Name,
                          style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onPrimaryFixed,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
