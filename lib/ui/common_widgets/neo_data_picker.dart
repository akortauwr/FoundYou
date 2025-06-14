import 'package:flutter/material.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:intl/intl.dart';

class NeoDatePickerField extends StatelessWidget {
  final String label;

  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChanged;

  final Color activeColor;

  const NeoDatePickerField({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onChanged,
    this.activeColor = NeoColors.neonCyan,
  });

  @override
  Widget build(BuildContext context) {
    final displayText =
        selectedDate != null
            ? DateFormat.yMd(Localizations.localeOf(context).toLanguageTag()).format(selectedDate!)
            : 'Wybierz datę';

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) onChanged(picked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6), blurRadius: 0)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: selectedDate != null ? activeColor : Colors.white,
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6), blurRadius: 0)],
              ),
              child: Text(
                displayText,
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
