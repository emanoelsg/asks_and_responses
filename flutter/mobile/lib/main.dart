// main.dart
import 'package:flutter/material.dart';

// ignore: unused_import
import 'view/pages/home_page.dart';

void main() {
  runApp(const PerguntasApp());
}


class PerguntasApp extends StatelessWidget {
  const PerguntasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asks and Responses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // home: const PerguntasScreen(),
    );
  }
}
