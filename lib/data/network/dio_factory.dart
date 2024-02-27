import 'package:advanced_flutter/app/constants.dart';
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

    Duration timeOut = const Duration(seconds: 60*1000);
    Map<String , String> headers= {
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT : APPLICATION_JSON ,
      AUTHORIZATION : "SEND TOKEN HERE" ,
      DEFAULT_LANGUAGE : "EN"  // todo get lang from app prefs
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl ,
      headers:  headers,
      receiveTimeout:  timeOut,
      sendTimeout: timeOut,
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