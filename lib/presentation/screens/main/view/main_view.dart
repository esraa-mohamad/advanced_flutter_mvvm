import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/notifications/view/notifications_page.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/search/view/search_page.dart';
import 'package:advanced_flutter/presentation/screens/main/pages/settings/view/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorManager.lightGrey,
            spreadRadius: AppSize.s1,
          )
        ]),
        child: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined), label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search), label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),
                label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.more_vert), label: AppStrings.settings.tr()),
          ],
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }

}
