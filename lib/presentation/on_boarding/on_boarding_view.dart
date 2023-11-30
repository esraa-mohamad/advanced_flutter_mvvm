import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  late final List<SliderObject> _list = _getSliderData();

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

  final PageController _pageController =PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index){
          setState(() {
            _currentIndex= index;
          });
        },
        itemBuilder: (context,index){

        }
      ),
    );
  }
}


class SliderObject
{
  String title;
  String subTitle;
  String image ;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}