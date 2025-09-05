import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/features/home/presentation/views/home_view.dart';
import 'package:ast_reader/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadToken();
  setupServiceLocator();
  runApp(const AstReader());
}

class AstReader extends StatelessWidget {
  const AstReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kName,
      theme: ThemeData(fontFamily: 'Arimo'),
      home: kToken == null || kToken!.isEmpty ? SplashView() : HomeView(),
    );
  }
}
