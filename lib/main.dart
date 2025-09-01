import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AstReader());
}

class AstReader extends StatelessWidget {
  const AstReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kName,
      theme: ThemeData(fontFamily: 'Arimo'),
      home: SplashView(),
    );
  }
}
