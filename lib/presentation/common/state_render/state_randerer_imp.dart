import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_render.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

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