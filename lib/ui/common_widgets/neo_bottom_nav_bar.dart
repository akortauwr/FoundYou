import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_icon_buttons.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'neo_button.dart';


typedef NavTapCallback = void Function(int index);

/// A neobrutalist style bottom nav bar with 4 buttons + floating center icon.
class NeoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final NavTapCallback onTap;
  final String centerSvgAsset;
  final VoidCallback onCenterTap;

  const NeoBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.centerSvgAsset,
    required this.onCenterTap,
  }) : super(key: key);

  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    final bool selected = currentIndex == index;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: NeoIconButton(
          child: Icon(icon, size: 24),
          onPressed: () => onTap(index),
          backgroundColor: selected ? NeoColors.coralPeach : Colors.white,
          shadowOffset: selected ? const Offset(0.5, 0.5) : const Offset(6, 6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom:32),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Row(
          children: [
            _buildNavItem(icon: Icons.home, index: 0),
            _buildNavItem(icon: Icons.search, index: 1),
            _buildNavItem(icon: Icons.notifications, index: 2),
            _buildNavItem(icon: Icons.person, index: 3),
          ],
        ),
      ));
  }
}
