import 'dart:async';

import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';

import '../../../common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel with 
LoginViewModelInput , LoginViewModelOutput
{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  // object have last login
  var loginObject = LoginObject("" , "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs **********************
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  login() async{
    (await _loginUseCase.execute(LoginUseCaseInput(
        email: loginObject.username,
        password: loginObject.password)))
        .fold((left) => {
          // left -> failure
        },
        (data) => {
          // right -> data (success)
        });

  }


  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(username: userName);
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;


  // outputs ********************
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  bool _isPasswordValid(String password){
    return password.isNotEmpty ;
  }

  bool _isUserNameValid(String username){
    return username.isNotEmpty ;
  }

}

mixin LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;

}

mixin LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}