import 'package:flutter/material.dart';
import 'package:myapp/login/domain/login_credentials.dart';

import '../domain/login_respository.dart';
import 'login_state.dart';

class LoginStore extends ValueNotifier<LoginState> {
  final LoginRespository _loginRespository;

  LoginStore(this._loginRespository) : super(CredentialUncheckedState());

  void setState(LoginState state) {
    value = state;
  }

  Future<void> login(LoginCredentials loginCredentials) async {
    if (!loginCredentials.isValid()) {
      setState(InvalidCredentialsState());
      return;
    }
    setState(LoadingState());
    final hasLogedSuccefully = await _loginRespository.login(loginCredentials);
    if (!hasLogedSuccefully) {
      setState(ErrorState());
      return;
    }
    setState(SuccessState());
  }
}
