import 'dart:async';

import 'package:advanced_flutter/presentation/common/state_render/state_renderer_imp.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs
{
  // shared variables and function that will be used through any view model

  final StreamController _inputStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStreamController.sink;
  
  
  @override
  Stream<FlowState> get outState => _inputStreamController.stream
      .map((flowState) => flowState);
  
  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs
{
  void start(); //start view model job

  void dispose();// will be called when view model die

  Sink get inputState;
}

 mixin BaseViewModelOutputs
{
  
  Stream<FlowState> get outState;
  // will be implemented later
}