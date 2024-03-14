import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/data/response/responses.dart';
// 07
abstract class RemoteDataSource{

  Future<AuthenticationResponse> login(LoginRequests loginRequests);

  Future<ForgetPasswordResponse> forgetPassword(String email);
}

class RemoteDataSourceImplementation implements RemoteDataSource {

  final AppServicesClient _appServicesClient;

  RemoteDataSourceImplementation(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServicesClient.login(
        loginRequests.email,
        loginRequests.password
    );
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async{
    return await _appServicesClient.forgetPassword(email);
  }
  
}