import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

class NeoDialog extends StatelessWidget {
  final String content;

  const NeoDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      height: 248,
      width: 248,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 24),
          Center(
            child: Text(
              content,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NeoIconButton(
                child: const Icon(Icons.close, size: 24),
                onPressed: () => Navigator.of(context).pop(false),
                backgroundColor: NeoColors.tomatoRed,
              ),
              NeoIconButton(
                child: const Icon(Icons.check, size: 24),
                onPressed: () => Navigator.of(context).pop(true),
                backgroundColor: NeoColors.mossGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
