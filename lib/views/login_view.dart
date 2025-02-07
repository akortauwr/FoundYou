import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool stayLoogedIn = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'FoundYou',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                controller: emailController,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'hasło',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: passwordController,
                obscureText: true,

              ),

              SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  print(emailController.text + passwordController.text);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text('zaloguj się'),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            value: stayLoogedIn,
                            onChanged: (bool? newValue) {
                              setState(() {
                                stayLoogedIn = newValue ?? false;
                              });
                            }),
                      ),
                      const SizedBox(width: 8),
                      const Text('zapamiętaj mnie'),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      print('zapomniałem hasła');
                    },
                    child: const Text('zapomniałem hasła'),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text('nie masz konta?'),
              GestureDetector(
                onTap: () {
                  print('zarejestruj się');
                },
                child: const Text('zarejestruj się'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
