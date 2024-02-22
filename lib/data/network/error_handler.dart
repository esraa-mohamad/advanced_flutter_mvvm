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
}

class ResponseCode {
  static const int SUCCESS = 200 ; // success with data
  static const int NO_CONTENT = 201 ; // success without data (no content)
  static const int BAD_REQUEST = 400 ; // failure, API rejected request
  static const int UNAUTHORIZED = 401 ;  // failure , user is not authorized
  static const int FORBIDDEN = 403 ; // failure, API rejected request
  static const int INTERNET_SERVER_ERROR = 500 ; // failure , crash in server side


  // local status code
  static const int CONNECT_TIMEOUT = -1 ;
  static const int CANCEL = -2 ;
  static const int RECEIVE_TIMEOUT = -3 ;
  static const int SEND_TIMEOUT = -4 ;
  static const int CASH_ERROR = -5 ;
  static const int NO_INTERNET_CONNECTION = -6 ;
  static const int UNKNOWN = -7 ;
}