import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoIconButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool disabled;
  final Color backgroundColor;
  final Offset shadowOffset;

  const NeoIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.backgroundColor = NeoColors.neonCyan,
    this.shadowOffset = const Offset(6, 6),

  });

  @override
  _NeoIconButtonState createState() => _NeoIconButtonState();
}

class _NeoIconButtonState extends State<NeoIconButton> {
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
    final Offset offset = _pressed ? const Offset(0.5, 0.5) : widget.shadowOffset;
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
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: offset, blurRadius: 0),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
