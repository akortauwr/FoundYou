import 'package:flutter/material.dart';
import 'package:found_you_app/ui/auth/reset_password/view_models/reset_password_view_model.dart';

class ResetPasswordView extends StatefulWidget{
  final ResetPasswordViewModel viewModel;
  const ResetPasswordView({Key? key, required this.viewModel});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView>{
  final TextEditingController _email = TextEditingController(text: '');

  @override
  void initState(){
    super.initState();
    widget.viewModel.resetPassword.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant ResetPasswordView oldWidget){
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.resetPassword.removeListener(_onResult);
    widget.viewModel.resetPassword.addListener(_onResult);
  }

  @override
  void dispose(){
    widget.viewModel.resetPassword.removeListener(_onResult);
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Reset Password'),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.viewModel.resetPassword.execute(_email.text),
              child: const Text('Reset Password'),
            ),
            const SizedBox(height: 8.0),
            if(widget.viewModel.resetPassword.error)
              Text(
                widget.viewModel.resetPassword.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8.0),

          ],
        ),
      ),
    );
  }

  void _onResult(){
    if(widget.viewModel.resetPassword.completed){

    }
  }
}