import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const NeoCheckbox({super.key, required this.value, required this.onChanged, this.size = 24.0});

  @override
  State<NeoCheckbox> createState() => _NeoCheckboxState();
}

class _NeoCheckboxState extends State<NeoCheckbox> {
  late Color _pastel;

  @override
  void initState() {
    super.initState();

    _pastel = NeoColors.randomPastel();
  }

  void _toggle() {
    final newValue = !widget.value;
    if (newValue) {
      _pastel = NeoColors.randomPastel();
    }
    widget.onChanged(newValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double side = widget.size;
    final Color base = widget.value ? _pastel : Colors.white;
    final Color bgColor = widget.value ? Color.alphaBlend(Colors.white.withValues(alpha: 0.4), base) : base;
    final Offset shadow = widget.value ? const Offset(3, 3) : const Offset(0.5, 0.5);

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
              boxShadow: [BoxShadow(color: Colors.black, offset: shadow, blurRadius: 0)],
            ),
            child: widget.value ? Center(child: Icon(Icons.check, size: side * 0.75, color: Colors.black)) : null,
          ),
        ],
      ),
    );
  }
}
