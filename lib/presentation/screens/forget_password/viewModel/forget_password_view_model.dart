import 'dart:async';


import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_render.dart';


import '../../../../app/functions.dart';
import '../../../../domain/usecase/forget_password_usecase.dart';



class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController =
  StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
  StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  // input
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (authObject) {
      inputState.add(ContentState());
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  // output
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());


  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}
mixin ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

mixin ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}