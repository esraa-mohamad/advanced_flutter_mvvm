import 'package:advanced_flutter/data/data_source/local_data_source.dart';
import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
//
class RepositoryImpl implements Repository{

  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource ;
  final NetworkInfo _networkInfo ;

  RepositoryImpl(this._remoteDataSource , this._networkInfo , this._localDataSource);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests) async {

    if(await _networkInfo.isConnected){

      try {
        final response = await _remoteDataSource.login(loginRequests);
        if(response.status == ApiInternalStatus.SUCCESS){
          // success
          // either right
          // return data
          return Right(response.toDomain());
        }else{
          // failure
          // either left
          //return business error
          return Left(Failure(
              code:  ApiInternalStatus.Failure ,
              message: response.message ?? ResponseMessage.DEFAULT
          ));
        }
      }catch(error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      // return internet connected error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if(await _networkInfo.isConnected){

      try {
        final response = await _remoteDataSource.forgetPassword(email);
        if(response.status == ApiInternalStatus.SUCCESS){
          // success
          // either right
          // return data
          return Right(response.toDomain());
        }else{
          // failure
          // either left
          //return business error
          return Left(Failure(
              code:  response.status ?? ResponseCode.DEFAULT ,
              message: response.message ?? ResponseMessage.DEFAULT
          ));
        }
      }catch(error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      // return internet connected error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequests registerRequests) async{
    if(await _networkInfo.isConnected){

      try {
        final response = await _remoteDataSource.register(registerRequests);
        if(response.status == ApiInternalStatus.SUCCESS){
          // success
          // either right
          // return data
          return Right(response.toDomain());
        }else{
          // failure
          // either left
          //return business error
          return Left(Failure(
              code:  ApiInternalStatus.Failure ,
              message: response.message ?? ResponseMessage.DEFAULT
          ));
        }
      }catch(error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      // return internet connected error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {

    try{
      final response = await _localDataSource.getHomeData();

      return Right(response.toDomain());
      // get  from cache
    }catch(errorCaching){
      // cache is not existing or cache is not valid

      // its time to get from API side
      if(await _networkInfo.isConnected){

        try {
          final response = await _remoteDataSource.getHomeData();
          if(response.status == ApiInternalStatus.SUCCESS){
            // success
            // either right
            // return data
            // save home response to cache
            _localDataSource.saveHomeCache(response);
            return Right(response.toDomain());
          }else{
            // failure
            // either left
            //return business error
            return Left(Failure(
                code:  response.status ?? ResponseCode.DEFAULT ,
                message: response.message ?? ResponseMessage.DEFAULT
            ));
          }
        }catch(error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      }else{
        // return internet connected error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }

  }

}