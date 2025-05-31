// lib/widgets/common/neo_checkbox.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

/// NeoCheckbox: niestandardowy checkbox w stylu neo-brutalismu.
/// Po zaznaczeniu tło przyjmuje pastelowy kolor z delikatnym oświetleniem,
/// oraz na środku pojawia się ikonka check.
class NeoCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  /// [size] - wymiar boku checkboxa.
  const NeoCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
  }) : super(key: key);

  @override
  _NeoCheckboxState createState() => _NeoCheckboxState();
}

class _NeoCheckboxState extends State<NeoCheckbox> {
  late Color _pastel;

  @override
  void initState() {
    super.initState();
    // Inicjalny losowy pastel
    _pastel = NeoColors.randomPastel();
  }

  void _toggle() {
    final newValue = !widget.value;
    if (newValue) {
      // przy zaznaczeniu wybierz nowy pastel
      _pastel = NeoColors.randomPastel();
    }
    widget.onChanged(newValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double side = widget.size;
    final Color base = widget.value ? _pastel : Colors.white;
    final Color bgColor = widget.value
        ? Color.alphaBlend(Colors.white.withOpacity(0.4), base)
        : base;
    final Offset shadow = widget.value ? const Offset(3, 3): const Offset(0.5, 0.5);

    return GestureDetector(
      onTap: _toggle,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: side,
            height: side,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: [
                BoxShadow(color: Colors.black, offset: shadow, blurRadius: 0),
              ],
            ),
            child: widget.value
                ? Center(
              child: Icon(
                Icons.check,
                size: side * 0.75,
                color: Colors.black,
              ),
            )
                : null,
          ),
        ],
      ),
    );
  }
}
