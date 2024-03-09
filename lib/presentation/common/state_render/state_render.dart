import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {

  // POPUP STATES (DIALOGS)
  popupLoadingState ,
  popupErrorState ,

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
    return const Placeholder();
  }
}
