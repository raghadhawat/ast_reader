import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/features/splash/views/splash_view.dart';
import 'package:ast_reader/simple_bloc_observer.dart';
import 'package:ast_reader/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadToken();
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
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
      home:Test(),
    );
  }
}
