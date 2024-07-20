import 'package:flutter/material.dart';
import 'package:myapp/login/login_credentials.dart';
import 'package:myapp/login/login_repository.dart';

import 'login_state.dart';

class LoginStore {
  final ValueNotifier<LoginState> _state;

  LoginStore(this._state);

  void setState(LoginState state) {
    _state.value = state;
  }

  Future<void> login(LoginCredentials loginCredentials) async {
    if (!loginCredentials.isValid()) {
      setState(InvalidCredentialsState());
      return;
    }
    setState(LoadingState());
    final hasLogedSuccefully = await LoginRepository().login(loginCredentials);
    if (!hasLogedSuccefully) {
      setState(ErrorState());
      return;
    }
    setState(SuccessState());
  }
}
