import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_render/state_render.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRenderer();

  String getMessage();
}

// loading state (POPUP , full screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;

  String message;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() => stateRendererType;
}

class SuccessState extends FlowState {

  String message;

  SuccessState({
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() => StateRendererType.popupSuccessState;
}

// error state (POPUP , full screen)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;

  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() => stateRendererType;
}

// content state (full screen)

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRenderer() => StateRendererType.contentState;
}

// empty state (full screen)

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderer() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRenderer() == StateRendererType.popupLoadingState) {
            // show popup loading
            // show content ui of screen
            showPopup(context, getStateRenderer(), getMessage());
            return contentScreenWidget;
          } else {
            // show full screen
            return StateRenderer(
                stateRendererType: getStateRenderer(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }

      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRenderer() == StateRendererType.popupErrorState) {
            // show popup loading
            // show content ui of screen
            showPopup(context, getStateRenderer(), getMessage());
            return contentScreenWidget;
          } else {
            // show full screen
            return StateRenderer(
                stateRendererType: getStateRenderer(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }

      case SuccessState:
        {
          dismissDialog(context);

          showPopup(
              context,
              getStateRenderer(),
              getMessage(),
              title: AppStrings.success.tr(),
          );

          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRenderer(),
              message: getMessage(),
              retryActionFunction: () {});
        }

      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }

      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)!.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message , {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryActionFunction: () {}),
      ),
    );
  }
}
