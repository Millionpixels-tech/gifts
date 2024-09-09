import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubmitButtonWidget extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final String text;
  final bool hasIcon;
  final String buttonIconUrl;
  final Function? onTapFunction;
  final Color? buttonColor;

  const SubmitButtonWidget({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.text,
    required this.hasIcon,
    required this.buttonIconUrl,
    this.onTapFunction, this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTapFunction!();
      },
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: buttonColor ?? colorTheme.primary,
        ),
        child: Center(
          child: hasIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      buttonIconUrl,
                      height: 18,
                      width: 18,
                      
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colorTheme.onPrimaryFixed,
                          ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: colorTheme.onPrimaryFixed),
                ),
        ),
      ),
    );
  }
}
