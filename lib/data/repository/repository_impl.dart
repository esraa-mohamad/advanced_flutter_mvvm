import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource ;
  final NetworkInfo _networkInfo ;

  RepositoryImpl(this._remoteDataSource , this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests) async {

    if(await _networkInfo.isConnected){
      // its connected to internet , its safe to call API
      final response = await _remoteDataSource.login(loginRequests);
      if(response.status == 0){
        // success
        // either right
        // return data
        return Right(response.toDomain());
      }else{
        // failure
        // either left
        //return business error
        return Left(Failure(
            code:  409 ,
            message: response.message ?? "Business Error message"
        ));
      }
    }else{
      // return internet connected error
      return Left(Failure(
          code:  501 ,
          message:"Check your internet connection "
      ));
    }
  }

}