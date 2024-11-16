import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/core/controllers/login_controller.dart';
import 'package:login_app/service/login_service.dart';
import 'package:login_app/view/widgets/input_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formLoginKey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formLoginKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 300,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login", style: TextStyle(fontSize: 36)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: InputLogin(
                        labelText: "Nome",
                        obscureText: false,
                        inputController: loginController.nameController,
                        validator: loginController.validateInputName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: InputLogin(
                        labelText: "Senha",
                        obscureText: true,
                        inputController: loginController.passwordController,
                        validator: loginController.validateInputPassword,
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      if(_formLoginKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tudo OK!")));
                      }
                    }, child: Text("Enviar", style: TextStyle(color: Colors.white)),
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
