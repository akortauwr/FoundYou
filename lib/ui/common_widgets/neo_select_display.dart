import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

/// Read-only, neo-brutalist style display of selected labels.
class NeoSelectDisplay extends StatelessWidget {
  /// List of labels to display.
  final List<String> labels;

  /// Maximum number of items to show (null = unlimited).
  final int? maxToShow;

  /// Color for the displayed items.

   NeoSelectDisplay({
    Key? key,
    required this.labels,
    this.maxToShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toShow = (maxToShow != null && labels.length > maxToShow!)
        ? labels.sublist(0, maxToShow!)
        : labels;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        ...toShow.map((label) => _buildItem(label)),
        if (maxToShow != null && labels.length > maxToShow!)
          _buildOverflowIndicator(labels.length - maxToShow!)
      ],
    );
  }

  Widget _buildItem(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: NeoColors.randomPastel(),
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(1, 1)),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
      ),
    );
  }

  Widget _buildOverflowIndicator(int extraCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(

        color: NeoColors.randomPastel(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(1, 1)),
        ],
      ),
      child: Text(
        '+$extraCount more',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
