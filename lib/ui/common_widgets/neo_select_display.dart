import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoSelectDisplay extends StatelessWidget {
  final List<String> labels;
  final double fontSize;

  final int? maxToShow;

  const NeoSelectDisplay({super.key, required this.labels, this.fontSize = 12, this.maxToShow});

  @override
  Widget build(BuildContext context) {
    final toShow = (maxToShow != null && labels.length > maxToShow!) ? labels.sublist(0, maxToShow!) : labels;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        ...toShow.map((label) => _buildItem(label, fontSize)),
        if (maxToShow != null && labels.length > maxToShow!) _buildOverflowIndicator(labels.length - maxToShow!),
      ],
    );
  }

  Widget _buildItem(String label, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: NeoColors.purpleMystic,
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(1, 1))],
      ),
      child: Text(label, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: fontSize)),
    );
  }

  Widget _buildOverflowIndicator(int extraCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: NeoColors.randomPastel(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(1, 1))],
      ),
      child: Text('+$extraCount more', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
