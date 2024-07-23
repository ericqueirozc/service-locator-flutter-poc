import 'package:flutter/material.dart';
import 'package:myapp/login/login_store.dart';

import '../service_locator.dart';
import 'login_credentials.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginStore _loginStore;
  late final Stream notificationListener;

  @override
  void initState() {
    super.initState();
    _loginStore = ServiceLocator.get<LoginStore>();
    _loginStore.addListener(() {
      final state = _loginStore.value;
      if (state is SuccessState) {
        Navigator.of(context).pushReplacementNamed('/home');
        return;
      }
      if (state is ErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error'),
          ),
        );
        return;
      }
      if (state is InvalidCredentialsState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials'),
          ),
        );
        return;
      }
      if (state is LoadingState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Loading'),
          ),
        );
        return;
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _loginStore.dispose();
    super.dispose();
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final loginCrentials = LoginCredentials(
                      username: usernameController.text,
                      password: passwordController.text,
                    );
                    _loginStore.login(loginCrentials);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
