import 'package:advanced_flutter/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel with 
LoginViewModelInput , LoginViewModelOutput
{

  // inputs **********************
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Sink password() {
    // TODO: implement password
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  Sink userName() {
    // TODO: implement userName
    throw UnimplementedError();
  }

  // outputs *******************
  @override
  Stream<bool> outIsPasswordValid() {
    // TODO: implement outIsPasswordValid
    throw UnimplementedError();
  }

  @override
  Stream<bool> outIsUserNameValid() {
    // TODO: implement outIsUserNameValid
    throw UnimplementedError();
  }



}

mixin LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink userName();
  Sink password();

}

mixin LoginViewModelOutput {
  Stream<bool> outIsUserNameValid();
  Stream<bool> outIsPasswordValid();
}