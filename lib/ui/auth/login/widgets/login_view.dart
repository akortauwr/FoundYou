import 'package:flutter/material.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/auth/login/view_models/login_view_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_checkbox.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cmd = vm.login;
      if (cmd.running) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logowanie w toku...')));
      }
      if (cmd.result == null) {
        return;
      }

      if (cmd.completed) {
        cmd.clearResult();
        context.go(Paths.home);
      } else if (cmd.error) {
        cmd.clearResult();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Błąd podczas logowania')));
      }
    });

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('FoundYou', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(height: 24),

                NeoTextField(controller: vm.emailController, label: 'Email', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 12),

                NeoTextField(controller: vm.passwordController, label: 'Hasło', obscureText: true),
                const SizedBox(height: 12),

                Row(
                  children: [
                    NeoCheckbox(value: vm.rememberMe, onChanged: vm.toggleRememberMe),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: vm.toggleRememberMe,
                      child: const Text('Zapamiętaj mnie', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                NeoButton(onPressed: vm.executeLogin, text: 'Zaloguj się'),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nie masz konta?', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => context.go(Paths.register),
                      child: const Text('Zarejestruj się', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),

                if (vm.loginError)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text('Błąd podczas logowania', style: TextStyle(color: Colors.redAccent)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
