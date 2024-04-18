import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/usecase/home_data_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../domain/model/model.dart';
import '../../../../../base/base_view_model.dart';
import '../../../../../common/state_render/state_render.dart';
import '../../../../../common/state_render/state_renderer_imp.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutPut {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<Banners>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Stores>>();

  final HomeDataUseCase _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  // *** inputs ***
  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeDataUseCase.execute(Void))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data?.banners);
      inputServices.add(homeObject.data?.services);
      inputStores.add(homeObject.data?.stores);
    });
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // *** outputs ***
  @override
  Stream<List<Banners>> get outputBanners =>
      _bannersStreamController.stream.map((listBanners) => listBanners);

  @override
  Stream<List<Services>> get outputServices =>
      _servicesStreamController.stream.map((listServices) => listServices);

  @override
  Stream<List<Stores>> get outputStores =>
      _storesStreamController.stream.map((listStores) => listStores);
}

mixin HomeViewModelInput {
  Sink get inputStores;

  Sink get inputBanners;

  Sink get inputServices;
}

mixin HomeViewModelOutPut {
  Stream<List<Stores>> get outputStores;

  Stream<List<Banners>> get outputBanners;

  Stream<List<Services>> get outputServices;
}

