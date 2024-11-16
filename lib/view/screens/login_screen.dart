import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/core/controllers/login_controller.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/service/login_service.dart';
import 'package:login_app/view/screens/home_screen.dart';
import 'package:login_app/view/widgets/input_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();
  final LoginService loginService = LoginService();

  bool isLoading = false;

  Future<bool> sendLogin(Login login) async {
    return await loginService.sendPassword(login);
  }

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    if (_formLoginKey.currentState!.validate()) {
      Login login = Login(
        name: loginController.nameController.text,
        password: loginController.passwordController.text,
      );

      bool response = await sendLogin(login);

      setState(() {
        isLoading = false;
      });

      if (response) {
        Navigator.push(context, MaterialPageRoute(builder: (newContext) => HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Ocorreu um problema ao tentar conectar com o servidor. Por favor, tente novamente mais tarde.",
            ),
          ),
        );
      }
    }
  }

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
                        child: ElevatedButton(
                            onPressed: handleLogin,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text("Enviar",
                                style: TextStyle(color: Colors.white))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
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
