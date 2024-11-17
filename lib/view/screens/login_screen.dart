import 'package:flutter/material.dart';
import 'package:login_app/core/controllers/login_controller.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/view/screens/home_screen.dart';
import 'package:login_app/view/widgets/input_login.dart';

import '../../core/constants/login_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.sendLogin});

  final Future<bool> Function(Login login)? sendLogin;

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
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: SizedBox(
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
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              bool? result = await loginController.handleLogin(
                                  formLoginKey: _formLoginKey,
                                  setStateCallback: (void Function() callback) {
                                    setState(callback);
                                  },
                                  sendLoginCallback: widget.sendLogin);

                              if (result != null) {
                                if (result) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (newContext) =>
                                              const HomeScreen()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        LoginError.errorConnectingToServer,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text("Enviar",
                                style: TextStyle(color: Colors.white, fontSize: 18))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (loginController.isLoading)
              const Positioned.fill(
                  child: ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
              ))
          ],
        ),
      ),
    );
  }
}
