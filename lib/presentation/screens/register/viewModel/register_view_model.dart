import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_class.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../app/functions.dart';
import '../../../common/state_render/state_render.dart';
import '../../../common/state_render/state_renderer_imp.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();

  // StreamController countryMobileCodeStreamController =
  //     StreamController<String>.broadcast();
  StreamController mobilePhoneStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController = StreamController<void>();
  StreamController isUserRegisterSuccessfullyStreamController =
      StreamController<bool>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject(
      email: "",
      password: "",
      userName: "",
      mobilePhone: "",
      profilePicture: "",
      countryMobileCode: "");

  // inputs
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    userNameStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    // countryMobileCodeStreamController.close();
    mobilePhoneStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      // update register view model
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset user name value in register view model
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    if (countryMobileCode.isNotEmpty) {
      // update register view model
      registerObject =
          registerObject.copyWith(countryMobileCode: countryMobileCode);
    } else {
      // reset mobile code value in register view model
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      // update register view model
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view model
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobilePhone(String mobilePhone) {
    if (_isMobilePhoneValid(mobilePhone)) {
      // update register view model
      registerObject = registerObject.copyWith(mobilePhone: mobilePhone);
    } else {
      // reset mobile phone value in register view model
      registerObject = registerObject.copyWith(mobilePhone: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      // update register view model
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view model
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      // update register view model
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profile picture value in register view model
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            email: registerObject.email,
            password: registerObject.password,
            userName: registerObject.userName,
            countryMobileCode: registerObject.countryMobileCode,
            mobilePhone: registerObject.mobilePhone,
            profilePicture: registerObject.profilePicture)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (data) {
      inputState.add(ContentState());
    //  isUserRegisterSuccessfullyStreamController.add(true);
    });
  }

  @override
  Sink get userNameInput => userNameStreamController.sink;

  @override
  Sink get emailInput => emailStreamController.sink;

  @override
  Sink get mobilePhoneInput => mobilePhoneStreamController.sink;

  @override
  Sink get passwordInput => passwordStreamController.sink;

  @override
  Sink get profilePictureInput => profilePictureStreamController.sink;

  @override
  Sink get areAllInputValid => areAllInputsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get userNameOutput => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get userNameErrorOutput => userNameOutput
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid);

  @override
  Stream<bool> get emailOutput =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get emailErrorOutput =>
      emailOutput.map((isEmail) => isEmail ? null : AppStrings.emailInvalid);

  @override
  Stream<bool> get mobilePhoneOutput => mobilePhoneStreamController.stream
      .map((mobilePhone) => _isMobilePhoneValid(mobilePhone));

  @override
  Stream<String?> get mobilePhoneErrorOutput =>
      mobilePhoneOutput.map((isMobilePhoneInvalid) =>
          isMobilePhoneInvalid ? null : AppStrings.mobilePhoneInvalid);

  @override
  Stream<bool> get passwordOutput => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get passwordErrorOutput =>
      passwordOutput.map((isPasswordInvalid) =>
          isPasswordInvalid ? null : AppStrings.passwordInvalid);

  @override
  Stream<File> get profilePictureOutput =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get areAllOutputValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // private function

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobilePhoneValid(String mobilePhone) {
    return mobilePhone.length >= 8;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobilePhone.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    areAllInputValid.add(null);
  }
}

mixin RegisterViewModelInput {
  Sink get userNameInput;

  Sink get emailInput;

  Sink get passwordInput;

  Sink get mobilePhoneInput;

  Sink get profilePictureInput;

  Sink get areAllInputValid;

  setUserName(String userName);

  setEmail(String email);

  setPassword(String password);

  setMobilePhone(String mobilePhone);

  setCountryMobileCode(String countryMobileCode);

  setProfilePicture(File profilePicture);

  register();
}

mixin RegisterViewModelOutput {
  Stream<bool> get userNameOutput;

  Stream<String?> get userNameErrorOutput;

  Stream<bool> get emailOutput;

  Stream<String?> get emailErrorOutput;

  Stream<bool> get passwordOutput;

  Stream<String?> get passwordErrorOutput;

  Stream<bool> get mobilePhoneOutput;

  Stream<String?> get mobilePhoneErrorOutput;

  Stream<File> get profilePictureOutput;

  Stream<bool> get areAllOutputValid;
}
