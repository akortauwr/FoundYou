import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoSelectOption<V> {
  final V value;
  final String label;
  final Color selectedColor;

  const NeoSelectOption({required this.value, required this.label, this.selectedColor = NeoColors.bubblegumPink});
}

class NeoSelect<V> extends StatefulWidget {
  final List<NeoSelectOption<V>> options;

  final List<V>? selectedValues;

  final ValueChanged<List<V>> onChanged;

  final int maxSelection;

  const NeoSelect({
    super.key,
    required this.options,
    this.selectedValues,
    required this.onChanged,
    this.maxSelection = 5,
  });

  @override
  State<NeoSelect<V>> createState() => _NeoSelectState<V>();
}

class _NeoSelectState<V> extends State<NeoSelect<V>> {
  late List<V> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<V>.from(widget.selectedValues ?? <V>[]);
  }

  void _toggle(V value) {
    setState(() {
      if (_selected.contains(value)) {
        _selected.remove(value);
      } else {
        if (_selected.length < widget.maxSelection) {
          _selected.add(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Możesz wybrać maksymalnie 5 opcji.')),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    });
    widget.onChanged(_selected);
  }

  Widget _buildOption(NeoSelectOption<V> option) {
    final bool selected = _selected.contains(option.value);
    final Color bgColor = selected ? option.selectedColor : Colors.white;
    final Offset shadowOffset = selected ? const Offset(0.5, 0.5) : const Offset(6, 6);

    return GestureDetector(
      onTap: () => _toggle(option.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [BoxShadow(color: Colors.black, offset: shadowOffset)],
        ),
        child: Text(option.label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Wrap(spacing: 8, runSpacing: 8, children: widget.options.map(_buildOption).toList()),
    );
  }
}
