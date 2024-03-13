import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/login/viewModel/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController  _userNameController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();

  _bind(){
    _loginViewModel.start();
    _userNameController.addListener(()
    => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(()
    => _loginViewModel.setPassword(_passwordController.text));
   _loginViewModel.isUserLoggedSuccessfullyStreamController.stream.listen((isLoggedIn){
     if(isLoggedIn){
       SchedulerBinding.instance.addPostFrameCallback((_) {
         Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
       });

     }
   });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outState,
        builder: (context , snapshot){
          return snapshot.data?.getScreenWidget(context , _getContentView(), (){
            _loginViewModel.login();
          }) ??
          _getContentView() ;
        },
      ),
    );
  }

  Widget _getContentView (){
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
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
                const SizedBox(
                  height: AppSize.s30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28 , right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _loginViewModel.outAreAllInputValid,
                    builder: (context , snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ?(){_loginViewModel.login();}
                              : null,
                          child: const Text(
                            AppStrings.login,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                        },
                        child :Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child :Text(
                          AppStrings.registerText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
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
