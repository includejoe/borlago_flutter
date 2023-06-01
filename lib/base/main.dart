import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:borlago/base/presentation/theme/theme_constants.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/base/presentation/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: _locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              themeMode: themeProvider.themeMode,
              title: 'BorlaGo',
              // theme: darkTheme,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: const LoginScreen()
              ),
            );
          }
        )
    );
  }
}
