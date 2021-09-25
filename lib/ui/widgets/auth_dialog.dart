import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  final Function(String password) onTap;
  const AuthDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Digite a senha'),
      content: TextField(
        maxLength: 4,
        controller: _passwordController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          prefixIcon: const Icon(Icons.enhanced_encryption),
          label: const Text(
            'Senha',
            style: TextStyle(fontSize: 16, letterSpacing: 1),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        obscureText: true,
        style: const TextStyle(fontSize: 32, letterSpacing: 24),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              widget.onTap(_passwordController.text);
              Navigator.pop(context);
            },
            child: const Text('Confirmar')),
      ],
    );
  }
}
