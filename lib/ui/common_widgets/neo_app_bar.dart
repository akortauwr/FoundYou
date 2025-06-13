import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';

class NeoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const NeoAppBar({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NeoIconButton(
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),

            Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87)),

            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
