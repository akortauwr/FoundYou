import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';

class NeoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const NeoAppBar({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We wrap the Row in a SafeArea to avoid UI intrusions like the notch
    // on some phones. The `bottom: false` is important because the AppBar is
    // at the top of the screen.
    return SafeArea(
      bottom: false,
      child: Padding(
        // Add some horizontal padding for aesthetics.
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Item: Back button
            NeoIconButton(
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () {
                // Check if there is a page to pop back to before attempting.
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),

            // Center Item: Title
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            // Right Item: Placeholder for symmetry
            // This ensures the title is truly in the center of the screen.
            // Its width should ideally match the width of the left-side button.
            // An IconButton has a default size of 48x48 pixels.
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  /// This is the required method from `PreferredSizeWidget`.
  /// It specifies the height that the AppBar will occupy.
  /// `kToolbarHeight` is a constant in Flutter for the standard AppBar height (usually 56.0 pixels).
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}