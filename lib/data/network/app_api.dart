import 'package:advanced_flutter/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/responses.dart';
part 'app_api.g.dart';
// 02
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {

  factory AppServicesClient(Dio dio , {String baseUrl}) = _AppServicesClient;

  @POST("/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email ,
      @Field("password") String password
      );

  @POST("/forgetPassword")
  Future<ForgetPasswordResponse> forgetPassword(
      @Field("email") String email ,
      );

  @POST("/register")
  Future<AuthenticationResponse> register(
      @Field("email") String email ,
      @Field("password") String password,
      @Field("user_name") String userName ,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_phone") String mobilePhone ,
      @Field("profile_picture") String profilePicture,
      );

}