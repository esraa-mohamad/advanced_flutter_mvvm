import 'package:advanced_flutter/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
        supportedLocales: const [ARABIC_LOCALE , ENGLISH_LOCALE],
        path: ASSET_PATH_LOCALIZATION,
        child: Phoenix(child: MyApp(),)
    ),
  );
}




