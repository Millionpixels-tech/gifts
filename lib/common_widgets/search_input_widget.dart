import 'package:flutter/material.dart';

class SearchInputTextBox extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  const SearchInputTextBox(
      {super.key, required this.hintText, this.controller, this.onTap});

  @override
  State<SearchInputTextBox> createState() => _SearchInputTextBoxState();
}

class _SearchInputTextBoxState extends State<SearchInputTextBox> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 52,
      decoration: BoxDecoration(
          color: colorScheme.onPrimaryFixed,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(width: 1, color: colorScheme.onTertiary)),
      margin: const EdgeInsets.all(1),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorColor: colorScheme.onPrimary,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle:
                  textTheme.bodyLarge?.copyWith(color: colorScheme.onTertiary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              suffixIcon: GestureDetector(
                onTap: widget.onTap,
                child: const Icon(Icons.search),
              ),
              suffixIconColor: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
