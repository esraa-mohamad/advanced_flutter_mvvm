
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../screens/forget_password/forget_password_view.dart';
import '../screens/login/view/login_view.dart';
import '../screens/main/main_view.dart';
import '../screens/on_boarding/view/on_boarding_view.dart';
import '../screens/register/register_view.dart';
import '../screens/splash/splash_view.dart';
import '../screens/store_details/store_details_view.dart';



class Routes
{
  static const splashRoute = "/";
  static const loginRoute = "/login";
  static const registerRoute = "/register";
  static const forgotPasswordRoute = "/forgetPassword";
  static const onBoardingRoute = "/onBoarding";
  static const mainRoute = "/main";
  static const storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(
                AppStrings.noRouteFound,
            ),
          ),
          body: const Center(
              child: Text(
                  AppStrings.noRouteFound,
              ),
          ),
        ));
  }
}


