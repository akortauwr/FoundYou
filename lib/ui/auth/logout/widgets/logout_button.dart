import 'package:flutter/material.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/auth/logout/view_models/logout_view_model.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatefulWidget {
  final LogoutViewModel viewModel;

  const LogoutButton({super.key, required this.viewModel});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.logout.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LogoutButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.logout.removeListener(_onResult);
    widget.viewModel.logout.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.logout.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () => widget.viewModel.logout.execute(), child: const Text('Logout'));
  }

  void _onResult() {
    if (widget.viewModel.logout.completed) {
      context.go(Paths.login);
    }
  }
}
