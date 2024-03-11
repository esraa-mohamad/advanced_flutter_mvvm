import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_render.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FlowState{

  StateRendererType getStateRenderer();
  String getMessage();
}

// loading state (POPUP , full screen)

class LoadingState extends FlowState{

  StateRendererType stateRendererType ;
  String message ;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() =>stateRendererType;

}

// error state (POPUP , full screen)

class ErrorState extends FlowState{

  StateRendererType stateRendererType ;
  String message ;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() =>stateRendererType;

}

// content state (full screen)

class ContentState extends FlowState{

  ContentState();

  @override
  String getMessage() =>Constants.empty;

  @override
  StateRendererType getStateRenderer() =>StateRendererType.contentState;

}

// empty state (full screen)

class EmptyState extends FlowState{

  String message ;
  EmptyState(this.message);

  @override
  String getMessage() =>message;

  @override
  StateRendererType getStateRenderer() =>StateRendererType.fullScreenEmptyState;

}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context , Widget contentScreenWidget , Function retryActionFunction){
    switch(runtimeType){

      case LoadingState:
        {
          if(getStateRenderer()== StateRendererType.popupLoadingState){
            // show popup loading
            // show content ui of screen
            showPopup(context , getStateRenderer() ,getMessage());
            return contentScreenWidget;
          }else{
            // show full screen
            return StateRenderer(
              stateRendererType: getStateRenderer(),
              message: getMessage(),
              retryActionFunction: retryActionFunction
            );
          }
        }

      case ErrorState:
        {
          if(getStateRenderer()== StateRendererType.popupErrorState){
            // show popup loading
            // show content ui of screen
            showPopup(context , getStateRenderer() ,getMessage());
            return contentScreenWidget;
          }else{
            // show full screen
            return StateRenderer(
                stateRendererType: getStateRenderer(),
                message: getMessage(),
                retryActionFunction: retryActionFunction
            );
          }
        }

      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRenderer(),
            message: getMessage(),
            retryActionFunction: (){}
          );
        }

      case ContentState:
        {
          return contentScreenWidget;
        }

      default :
        {
          return contentScreenWidget;
        }
    }
  }

  showPopup(BuildContext context , StateRendererType stateRendererType , String message){
    WidgetsBinding.instance.
    addPostFrameCallback(
            (_)=> showDialog(
                context: context,
                builder: (BuildContext context)=>
                    StateRenderer(
                        stateRendererType: stateRendererType,
                        message: message,
                        retryActionFunction: (){}
                    ),
            ),
    );
  }
}