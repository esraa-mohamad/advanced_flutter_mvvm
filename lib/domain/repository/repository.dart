import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';

//05
abstract class Repository {

  Future<Either<Failure,Authentication>> login(LoginRequests loginRequests) ;
}