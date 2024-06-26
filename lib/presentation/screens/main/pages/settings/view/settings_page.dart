import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/data/data_source/local_data_source.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/language_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../../../../resources/strings_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          leading: SvgPicture.asset(ImageAssets.changeLanguage),
          title: Text(
            AppStrings.changeLanguage.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowSettings),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.contactUs),
          title: Text(
            AppStrings.contactUs.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowSettings),
          ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.inviteFriends),
          title: Text(
            AppStrings.inviteFriends.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing:Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRTL() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.rightArrowSettings),
          ),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          leading: SvgPicture.asset(ImageAssets.logout),
          title: Text(
            AppStrings.logout.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () {
            _logout();
          },
        ),
      ],
    ));
  }

  bool isRTL() {
    return context.locale == ARABIC_LOCALE;
  }

  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {}

  _inviteFriends() {}

  _logout() {
    // app prefs make that user logged out
    _appPreferences.loggedOut();
    _localDataSource.clearCache();
    // navigator to login screen
    Navigator.of(context).pushNamed(Routes.loginRoute);
  }
}
