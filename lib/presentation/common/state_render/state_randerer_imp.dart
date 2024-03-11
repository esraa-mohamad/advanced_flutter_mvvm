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