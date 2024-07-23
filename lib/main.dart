import 'package:flutter/material.dart';
import 'package:myapp/login/domain/login_respository.dart';
import 'package:myapp/login/infra/login_repository_impl.dart';
import 'package:myapp/login/presenter/login_store.dart';

import 'login/presenter/login_page.dart';
import 'core/service_locator.dart';

void main() {
  ServiceLocator.registerFactory<LoginRespository>(
      () => LoginRepositoryImpl());
  ServiceLocator.registerLazySingleton<LoginStore>(
      () => LoginStore(ServiceLocator.get<LoginRespository>()));

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
