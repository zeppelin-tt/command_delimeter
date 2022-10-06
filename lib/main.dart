import 'package:command_delimeter/localization/delimiter_localization.dart';
import 'package:command_delimeter/pages/main/main_page.dart';
import 'package:command_delimeter/provider/input_data_provider.dart';
import 'package:command_delimeter/provider/teams_provider.dart';
import 'package:command_delimeter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputDataProvider()..init()),
        ChangeNotifierProvider(create: (_) => TeamsProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Locale _locale = Locale('ru');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(400, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
          locale: _locale,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ru', 'RU'),
            Locale('fa', 'IR'),
            Locale('ar', 'SA'),
          ],
          localizationsDelegates: [
            DelimiterLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale?.languageCode &&
                  locale.countryCode == deviceLocale?.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}
