import 'dart:async';

import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_render.dart';

import '../../../../app/di.dart';
import '../../../common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel with 
LoginViewModelInput , LoginViewModelOutput
{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _outAllInputValidStreamController = StreamController<void>.broadcast();
  StreamController isUserLoggedSuccessfullyStreamController = StreamController<bool>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  // object have last login
  var loginObject = LoginObject("" , "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  //LoginViewModel();

  // inputs **********************
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _outAllInputValidStreamController.close();
    isUserLoggedSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show loading state
    inputState.add(ContentState());
  }

  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(LoginUseCaseInput(
        email: loginObject.username,
        password: loginObject.password)))
        .fold((failure) => {
          inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
        },
        (data)  {
          inputState.add(ContentState());
          _appPreferences.setUserLoggedIn();
          isUserLoggedSuccessfullyStreamController.add(true);
        });

  }


  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    areAllInputValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(username: userName);
    areAllInputValid.add(null);
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get areAllInputValid => _outAllInputValidStreamController.sink;


  // outputs ********************
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));


  @override
  Stream<bool> get outAreAllInputValid => _outAllInputValidStreamController.stream
      .map((_) => _areAllValidInput());

  bool _isPasswordValid(String password){
    return password.isNotEmpty ;
  }

  bool _isUserNameValid(String username){
    return username.isNotEmpty ;
  }

  bool _areAllValidInput(){
    return _isUserNameValid(loginObject.username)
        && _isPasswordValid(loginObject.password);
  }


}

mixin LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get areAllInputValid;

}

mixin LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputValid;
}