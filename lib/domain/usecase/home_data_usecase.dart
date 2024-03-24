import 'package:advanced_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeDataUseCase implements BaseUseCase<void,HomeModel>{

  final Repository _repository;
  HomeDataUseCase(this._repository);

  @override
  Future<Either<Failure, HomeModel>> execute(void input) async{

    return await _repository.getHomeData();
  }

}