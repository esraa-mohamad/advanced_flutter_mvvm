import 'package:advanced_flutter/presentation/screens/login/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _loginViewModel = LoginViewModel();

  final TextEditingController  _userNameController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();

  _bind(){
    _loginViewModel.start();
    _userNameController.addListener(() => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.dispose();
  }
}
