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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logging in...')));
      }
      if (cmd.result == null) {
        return;
      }

      if (cmd.completed) {
        cmd.clearResult();
        context.go(Paths.home);
      } else if (cmd.error) {
        cmd.clearResult();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
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

                // 📨 email
                // TextField(
                //   controller: vm.emailController,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                // ),
                NeoTextField(controller: vm.emailController, label: 'Email', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 12),

                // 🔒 password
                // TextField(
                //   controller: vm.passwordController,
                //   decoration: InputDecoration(
                //     labelText: 'Hasło',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: const BorderSide(color: Colors.black, width: 4)
                //     ),
                //   ),
                //   obscureText: true,
                // ),
                NeoTextField(controller: vm.passwordController, label: 'Hasło', obscureText: true),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    GestureDetector(
                      onTap: () => context.go(Paths.resetPassword),
                      child: const Text(
                        'Zapomniałem hasła',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ▶️ login button
                NeoButton(onPressed: vm.executeLogin, text: 'Zaloguj się'),
                const SizedBox(height: 12),

                // 🔗 register link
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

                // 🛑 inline error text if you prefer instead of SnackBar
                if (vm.loginError)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text('Login failed', style: TextStyle(color: Colors.redAccent)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
