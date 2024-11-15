import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  final String labelText;
  final bool obscureText;

  InputLogin({super.key, required this.labelText, required this.obscureText});

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
