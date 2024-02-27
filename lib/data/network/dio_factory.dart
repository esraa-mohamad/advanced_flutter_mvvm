import 'package:advanced_flutter/app/constants.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application_json";
const String CONTENT_TYPE = "content_type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "default_language";

class DioFactory{

  Future<Dio> getDio() async{
    Dio dio = Dio();


    Map<String , String> headers= {
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT : APPLICATION_JSON ,
      AUTHORIZATION : Constants.token ,
      DEFAULT_LANGUAGE : "EN"  // todo get lang from app prefs
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl ,
      headers:  headers,
      receiveTimeout:  Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
    );

    if(!kReleaseMode){
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true
      ));
    }

    return dio;
  }
}