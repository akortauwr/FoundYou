import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';

typedef NavTapCallback = void Function(int index);

class NeoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final NavTapCallback onTap;

  const NeoBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  Widget _buildNavItem({required IconData icon, required int index}) {
    final bool selected = currentIndex == index;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: NeoIconButton(
          onPressed: () => onTap(index),
          backgroundColor: selected ? NeoColors.coralPeach : Colors.white,
          shadowOffset: selected ? const Offset(0.5, 0.5) : const Offset(6, 6),
          child: Icon(icon, size: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            _buildNavItem(icon: Icons.home, index: 0),
            _buildNavItem(icon: Icons.search, index: 1),
            _buildNavItem(icon: Icons.notifications, index: 2),
            _buildNavItem(icon: Icons.person, index: 3),
          ],
        ),
      ),
    );
  }
}
