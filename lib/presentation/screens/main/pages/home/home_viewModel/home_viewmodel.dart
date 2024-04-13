import 'dart:async';

import 'package:advanced_flutter/domain/usecase/home_data_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../domain/model/model.dart';
import '../../../../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<Banners>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Stores>>();

  final HomeDataUseCase _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }
}
