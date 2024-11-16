import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> _onBackPressed(BuildContext context) async {
    print("Ação personalizada antes de voltar");
    Navigator.pop(context);
    return true; // Retorna true para permitir o fechamento da tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(child: Text("Bem-vindo à Home")),
    );
  }
}
