import 'package:advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG ="PRES_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEW ="PREFS_KEY_ONBOARDING_SCREEN_VIEW";
const String PREFS_KEY_IS_USER_LOGGED_IN ="PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences ;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if(language != null && language.isNotEmpty){
      return language;
    }else{
      // return default language
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setOnBoardingScreenView() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEW, true);
  }

  Future<bool> isOnBoardingScreenView() async{
   return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEW) ?? false;
  }

  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}