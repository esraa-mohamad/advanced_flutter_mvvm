import 'dart:async';

import 'package:advanced_flutter/domain/model/model.dart';
import 'package:advanced_flutter/presentation/base/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';


class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs,OnBoardingViewModelOutputs
{
  final StreamController _streamController =StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;

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
  int goNext() {
    int nextIndex= ++_currentIndex;
    if(nextIndex == _list.length)
    {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex= --_currentIndex;
    if(previousIndex == -1)
    {
      previousIndex = _list.length-1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex= index ;
    _postDataToView();
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
      title: AppStrings.onBoardingTitle1.tr(),
      subTitle: AppStrings.onBoardingSubTitle1.tr(),
      image: ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle2.tr(),
      subTitle: AppStrings.onBoardingSubTitle2.tr(),
      image: ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle3.tr(),
      subTitle: AppStrings.onBoardingSubTitle3.tr(),
      image: ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      title: AppStrings.onBoardingTitle4.tr(),
      subTitle: AppStrings.onBoardingSubTitle4.tr(),
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
  int goNext(); // when user click on right arrow or swipe left
  int goPrevious(); // when user click on left arrow or swipe right
  void onPageChanged (int index);

  // stream controller input
  Sink get inputSliderViewObject;
}

mixin OnBoardingViewModelOutputs{

  Stream<SliderViewObject> get outputSliderViewObject;
}


