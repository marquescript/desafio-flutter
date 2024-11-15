import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/view/widgets/input_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formLoginKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login", style: TextStyle(fontSize: 36)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: InputLogin(labelText: "Nome", obscureText: false),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: InputLogin(labelText: "Senha", obscureText: true),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(onPressed: (){}, child: Text("Enviar", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
