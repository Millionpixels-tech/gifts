import 'package:flutter/material.dart';

class InputTextbox extends StatefulWidget {
  final String? hintText;
  final bool? isPassword;
  final TextEditingController? controller;

  const InputTextbox({
    super.key,
    this.hintText,
    this.isPassword = false, // default to false if not provided
    this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputTextboxState createState() => _InputTextboxState();
}

class _InputTextboxState extends State<InputTextbox> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ?? false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: colorScheme.onTertiaryFixedVariant,
        //border: Border.all(width: 1, color: colorScheme.onTertiary),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        cursorColor: colorScheme.onPrimary,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide.none,
          ),
          
          hintText: widget.hintText,
          hintStyle:
              textTheme.bodyLarge?.copyWith(color: colorScheme.onTertiary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 15,
          ),
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onTertiary,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null,
        ),
      ),
    );
  }
}
