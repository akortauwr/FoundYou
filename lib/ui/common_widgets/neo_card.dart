import 'package:flutter/material.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;

   const NeoCard({super.key, required this.child, this.color = Colors.white,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
    this.borderWidth = 4,
    this.boxShadow = const [
      BoxShadow(color: Colors.black, offset: Offset(6, 6), blurRadius: 0),
    ]
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.black, width: borderWidth),
        boxShadow: boxShadow
      ),
      child: child,
    );
  }
}
