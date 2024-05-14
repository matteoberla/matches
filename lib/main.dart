import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:matches/controllers/fatal_error_handler.dart';
import 'package:matches/controllers/multi_providers_handler.dart';
import 'package:matches/routes.dart';
import 'package:matches/screens/login/login.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    //
    runApp(const MyApp());
  }, (error, stackTrace) async {
    WidgetsFlutterBinding.ensureInitialized();
    FatalErrorHandler fatalErrorHandler = FatalErrorHandler();
    fatalErrorHandler.fatalError(error, stackTrace);

    throw error;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MultiProvidersHandler multiProvidersHandler = MultiProvidersHandler();

    return MultiProvider(
      providers: multiProvidersHandler.getProvidersList(),
      child: MaterialApp(
        title: 'EM2024',
        theme: Styles.themeData(false, context),
        // The Mandy red, dark theme.
        darkTheme: Styles.themeData(false, context),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.light,
        home: const LoginPage(),
        navigatorKey: navigatorKey,
        routes: routes,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('it'),
          Locale('en'),
        ],
      ),
    );
  }
}
