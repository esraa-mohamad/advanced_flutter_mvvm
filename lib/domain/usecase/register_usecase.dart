import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequests(
        email: input.email,
        password: input.password,
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobilePhone: input.mobilePhone,
        profilePicture: input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String userName;
  String countryMobileCode;
  String mobilePhone;
  String profilePicture;

  RegisterUseCaseInput(
      {required this.email,
      required this.password,
      required this.userName,
      required this.countryMobileCode,
      required this.mobilePhone,
      required this.profilePicture});
}
