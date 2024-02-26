import 'package:advanced_flutter/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception{

  late Failure failure;

  ErrorHandler.handle(dynamic error){

    if(error is DioException){
      // it is an error from response
      failure = _handleError(error);
    }else{
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }

  }
}

Failure _handleError(DioException error){
  switch(error.type){

    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.badResponse:
      if(error.response != null && error.response?.statusCode! != null && error.response?.statusMessage! != null){
        return Failure(
            code: error.response?.statusCode ?? 0,
            message: error.response?.statusMessage ?? '' ,
        );
      }else{
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS ,
  NO_CONTENT ,
  BAD_REQUEST ,
  FORBIDDEN ,
  UNAUTHORIZED ,
  NOT_FOUND ,
  INTERNET_SERVER_ERROR ,
  CONNECT_TIMEOUT ,
  CANCEL ,
  RECEIVE_TIMEOUT ,
  SEND_TIMEOUT ,
  CASH_ERROR ,
  NO_INTERNET_CONNECTION ,
  DEFAULT ,
}

extension DataSourceExtension on DataSource {
  Failure getFailure()
  {
    switch(this){
      case DataSource.SUCCESS:
        return Failure(code: ResponseCode.SUCCESS, message:ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(code: ResponseCode.NO_CONTENT, message:ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(code: ResponseCode.BAD_REQUEST, message:ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(code: ResponseCode.FORBIDDEN, message:ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(code: ResponseCode.UNAUTHORIZED, message:ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(code: ResponseCode.NOT_FOUND, message:ResponseMessage.NOT_FOUND);
      case DataSource.INTERNET_SERVER_ERROR:
        return Failure(code: ResponseCode.INTERNET_SERVER_ERROR, message:ResponseMessage.INTERNET_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(code: ResponseCode.CONNECT_TIMEOUT, message:ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(code: ResponseCode.CANCEL, message:ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(code: ResponseCode.RECEIVE_TIMEOUT, message:ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(code: ResponseCode.SEND_TIMEOUT, message:ResponseMessage.SEND_TIMEOUT);
      case DataSource.CASH_ERROR:
        return Failure(code: ResponseCode.CASH_ERROR, message:ResponseMessage.CASH_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(code: ResponseCode.NO_INTERNET_CONNECTION, message:ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(code: ResponseCode.DEFAULT, message:ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200 ; // success with data
  static const int NO_CONTENT = 201 ; // success without data (no content)
  static const int BAD_REQUEST = 400 ; // failure, API rejected request
  static const int UNAUTHORIZED = 401 ;  // failure , user is not authorized
  static const int FORBIDDEN = 403 ; // failure, API rejected request
  static const int NOT_FOUND = 404 ; // failure, Not found
  static const int INTERNET_SERVER_ERROR = 500 ; // failure , crash in server side


  // local status code
  static const int CONNECT_TIMEOUT = -1 ;
  static const int CANCEL = -2 ;
  static const int RECEIVE_TIMEOUT = -3 ;
  static const int SEND_TIMEOUT = -4 ;
  static const int CASH_ERROR = -5 ;
  static const int NO_INTERNET_CONNECTION = -6 ;
  static const int DEFAULT = -7 ;
}

class ResponseMessage {
  static const String SUCCESS = "Success" ; // success with data
  static const String NO_CONTENT = "Success" ; // success without data (no content)
  static const String BAD_REQUEST = "Bad request  , try again later" ; // failure, API rejected request
  static const String UNAUTHORIZED = "User is unauthorized , try again later" ;  // failure , user is not authorized
  static const String FORBIDDEN = "Forbidden request  , try again later" ; // failure, API rejected request
  static const String NOT_FOUND = "Something went wrong  , try again later" ; // failure, API rejected request
  static const String INTERNET_SERVER_ERROR = "Something went wrong , try again later" ; // failure , crash in server side


  // local status code
  static const String CONNECT_TIMEOUT = "Time out error , try again later" ;
  static const String CANCEL = "Request was canceled , try again later" ;
  static const String RECEIVE_TIMEOUT = "Time out error , try again later" ;
  static const String SEND_TIMEOUT = "Time out error , try again later" ;
  static const String CASH_ERROR = "Cash error , try again later" ;
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection" ;
  static const String DEFAULT = "Something went wrong , try again later" ;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int Failure = 1;
}