
import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/model.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs,OnBoardingViewModelOutputs
{
  final StreamController _streamController =StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  final int _currentIndex = 0;

  // onboarding base view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();
    _postDataToView();
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
  Sink get inputSliderViewObject => _streamController.sink;

  // stream controllers for output
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onboarding private function
  List<SliderObject> _getSliderData () =>[
    SliderObject(
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1,
      image: ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2,
      image: ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3,
      image: ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle4,
      subTitle: AppStrings.onBoardingSubTitle4,
      image: ImageAssets.onBoardingLogo4,
    ),
  ];

  void _postDataToView()
  {
    inputSliderViewObject.add(SliderViewObject(
      _list[_currentIndex],
        _list.length,
        _currentIndex,
    ));
  }


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

  Stream<SliderViewObject> get outputSliderViewObject;
}


