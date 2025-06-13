import 'package:flutter/material.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_bottom_nav_bar.dart';
import 'package:found_you_app/ui/home_shell/view_models/home_shell_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeShellView extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  const HomeShellView({required this.currentLocation, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeShellViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.setIndexByLocation(currentLocation);
    });

    return Scaffold(
      body: child,
      bottomNavigationBar: NeoBottomNavBar(
        currentIndex: vm.currentIndex,
        onTap: (idx) {
          vm.setIndex(idx);
          switch (idx) {
            case 0:
              context.go(Paths.home);
              break;
            case 1:
              context.go(Paths.swipe);
              break;
            case 2:
              context.go(Paths.chats);
              break;
            case 3:
              context.go(Paths.profile);
              break;
          }
        },
      ),
    );
  }
}
