import 'package:flutter/material.dart';

import 'screens/auth_choice_screen.dart';

void main() {
  runApp(const LamCode());
}

class LamCode extends StatelessWidget {
  const LamCode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthChoiceScreen(),
    );
  }
}
