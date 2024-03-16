// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_class.freezed.dart';

@freezed
class LoginObject with _$LoginObject {

  factory LoginObject(String username , String password) = _LoginObject ;

}

@freezed
class RegisterObject with _$RegisterObject {

  factory RegisterObject({
    required String email,
    required String password,
    required String userName,
    required String mobilePhone,
    required String profilePicture,
    required String countryMobileCode,
  }) = _RegisterObject ;

}