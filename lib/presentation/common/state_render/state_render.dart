import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/font_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/style_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../../resources/color_manager.dart';

enum StateRendererType {

  // POPUP STATES (DIALOGS)
  popupLoadingState ,
  popupErrorState ,
  popupSuccessState ,

  // SCREEN STATES (FULL SCREEN)
  fullScreenLoadingState ,
  fullScreenErrorState ,
  fullScreenEmptyState ,
  
  // general state
  contentState ,

}

class StateRenderer extends StatelessWidget {
   const StateRenderer({
    required this.stateRendererType ,
    this.message = AppStrings.loading ,
    this.title = AppStrings.title ,
    required this.retryActionFunction ,
    super.key
  });

  final StateRendererType stateRendererType ;
  final String message ;
  final String title ;
  final Function retryActionFunction ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getStateWidget(context),
    );
  }


  Widget _getStateWidget(BuildContext context){
    switch(stateRendererType){

      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context , [
          _getAnimatedImage(JsonAssets.loading)
        ]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context , [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.popupSuccessState :
        return _getPopupDialog(context , [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumns([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemColumns([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain.tr(), context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumns([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context , List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s18),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,

            ),
          ]
        ),
        child: _getDialogContent(context , children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context , List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(
        animationName ,
      ),
    );
  }

  Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message ,
          style: getRegularStyle(
              color: ColorManager.black,
              fontSize: FontSize.s18,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle , BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: ()
              {
                if(stateRendererType == StateRendererType.fullScreenErrorState){
                  // call retry function
                  retryActionFunction.call();
                }else { // popup error
                  Navigator.pop(context);
                }
              },
              child: Text(
                buttonTitle
              ),
          ),
        ),
      ),
    );
  }

   Widget _getItemColumns(List<Widget> children){
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: children,
     );
   }

}
