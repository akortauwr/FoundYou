import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

/// A neobrutalist style radio button group with two options.
class NeoRadioGroup extends StatefulWidget {
  /// Labels for the two options
  final String option1;
  final String option2;

  final Color opt1Color;
  final Color opt2Color;

  /// Currently selected index: 0 or 1
  final int? selectedIndex;

  /// Callback when selection changes
  final ValueChanged<int> onChanged;

  const NeoRadioGroup({
    Key? key,
    required this.option1,
    required this.option2,
    required this.selectedIndex,
    required this.onChanged,
    this.opt1Color = NeoColors.bubblegumPink,
    this.opt2Color = NeoColors.bubblegumPink,
  }) : super(key: key);

  @override
  _NeoRadioGroupState createState() => _NeoRadioGroupState();
}

class _NeoRadioGroupState extends State<NeoRadioGroup> {
  int? _current;

  @override
  void initState() {
    super.initState();
    _current = widget.selectedIndex;
  }

  void _select(int index) {
    if (_current == index) return;
    setState(() => _current = index);
    widget.onChanged(index);
  }

  Widget _buildOption(String text, int index) {
    final bool selected = _current == index;
    final Color bgColor = selected
        ? (index == 0 ? widget.opt1Color : widget.opt2Color)
        : Colors.white;
    final Offset shadowOffset = selected ? const Offset(0.5, 0.5) : const Offset(6, 6);
    return GestureDetector(
      onTap: () => _select(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: shadowOffset),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _buildOption(widget.option1, 0)),
        const SizedBox(width: 16),
        Expanded(child: _buildOption(widget.option2, 1)),
      ],
    );
  }
}