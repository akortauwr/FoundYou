import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoIconButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool disabled;
  final Color backgroundColor;
  final Offset shadowOffset;
  final EdgeInsets padding;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  const NeoIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.backgroundColor = NeoColors.neonCyan,
    this.shadowOffset = const Offset(6, 6),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    this.borderWidth = 4.0,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  State<NeoIconButton> createState() => _NeoIconButtonState();
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
    final Color bgColor = widget.disabled ? NeoColors.disabledGray : widget.backgroundColor;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.black, width: widget.borderWidth),
          boxShadow: [BoxShadow(color: Colors.black, offset: offset, blurRadius: 0)],
          borderRadius: widget.borderRadius,
        ),
        padding: widget.padding,
        child: Center(child: widget.child),
      ),
    );
  }
}
