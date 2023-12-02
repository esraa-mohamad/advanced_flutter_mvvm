
import 'dart:async';

import 'package:advanced_flutter/domain/model.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs,OnBoardingViewModelOutputs
{
  StreamController _streamController =StreamController<SliderViewObject>();



  // onboarding base view model inputs
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => throw UnimplementedError();

  // stream controllers for output
  @override
  // TODO: implement outputSliderViewObject
  Stream get outputSliderViewObject => throw UnimplementedError();
}

// inputs mean that "orders" that our view model will receive from view
mixin OnBoardingViewModelInputs{
  void goNext(); // when user click on right arrow or swipe left
  void goPrevious(); // when user click on left arrow or swipe right
  void onPageChanged (int index);

  // stream controller input
  Sink get inputSliderViewObject;
}

mixin OnBoardingViewModelOutputs{

  Stream get outputSliderViewObject;
}


