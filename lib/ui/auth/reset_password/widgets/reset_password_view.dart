import 'package:flutter/material.dart';
import 'package:found_you_app/ui/auth/reset_password/view_models/reset_password_view_model.dart';
import 'package:found_you_app/ui/common_widgets/neo_app_bar.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:provider/provider.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ResetPasswordViewModel>();
    return Scaffold(
      appBar: const NeoAppBar(text: 'Zresetuj hasło'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: NeoCard(
            color: NeoColors.softPurple,
            borderRadius: BorderRadius.circular(0),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                NeoTextField(
                  controller: vm.oldPasswordController,
                  label: 'Stare hasło',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                ),
                const SizedBox(height: 24),
                NeoTextField(
                  controller: vm.newPasswordController,
                  label: 'Nowe hasło',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                NeoTextField(
                  controller: vm.confirmNewPasswordController,
                  label: 'Potwierdź nowe hasło',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 20),
                NeoButton(onPressed: vm.reset, text: 'Zresetuj hasło', backgroundColor: NeoColors.springGreen),
                if (vm.resetError)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Error resetting password', style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
