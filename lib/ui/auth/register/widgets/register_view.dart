import 'package:flutter/material.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_button.dart';
import 'package:found_you_app/ui/common_widgets/neo_text_field.dart';
import 'package:found_you_app/ui/core/colors/neo_colors.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget{
  const RegisterView({super.key});


  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>{
  final TextEditingController _email = TextEditingController(text: 'jan.kowalski@example.com');
  final TextEditingController _password = TextEditingController(text: 'password');
  final TextEditingController _confirmPassword = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('FoundYou', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),),
                const SizedBox(height: 24),
                NeoTextField(controller: _email, label: 'Email', keyboardType: TextInputType.emailAddress, maxLines: 1,),
                const SizedBox(height: 12),
                NeoTextField(controller: _password, label: 'Hasło', obscureText: true, keyboardType: TextInputType.visiblePassword, maxLines: 1,),
                const SizedBox(height: 12),
                NeoTextField(controller: _confirmPassword, label: 'Potwierdź hasło', obscureText: true, keyboardType: TextInputType.visiblePassword, maxLines: 1,),
                const SizedBox(height: 18),
                NeoButton(text: 'Załóż konto', onPressed: () {
                  if (_email.text.isEmpty || _password.text.isEmpty || _confirmPassword.text != _password.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Wszystkie pola są wymagane')),
                    );
                    return;
                  }
                  context.pushNamed('registerForm', extra: {
                    'email': _email.text,
                    'password': _password.text,
                  });
                }, disabled: _email.text.isEmpty || _password.text.isEmpty || _confirmPassword.text != _password.text,
                    backgroundColor: NeoColors.salmonOrange,),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Masz już konto?', style: TextStyle(fontSize: 16),),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      context.go(Paths.login);
                    },
                    child: Text('Zaloguj się', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

