import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/login/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final LoginViewModel _loginViewModel;

  final _formKey = GlobalKey<FormState>();

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

  Widget _getContentView (){
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:   Column(
              children: [
                const Center(
                  child: Image(
                    image: AssetImage(ImageAssets.splashLogo),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _loginViewModel.outIsUserNameValid,
                      builder: (context , snapshot){
                        return TextFormField(
                          keyboardType:  TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username ,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError,

                          ),
                        );
                      },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outIsPasswordValid,
                    builder: (context , snapshot){
                      return TextFormField(
                        keyboardType:  TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password ,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordError,

                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.dispose();
  }
}
