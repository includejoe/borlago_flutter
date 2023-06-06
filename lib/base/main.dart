import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/providers/localization_provider.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:camera/camera.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:borlago/base/presentation/theme/theme_constants.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/base/presentation/theme/theme_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'presentation/widgets/main_page_view.dart';

// TODO: + chat ui for help screen
// TODO: + edit profile screen ui
// TODO: + edit profile request
// TODO: + create wcr request
// TODO: + locations screen ui
// TODO: + add location request
// TODO: + payments screen ui
// TODO: fix camera flashlight bug


Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  loadAppResources();
  runApp(const MyApp());
}

// function to run before splash screen is done
void loadAppResources({BuildContext? context}) async {
  final cameras = await availableCameras();
  initialize(backCamera: cameras.first);

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocalizationProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider())
        ],
        child: Consumer<LocalizationProvider>(
          builder: (context, localizationProvider, child){
            return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Consumer<AuthenticationProvider>(
                  builder: (context, authProvider, child) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      locale: localizationProvider.locale,
                      supportedLocales: AppLocalizations.supportedLocales,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
                      themeMode: themeProvider.themeMode,
                      title: 'BorlaGo',
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      home: Scaffold(
                          backgroundColor: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                          // body: authProvider.jwt != null
                          //   ? const MainPageView()
                          //   : const LoginScreen()
                        body: const MainPageView()
                      ),
                    );
                  },
                );
              }
            );
          }
        )
    );
  }
}