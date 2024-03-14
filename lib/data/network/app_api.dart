import 'package:advanced_flutter/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/responses.dart';
part 'app_api.g.dart';
// 02
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {

  factory AppServicesClient(Dio dio , {String baseUrl}) = _AppServicesClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email ,
      @Field("password") String password
      );
}