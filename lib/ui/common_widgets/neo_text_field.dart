import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? value;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;

  const NeoTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.value,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  State<NeoTextField> createState() => _NeoTextFieldState();
}

class _NeoTextFieldState extends State<NeoTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode =
        FocusNode()..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _focusNode.hasFocus ? NeoColors.coralPeach : Colors.white;

    final shadowOffset = _focusNode.hasFocus ? const Offset(0.5, 0.5) : const Offset(6, 6);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: [BoxShadow(color: Colors.black, offset: shadowOffset, blurRadius: 0)],
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,

        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
