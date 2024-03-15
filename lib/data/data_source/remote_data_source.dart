import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/data/response/responses.dart';

// 07
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);

  Future<ForgetPasswordResponse> forgetPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequests registerRequests);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImplementation(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServicesClient.login(
        loginRequests.email, loginRequests.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    return await _appServicesClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequests registerRequests) async {
    return await _appServicesClient.register(
        registerRequests.email,
        registerRequests.password,
        registerRequests.userName,
        registerRequests.countryMobileCode,
        registerRequests.mobilePhone,
      registerRequests.profilePicture,
    );
  }
}
