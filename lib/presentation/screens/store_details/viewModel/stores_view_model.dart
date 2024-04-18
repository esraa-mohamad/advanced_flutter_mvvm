import 'dart:ffi';

import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/model/model.dart';
import '../../../../domain/usecase/store_details_usecase.dart';
import '../../../common/state_render/state_render.dart';
import '../../../common/state_render/state_renderer_imp.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailsUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
          (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

mixin StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

mixin StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}