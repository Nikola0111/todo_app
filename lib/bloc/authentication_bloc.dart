import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/model/static_strings.dart';
import 'package:todo_app/services/authentication_service.dart';

class AuthenticationBloc extends Bloc {
  final AuthenticationService _authenticationService = AuthenticationService();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _errorController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream;

  Stream<String> get passwordStream => _passwordController.stream;

  Stream<String> get errorStream => _errorController.stream;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(String) get changeError => _errorController.sink.add;

  Future<String> performLogin() async {
    String ret;

    bool conditionEmail = isValidEmail(_emailController.valueOrNull);
    bool conditionPassword = isValidPassword(_passwordController.valueOrNull);

    if (conditionEmail && conditionPassword) {
      ret = await _authenticationService.performLogin(
          _emailController.value, _passwordController.value);
    }

    if (!conditionEmail) {
      _emailController.addError("PLEASE ENTER A CORRECT EMAIL");
    }

    if (!conditionPassword) {
      _passwordController.addError("PASSWORD MUSTN'T BE EMPTY");
    }

    return ret;
  }

  changeEmailValue(String email) {
    changeEmail(email);
  }

  changePasswordValue(String password) {
    changePassword(password);
  }

  bool isValidEmail(String email) {
    if(email == null)
      return false;

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    if(password == null)
      return false;

    return password.isNotEmpty;
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _errorController.close();
  }
}
