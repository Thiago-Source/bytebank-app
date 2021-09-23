import 'package:flutter/material.dart';
import 'ui/pages/home_page.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bytebank',
      theme: theme.copyWith(
        primaryColor: Colors.green[600],
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green[600],
          secondary: Colors.blueAccent,
          primaryVariant: Colors.greenAccent.shade700,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.greenAccent,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.greenAccent.shade700,
        ),
      ),
      home: const HomePage(),
    );
  }
}
