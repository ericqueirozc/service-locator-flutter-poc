import 'package:flutter/material.dart';
import 'package:myapp/login/login_store.dart';

import 'login/login_page.dart';
import 'service_locator.dart';

void main() {
  ServiceLocator.registerSingleton<LoginStore>(LoginStore());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const LoginPage(),
      },
    );
  }
}
