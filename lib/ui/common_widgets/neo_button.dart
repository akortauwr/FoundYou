import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool disabled;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;

  const NeoButton({
    super.key,
    required this.text,
    this.onPressed,
    this.disabled = false,
    this.backgroundColor = NeoColors.neonCyan,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
    ),
    this.width,
    this.height,

  });

  @override
  _NeoButtonState createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _pressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.disabled) return;
    setState(() => _pressed = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _pressed = false);
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.disabled) return;
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (widget.disabled) return;
    if (_pressed) setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final Offset offset = _pressed ? const Offset(0.5, 0.5) : const Offset(6, 6);
    final Color bgColor = widget.disabled
        ? NeoColors.disabledGray
        : widget.backgroundColor;
    final Color textColor = widget.disabled ? Colors.white : Colors.black;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.height,
        width: widget.width,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: widget.borderRadius,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: offset, blurRadius: 0),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
